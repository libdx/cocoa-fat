//
//  SceneInteractingSpec.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 14/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import XCTest
@testable import DrawingApp

final class InteractingLogic: SceneProcessing, SceneStateDisplaying {
    var state = SceneState()

    func changeDrawingOptions(_ options: DrawingOptions) -> SceneState {
        var state = SceneState()
        state.drawingOptions.graphicsOptions.lineWidth = 100
        return state
    }

    func addNewShape(_ shape: Shape) -> SceneState {
        return SceneState()
    }

    func clearShapes() -> SceneState {
        return SceneState()
    }
}

extension InteractingLogic: SceneInteracting {
    func uiDidTapEdit() {}
}

class SceneInteractingSpec: XCTestCase {

    var interactingLogic = InteractingLogic()
    var processingLogic: SceneProcessing!

    override func setUp() {
        interactingLogic = InteractingLogic()
        processingLogic = interactingLogic
    }

    override func tearDown() {

    }

    func test_itUpdatesStateWithResultAfterChangingDrawingOptions() {
        // given
        let state = processingLogic.changeDrawingOptions(DrawingOptions())

        // when
        interactingLogic.uiDidChangeOptions(DrawingOptions())

        // then
        XCTAssertEqual(interactingLogic.state, state)
    }
}
