//
//  ViewController.swift
//  Meaningfull
//
//  Created by Oleksandr Ignatenko on 19/03/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

protocol NiceActiveModel {
    /* weak */ var controller: NiceController { get }

    // all interfaces should be async
}

protocol NiceController {
    func modelDidChange(_ model: NiceActiveModel)
}

class NiceViewController: UIViewController {
    struct State {

    }

    // var view: UIView! - inherited property
    var model: NiceActiveModel!
    private(set) var state = State()
}

extension NiceViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // listen to view changes here
    // on every chagne derive and set new state
    // when required inform model to persist change or take business related actions
}

extension NiceViewController: NiceController {

    // listen to model changes here

    func modelDidChange(_ model: NiceActiveModel) {
        // convert model to state, than:
        let newState = State()
        setState(newState)
    }
}

extension NiceViewController {
    func setState(_ state: State) {
        // update view or pass state to view
    }
}

protocol NetworkDetailsModel {

}

protocol DeviceListModel {

}

protocol PhotoGaleryModel {

}

protocol ViewControllerFactory: class {
    static func networkDetails(_ model: NetworkDetailsModel) -> UIViewController
    static func deviceList(_ model: DeviceListModel) -> UIViewController
    static func photoGalery(_ model: PhotoGaleryModel) -> UIViewController
}

extension UIViewController: ViewControllerFactory {
    class func networkDetails(_ model: NetworkDetailsModel) -> UIViewController { return UIViewController() }
    class func deviceList(_ model: DeviceListModel) -> UIViewController { return UIViewController() }
    class func photoGalery(_ model: PhotoGaleryModel) -> UIViewController { return UIViewController() }
}

class NavigationRouter {
    func open(_ url: URL) -> Bool {
        return true
    }

    func navigationGraph(_ url: URL) -> String {
        return ""
    }
}
