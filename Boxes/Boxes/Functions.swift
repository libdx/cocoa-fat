//
//  Functions.swift
//  Boxes
//
//  Created by Oleksandr Ignatenko on 28/07/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

struct GInitRequest {}
struct GOrdersRequest {}
struct GDeleteProductRequest {}

struct GInitResponse {}
struct GOrdersResponse {}
struct GDeleteProductResponse {}

struct GViewState {}

func performRequest(_ request: GInitRequest, onResponse: (GInitResponse) -> Void) {}
func performRequest(_ request: GOrdersRequest, onResponse: (GOrdersResponse) -> Void) {}
func performRequest(_ request: GDeleteProductRequest, onResponse: (GDeleteProductResponse) -> Void) {}

func performRequest(_ request: GOrdersRequest, output: (GOrdersResponse) -> Void) {}

func viewState(from response: GOrdersResponse, with oldState: GViewState) -> GViewState {
    return oldState
}

func viewState(with oldState: GViewState, onNewState: (GViewState) -> Void) -> (GInitResponse) -> Void {
    return { response in

    }
}

func viewState(with oldState: GViewState, onNewState: (GViewState) -> Void) -> (GOrdersResponse) -> Void {
    return { response in

    }
}

func viewState(with oldState: GViewState, onNewState: (GViewState) -> Void) -> (GDeleteProductResponse) -> Void {
    return { response in

    }
}

//func viewState(from response: GInitResponse) {}
//func viewState(from response: GOrdersResponse) {}
//func viewState(from response: GDeleteProductResponse) {}

class BaseResponseProcessor<Response, ViewState> {
    let state: ViewState
    let updateView: (ViewState) -> Void
    let deriveViewState: (Response, ViewState) -> ViewState

    init(
        state: ViewState,
        deriveViewState: @escaping (Response, ViewState) -> ViewState,
        updateView: @escaping (ViewState) -> Void) {
        self.state = state
        self.deriveViewState = deriveViewState
        self.updateView = updateView
    }

    func viewState(from response: Response, with state: ViewState) -> ViewState {
        return deriveViewState(response, state)
    }

    func processResponse(_ response: Response) {
        let newState = viewState(from: response, with: state)
        updateView(newState)
    }
}

struct EERequest {}
struct EEResponse {}
struct EEViewState {}

func performRequest(_ request: EERequest, completion: (EEResponse) -> Void) {

}

func viewState(from response: EEResponse, with oldState: EEViewState) -> EEViewState {
    return oldState
}

func processResponse(from oldState: EEViewState, to newStateHandler: @escaping (EEViewState) -> Void) -> (EEResponse) -> Void {
    return { response in
        let newState = viewState(from: response, with: oldState)
        newStateHandler(newState)
    }
}

class Sample2 {
    var state = GViewState()

    func updateView(to newState: GViewState) {

    }

    func responseProcessor<Response>(state: GViewState, derive viewState: @escaping (Response, GViewState) -> GViewState)
        -> BaseResponseProcessor<Response, GViewState> {
            return BaseResponseProcessor<Response, GViewState>(
                state: state,
                deriveViewState: viewState,
                updateView: updateView
            )
    }

    func moo() {
        let responseProcessor = BaseResponseProcessor<GOrdersResponse, GViewState>(
            state: state,
            deriveViewState: viewState,
            updateView: updateView
        )
        performRequest(GOrdersRequest(), output: responseProcessor.processResponse)

        performRequest(GOrdersRequest(), output: self.responseProcessor(state: state, derive: viewState).processResponse)
    }
}

class Sample {

    var state = GViewState()
    var eeState = EEViewState()

    func updateView(to newState: GViewState) {

    }

    func updateView(to newState: EEViewState) {

    }

    func moo() {
        performRequest(
            EERequest(),
            completion: processResponse(
                from: eeState,
                to: updateView
            )
        )
    }

    func bar() {
        performRequest(
            GOrdersRequest(),
            onResponse: viewState(
                with: state,
                onNewState: updateView
            )
        )
    }
}

protocol Initable {
    init()
}

struct Promise<A> {
}

func performRequest<R, V>(_ request: R) -> Promise<V> {
    return performRequest(request)
}

typealias MakeRequest<Request, Response> = (Request) -> Promise<Response>

func performRequest<Request, Response>(_ request: MakeRequest<Request, Response>) {

}

func makeRequest(_ r: Int) -> Promise<String> {
    return Promise()
}

func GGSample() {
    performRequest(makeRequest)
}

/////////////

struct GRequest {

}

func performRequest(_ request: GRequest) -> Promise<Int> {
    return Promise()
}

struct Request {}


protocol Moo {
    func blame<A>(_ val: A)
}

class Bar: Moo {
    func blame<A>(_ val: A) {

    }

    func blame(_ val: Int) {

    }
}

class Foo<M: Moo> {
    var moo: M
    init(moo: M) {
        self.moo = moo
    }
}

func FSample() {
    let foo = Foo(moo: Bar())
    foo.moo.blame(42)
}
