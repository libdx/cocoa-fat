//
//  Experimental.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 14/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

@objc protocol SceneObservingDelegate {}

protocol SceneObserving {
    var delegate: SceneObservingDelegate? { get set }

    init(_ delegate: SceneObservingDelegate)

    func subscribe()
    func unsubscribe()
}

extension SceneObserving {
    func subscribe() {
        // add observer...
    }

    private func fileSystemDidChange(_ notification: Notification) {

    }
}

protocol BaseWorking {
    func start()
    func stop()
}

protocol SceneWorking: BaseWorking {
    var filename: String { get set }

    init()
    init(_ filename: String)
}

extension SceneWorking {
    init(_ filename: String) {
        self.init()
        self.filename = filename
    }

    func start() {}
    func stop() {}
}

final class SceneAutosaveWorker: SceneWorking {
    var filename: String = ""
}
