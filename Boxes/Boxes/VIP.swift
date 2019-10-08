//
//  VIP.swift
//  Boxes
//
//  Created by Oleksandr Ignatenko on 28/07/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import Foundation
import UIKit

struct FRequest {
    struct Prepare {}
    enum Change {
        case title(String?)
        case description(String?)
    }
    struct Load {
        var id: String
    }
    struct Save {}
}

struct FResponse {}

struct FViewState {}

protocol FInteractorInput {
    func performRequest(_ r: FRequest.Prepare)
    func performRequest(_ r: FRequest.Change)
    func performRequest(_ r: FRequest.Load)
    func performRequest(_ r: FRequest.Save)
}

protocol FPresenterInput {
    func viewState(from response: FResponse, with oldState: FViewState) -> FViewState
}

class FInteractor: FInteractorInput {
    func performRequest(_ r: FRequest.Prepare) {}
    func performRequest(_ r: FRequest.Change) {}
    func performRequest(_ r: FRequest.Load) {}
    func performRequest(_ r: FRequest.Save) {}
}

class FPresenter: FPresenterInput {
    func viewState(from response: FResponse, with oldState: FViewState) -> FViewState {
        return oldState
    }
}
