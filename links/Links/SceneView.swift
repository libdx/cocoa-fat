//
//  SceneView.swift
//  Links
//
//  Created by Alex Ignatenko on 11/03/16.
//  Copyright © 2016 Alex Ignatenko. All rights reserved.
//

import AppKit

class SceneView: BaseView {

    var shiftKeyPressed: Bool = false

    /*private*/ var nodes = [Node]()

    /*private*/ let linksView: LinksView = LinksView()

    weak var delegate: SceneViewEventDelegate? = nil
    weak var dataSource: SceneViewDataSource? = nil {
        didSet {
            reloadData()
        }
    }

    var previousLocation: CGPoint = CGPoint(x: 0, y: 0)

    struct Node {

        static func createView() -> NodeView {
            return NodeView(frame: NSMakeRect(0, 0, 0, 0))
        }

        let vertex: Int
        let position: NSPoint
        let size: NSSize
        let selected: Bool
        let editable: Bool
        let view: NodeView

        @discardableResult
        func configureView() -> NodeView {
            view.frame.size = size
            view.position = position
            view.text = String(vertex)
            view.backgroundColor = selected ? NSColor.softBlue() : NSColor.acidGreen()
            view.editable = editable
            return view
        }
    }

    struct Link {
        let edge: LinkEdge
        let source: NSPoint
        let target: NSPoint
    }

    override var acceptsFirstResponder: Bool {
        return true
    }

    override func mouseUp(with event: NSEvent) {
        var diff: SceneDiff? = nil

        let location = self.convert(event.locationInWindow, from:nil)
        if event.clickCount == 1 {
            if shiftKeyPressed {
                diff = delegate?.mouseUpLinking(location)
            }
        } else if event.clickCount == 2 {
            diff = delegate?.mouseDoubleClicked(location)
        }
        applyDiff(diff)
    }

    // TODO: implement mouseUp instead of mouseDown
    override func mouseDown(with event: NSEvent) {
        previousLocation = self.convert(event.locationInWindow, from:nil)

        applyDiff(delegate?.mouseDown(previousLocation))
    }

    override func mouseDragged(with event: NSEvent) {
        let location = self.convert(event.locationInWindow, from:nil)
        let diff = delegate?.mouseDragged(self, location: (
            current: location,
            previous: previousLocation
            )
        )
        previousLocation = location

        applyDiff(diff)
    }

    static let DeleteKey: UInt16 = 51

    override func keyDown(with event: NSEvent) {
        if event.keyCode == SceneView.DeleteKey {
            applyDiff(delegate?.deleteKeyDown())
        }
    }

    override func flagsChanged(with event: NSEvent) {
        shiftKeyPressed = event.modifierFlags.contains([.shift])
    }
}

protocol SceneViewEventDelegate: class {
    func mouseDown(_ location: NSPoint) -> SceneDiff
    func mouseDragged(_ view: SceneView, location:(current: NSPoint, previous:NSPoint)) -> SceneDiff
    func mouseDoubleClicked(_ location: NSPoint) -> SceneDiff
    func deleteKeyDown() -> SceneDiff
    // TODO: improve naming
    func mouseUpLinking(_ location: NSPoint) -> SceneDiff
}

protocol SceneViewDataSource: class {
    func vertices() -> Set<Int>
    func node(forVertex vertex: Int, withView view: NodeView) -> SceneView.Node
    func links(fromVertex vertex: Int) -> [SceneView.Link]
}
