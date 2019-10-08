//
//  ViewController.swift
//  MVC1
//
//  Created by Oleksandr Ignatenko on 31/07/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

typealias UserID = String
typealias ProductID = String

enum QState {
    case initial
}

protocol QModel {
    var delegate: QModelDelegate { get set }

    func requestData(with userID: UserID, tag: String)
    func deleteProduct(userID: UserID, productID: ProductID)

    func start()
    func stop()
    func save()
}

protocol QModelDelegate {
    func modelDidChangeState(_ model: QModel, state: QState)
}

class QViewController<Model: QModel>: UIViewController, QModelDelegate {

    var state: QState = .initial
    var model: Model!

    override func viewDidLoad() {
        super.viewDidLoad()

        model.delegate = self

        model.start()
    }

    func modelDidChangeState(_ model: QModel, state: QState) {

    }
}

