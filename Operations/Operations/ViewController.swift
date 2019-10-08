//
//  ViewController.swift
//  Operations
//
//  Created by Oleksandr Ignatenko on 25/05/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

// Abstract interface

protocol Interactor: class {
    associatedtype Action
    func dispatch(action: Action)
    init()
}

protocol Presenter: class {
    associatedtype State
    var sendState: ((State) -> ())! { get set }
    init()
}

protocol Component /* aka View */ : class {
    associatedtype State
    associatedtype P: Presenter
    associatedtype I: Interactor
    func didReceiveNewState(_ state: State)
    var presenter: P! { get set }
    var interactor: I! { get set }
    init()
}

// Specific scene (module, component)

enum ABCAction /* aka Request */ {

}

struct ABCLoadedState {
    var title: String
    var items: [Any]
}

extension ABCLoadedState {
    struct Diff {
        var insertedItems: [Any]
        var deletedItems: [Any]
    }
}

enum ABCState {
    case initial
    case loading
    case loaded(value: ABCLoadedState)
}

final class ABCPresenter: Presenter {
    typealias State = ABCState
    var sendState: ((State) -> ())!
    init() {}
}

final class ABCInteractor: Interactor {
    typealias Action = ABCAction
    func dispatch(action: Action) {

    }
    init() {}
}

final class ABCViewController<I: Interactor, P: Presenter>: UIViewController, Component {
    typealias State = P.State
    var state: ABCState = .initial
    var presenter: P!
    var interactor: I!

    func didReceiveNewState(_ state: State) {

    }
}

// Generic factory function

func makeComponent<C: Component>() -> C where C.State == C.P.State, C: UIViewController {
    let interactor = C.I()
    let presenter = C.P()

    let viewController = C()
    viewController.presenter = presenter
    viewController.interactor = interactor

    // Having `sendState` closure prevents having unresolvable cycled dependency with generics
    presenter.sendState = { [weak viewController] state in
        viewController?.didReceiveNewState(state)
    }

    return viewController
}

// `makeComponent` usage example

func makeABCViewController() -> ABCViewController<ABCInteractor, ABCPresenter> {
    return makeComponent()
}

///////////

protocol Proto {
    associatedtype State
    func state(_ s: State)
}

class Impl: Proto {
    typealias State = Int
    func state(_ s: State) {}
}

class FloatImpl: Proto {
    typealias State = Float
    func state(_ s: State) {}
}

class Master<P: Proto> {

}

func sample() -> Master<Impl> {
    let m: Master<Impl> = makeMaster()
    return m
}

func makeMaster<T: Proto>() -> Master<T> where T.State == Int {
    let m = Master<T>()
    return m
}

//////////

struct Video: Codable {
    var id: String
    var title: String
    var duration: Double
    var isLiked: Bool
}

struct SearchState: Codable {
    var term: String
    var searchKey: String
    var found: [Video]
}

struct List {
    var sections: [Section]
}

extension List {
    struct Row {
        var id: String
    }

    struct Section {
        var id: String
        var rows: [Row]
    }
}

struct Form {

}

struct ProfileState {
    var form: Form
//    var model
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchState = SearchState(
            term: "funny",
            searchKey: "title",
            found: [Video(id: "42", title: "funny cats", duration: 240, isLiked: false)]
        )
        let data = try! JSONEncoder().encode(searchState)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        let aSearchState = try! JSONDecoder().decode(SearchState.self, from: data)

        let op1 = BaseOperation(name: "first")
        let op2 = BaseOperation(name: "second")
        let op3 = BaseOperation(name: "third")

        op1.addDependency(op2)

        op2.cancel()

        let q = OperationQueue()
        q.addOperation(op1)
        q.addOperation(op2)
        q.addOperation(op3)
    }
}

class BaseOperation: Operation {
    private(set) var isFailed = false

    init(name: String) {
        super.init()
        self.name = name
    }

    override func main() {
//        if name == "second" {
//            isFailed = true
//            cancel()
//            return
//        }

//        let failedDeps = dependencies.filter { op in
//            guard let op = (op as? BaseOperation) else {
//                return true
//            }
//            return !op.isFailed
//        }
//
//        guard failedDeps.isEmpty else {
//            self.cancel()
//            return
//        }

        let thread = Thread.current
        print("\(name!) says hi from \(thread)")
    }

    func addDependencies(_ ops: [Operation]) {
        for op in ops {
            addDependency(op)
        }
    }
}

class ConcurrentOperation: BaseOperation {}

class DiskOperation: BaseOperation {}

class NetworkOperation: ConcurrentOperation {}

final class SaveOperation: BaseOperation {}

final class LoginOperation: NetworkOperation {}

final class LoadProfileOperation: NetworkOperation {}

final class LoadVideoListOperation: NetworkOperation {}

final class LoadVideoOperation: NetworkOperation {
    init(name: String, videoID: String) {
        super.init(name: name)
    }
}

class BaseOperationQueue: OperationQueue {
    init(name: String) {
        super.init()
        self.name = name
    }
}

enum SomeAction {
    case login(username: String, password: String)
    case loadVideoList
    case loadVideo(id: String)
}

class SomeInteractor {

    let queue = BaseOperationQueue(name: "General Queue")
    let networkQueue = BaseOperationQueue(name: "Network Queue")
    let diskQueue = BaseOperationQueue(name: "Disk Queue")

    func enqueu(operation op: BaseOperation, after others: [BaseOperation]) -> BaseOperation {
        op.addDependencies(others)
        queue.addOperation(op)
        return op
    }

    @discardableResult
    func save(after others: [BaseOperation]) -> BaseOperation {
        let op = SaveOperation(name: "Save")
        return enqueu(operation: op, after: others)
    }

    func loadProfile(after others: [BaseOperation]) -> BaseOperation {
        let op = LoadProfileOperation(name: "Load Profile")
        return enqueu(operation: op, after: others)
    }

    func login(username: String, password: String) -> BaseOperation {
        let op = LoginOperation(name: "Login")
        return enqueu(operation: op, after: [])
    }

    func loadVideo(with id: String) -> BaseOperation {
        let op = LoadVideoOperation(name: "Load Video \(id)", videoID: id)
        return enqueu(operation: op, after: [])
    }

    @discardableResult
    func prefetchSomeData() -> BaseOperation {
        return BaseOperation(name: "Prefetch")
    }

    func handle(action: SomeAction) {
        switch action {
        case .login(let username, let password):
            performLogin(username: username, password: password)
        case .loadVideoList: break
        case .loadVideo(let id):
            performLoadVideoList(id: id)
        }
    }

    func performLogin(username: String, password: String) {
        let loginOp = login(username: username, password: password)
        let loadProfileOp = loadProfile(after: [loginOp])
        save(after: [loadProfileOp])

        prefetchSomeData()
    }

    func performLoadVideoList(id: String) {
        let loadVideoOp = loadVideo(with: id)
        save(after: [loadVideoOp])
    }

    func performLoadAllVideos(ids: [String]) {
        let loadOps = ids.map { loadVideo(with: $0) }
        save(after: loadOps)
    }
}

