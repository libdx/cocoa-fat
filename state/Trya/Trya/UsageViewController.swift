//
//  AnotherViewController.swift
//  Trya
//
//  Created by Oleksandr Ignatenko on 09/02/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

enum Result<A, E> {
    case success(A)
    case failure(E)
}

extension Result {
    var error: E? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

struct Usage {
    var total: Double
    var used: Double
    var limit: Double
}

protocol UsagePresenter: class {
    func present(state: UsageState)
}

protocol UsageDataLoader {
    weak var presenter: UsagePresenter? { get set }
    func startLoading()
}

protocol UsageDataStorage {
    func apply(change: UsageChange)
    func save()
}

enum UsageState {
    case initial
    case waiting
    case loaded(Usage)
    case invalidInput(Usage)
}

extension UsageState {

    typealias ViewState = UsageViewController.ViewState

    var viewState: ViewState {
        let viewState: ViewState
        switch self {
        case .initial:
            viewState = ViewState(isActivityIndicatorShown: false, totalText: "", usedText: "")
        case .waiting:
            viewState = ViewState(isActivityIndicatorShown: true, totalText: "", usedText: "")
        case .loaded(let usage):
            let usedPercents = ceil(usage.used / usage.total) * 100
            viewState = ViewState(isActivityIndicatorShown: false, totalText: "\(usage.total) %", usedText: "\(usedPercents) %")
        case .invalidInput(let usage):
            // add to ViewState notion of limit text being invalid
            let usedPercents = ceil(usage.used / usage.total) * 100
            viewState = ViewState(isActivityIndicatorShown: false, totalText: "\(usage.total) %", usedText: "\(usedPercents) %")
        }
        return viewState
    }
}

enum UsageChange /* aka Action */ {
    case setLimit(String) // String represents view state
    case increaseTotal // aka pay more money
}

final class UsageView: UIView {
    let limitTextField: UITextField!

    func update(with model: UsageViewController.ViewState) {
        // update
    }

    init() {
        limitTextField = UITextField()
        super.init(frame: CGRect())
    }

    required init?(coder aDecoder: NSCoder) {
        limitTextField = UITextField()
        super.init(coder: aDecoder)
    }
}

final class UsageViewController: UIViewController, UsagePresenter {

    struct ViewState {
        var isActivityIndicatorShown: Bool
        var totalText: String
        var usedText: String
    }

    typealias State = UsageState

    private var currentState: State = .initial
    var usageView = UsageView()

    var dataLoader: UsageDataLoader!
    var dataStorage: UsageDataStorage!

    func present(state: State) {
        let viewState = self.viewState(from: state)
        usageView.update(with: viewState)
    }

    func viewState(from state: State) -> ViewState {
        return state.viewState
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataLoader.presenter = self
        dataLoader.startLoading()
    }

    func limitTextFieldDidChange() {
        let text = usageView.limitTextField.text
        if let text = text {
            dataStorage.apply(change: .setLimit(text))
        }
    }
}

final class UsageInteractor {
    let loader = Loader()
    let storage = Storage()

    init() {
        loader.interactor = self
        storage.interactor = self
    }
}

extension UsageInteractor {
    // put business logic here

//    private func isLimitInputValid(_ text: String) -> Bool {
//        // check for digits
//        return true
//    }

    private func parseLimit(text: String) -> Double? {
        return Double(text)
    }

    func limit(from text: String) -> Result<Double, ProcessingError> {
        if let newLimit = parseLimit(text: text) {
            return .success(newLimit)
        } else {
            return .failure(.invalidLimit)
        }
    }
}

extension UsageInteractor {
    enum ProcessingError: Error {
        case invalidLimit
    }
}

extension UsageInteractor {
    final class Loader: UsageDataLoader {

        weak var interactor: UsageInteractor!

        weak var presenter: UsagePresenter?

        func startLoading() {
            presenter?.present(state: .waiting)
            // start any background jobs

            // on completion present some state:
            let usage = interactor.storage.currentUsage
            let state: UsageState = .loaded(usage)
            presenter?.present(state: state)
        }

        // Loader must listen to Storage changes

        func storageDidChange(usage: Usage) {
            presenter?.present(state: .loaded(usage))
        }

        func storageFailedToChange(usage: Usage, error: ProcessingError) {
            switch error {
            case .invalidLimit:
                presenter?.present(state: .invalidInput(usage))
            }
        }
    }
}

extension UsageInteractor {
    final class Storage: UsageDataStorage {

        weak var interactor: UsageInteractor!

        private(set) var currentUsage = Usage(total: 120, used: 15, limit: 60)

        func apply(change: UsageChange) {
            switch change {
            case .setLimit(let text):
                let result = interactor.limit(from: text)
                if case .success(let newLimit) = result {
                    currentUsage.limit = newLimit
                }
                distribute(usage: currentUsage, error: result.error)
            default:
                break
            }
        }

        func distribute(usage: Usage, error :ProcessingError?) {
            // distribute usage model in memory accross all interested listeners

            if let error = error {
                interactor.loader.storageFailedToChange(usage: usage, error: error)
            } else {
                interactor.loader.storageDidChange(usage: usage)
            }

        }

        func save() {
            // save to database
        }

        // if using CoreData listen to notifications
        // merge contexts
        // present state with usage object using main queue context

    }
}
