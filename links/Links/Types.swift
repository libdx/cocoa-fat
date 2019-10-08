//
//  Lib.swift
//  Links
//
//  Created by Alex Ignatenko on 24/02/16.
//  Copyright © 2016 Alex Ignatenko. All rights reserved.
//

enum ShapeKind {
    case ellipse
    case path
    case image
}

protocol ShapeType {
    init(string: String)
    func toString() -> String
}

struct EllipseShape: ShapeType {
    let center: Float
    let radii: (x: Float, y: Float)
    
    init(string: String) {
        center = 0
        radii = (0, 0)
        // TODO: implement
    }
    
    func toString() -> String {
        return String(
            format: "Kind=Ellipse; center=%f; radii.x=%f; radii.y=%f",
            arguments: [center, radii.x, radii.y]
        )
    }
}

struct Style {
    static let AnyVertext: Int = -1

    let vertex: Int
    let borderWidth: Float
}

enum ContentKind {
    case text
    // possible cases: HTML, Markdown, ect
}

struct Point {
    let x: Double
    let y: Double
}

struct Size {
    let width: Double
    let height: Double
}

func +(left: Point, right: Point) -> Point {
    let x = left.x + right.x
    let y = left.y + right.y
    return Point(x: x, y: y)
}

func -(left: Point, right: Point) -> Point {
    let x = left.x - right.x
    let y = left.y - right.y
    return Point(x: x, y: y)
}

protocol NodeType {
    var vertex: Int { get }
    var content: String? { get }
    var contentKind: ContentKind { get }
    var position: Point { get }
    var size: Size { get }
    var shapeString: String { get }
    var selected: Bool { get }

    func setVertex(_ vertex: Int) -> NodeType
    func setPosition(_ position: Point) -> NodeType
    func setSize(_ size: Size) -> NodeType
    func offset(_ offset: Point) -> NodeType
    func setSelected(_ selected: Bool) -> NodeType
}

extension NodeType {
    var x: Double {
        return self.position.x
    }
    var y: Double {
        return self.position.y
    }

    var width: Double {
        return self.size.width
    }

    var height: Double {
        return self.size.height
    }
}

typealias LinkEdge = (source: Int, target: Int)

protocol LinkType {
    var edge: LinkEdge { get }
}

protocol DiagramType {
    init(graph: GraphType)

    var nodesCount: Int { get }
    var linksCount: Int { get }

    var allNodes: [NodeType] { get } //tmp
    var allVertices: Set<Int> { get } //tmp
    func adjacent(_ v: Int) -> AnyIterator<Int> //tmp

    mutating func update(_ node: NodeType) -> NodeType //tmp
    mutating func update(_ nodes: [NodeType]) -> [NodeType] //tmp

    mutating func addNode(_ node: NodeType) -> NodeType
    mutating func addNode() -> NodeType // adds default node
    mutating func removeNode(_ vertex: Int) -> NodeType
    @discardableResult
    mutating func removeNodes(_ vertices: [Int]) -> [NodeType]

    @discardableResult
    mutating func addLink(_ edge: LinkEdge) -> LinkType
    mutating func removeLink(_ edge: LinkEdge) -> LinkType? // TODO: support multiple links

    func nodeAt(_ vertex: Int) -> NodeType?
    func linksAt(_ v: Int, _ w: Int) -> [LinkType]
}
