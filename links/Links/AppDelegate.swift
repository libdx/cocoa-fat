//
//  AppDelegate.swift
//  Links
//
//  Created by Alex Ignatenko on 24/02/16.
//  Copyright © 2016 Alex Ignatenko. All rights reserved.
//

import Cocoa

extension CGPoint {
    init(_ point: Point) {
        self.init(x: point.x, y: point.y)
    }
}

extension CGSize {
    init(_ size: Size) {
        self.init(width: size.width, height: size.height)
    }
}

extension Point {
    init(_ point: CGPoint) {
        self.init(x: Double(point.x), y: Double(point.y))
    }
}

func +(left: CGPoint, right: CGPoint) -> CGPoint {
    let x = left.x + right.x
    let y = left.y + right.y
    return CGPoint(x: x, y: y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
    let x = left.x - right.x
    let y = left.y - right.y
    return CGPoint(x: x, y: y)
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, SceneViewDataSource, SceneViewEventDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var view: SceneView!
    var scene = Scene()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window.titleVisibility = .hidden
        window.initialFirstResponder = view
        view.backgroundColor = NSColor.white

        view.dataSource = self
        view.delegate = self
    }

    // MARK: SceneViewDataSource
    func vertices() -> Set<Int> {
        return scene.diagram.allVertices
    }

    func node(forVertex vertex: Int, withView view: NodeView) -> SceneView.Node {
        guard let node = scene.diagram.nodeAt(vertex) else {
            assert(false) //tmp
        }

        let viewNode = SceneView.Node(
            vertex: node.vertex,
            position: NSPoint(node.position),
            size: NSSize(node.size),
            selected:  node.selected,
            editable: vertex == 3 ? true : false,
            view: view
        )
        return viewNode
    }

    func links(fromVertex v: Int) -> [SceneView.Link] {
        guard let thisNode = scene.diagram.nodeAt(v) else {
            return []
        }

        typealias ViewLink = SceneView.Link

        var links = [ViewLink]()
        for w in scene.diagram.adjacent(v) {
            if let node = scene.diagram.nodeAt(w) {
                let viewLink = SceneView.Link(
                    edge: (v, w),
                    source: NSPoint(thisNode.position),
                    target: NSPoint(node.position)
                )
                links.append(viewLink)
            }
        }
        return links
    }

    // MARK: SceneViewEventDelegate
    func mouseDown(_ location: NSPoint) -> SceneDiff {
        return scene.multiSelect(Point(location))
    }

    func mouseDragged(_ view: SceneView, location:(current: NSPoint, previous:NSPoint)) -> SceneDiff {
        return scene.move((Point(location.current), Point(location.previous)))
    }

    func mouseDoubleClicked(_ location: NSPoint) -> SceneDiff {
        return scene.insert(Point(location))
    }

    func deleteKeyDown() -> SceneDiff {
        return scene.delete()
    }

    func mouseUpLinking(_ location: NSPoint) -> SceneDiff {
        return scene.link(Point(location))
    }
}

