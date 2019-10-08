//
//  DrawingAppTests.swift
//  DrawingAppTests
//
//  Created by Oleksandr Ignatenko on 14/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import XCTest
@testable import DrawingApp

final class ProcessingLogic: SceneProcessing {
    var state = SceneState()

    init(_ state: SceneState = SceneState()) {
        self.state = state
    }
}

class SceneProcessingSpec: XCTestCase {

    var processingLogic: SceneProcessing = ProcessingLogic()

    override func setUp() {
        processingLogic = ProcessingLogic()
    }

    override func tearDown() {

    }

    func test_itChangesDrawingOptions() {
        // given
        var state = processingLogic.state

        var options = DrawingOptions()
        options.selectedToolIndex = 2
        options.backgroundColor = UIColor.black

        state.drawingOptions = options

        // when
        let newState = processingLogic.changeDrawingOptions(options)

        // then
        XCTAssertEqual(state, newState)
    }

    func test_itClearsShapes() {
        // given
        let state = SceneState(
            shapes: [Shape(), Shape()],
            drawingOptions: DrawingOptions()
        )

        processingLogic = ProcessingLogic(state)

        // when
        let newState = processingLogic.clearShapes()

        // then
        XCTAssertEqual(newState.shapes.isEmpty, true)
    }
}
