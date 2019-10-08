//
//  Node.swift
//  Links
//
//  Created by Alex Ignatenko on 11/03/16.
//  Copyright © 2016 Alex Ignatenko. All rights reserved.
//

struct Node: NodeType {
    let vertex: Int
    fileprivate(set) var content: String?
    fileprivate(set) var contentKind: ContentKind
    fileprivate(set) var position: Point
    fileprivate(set) var size: Size
    fileprivate(set) var shapeString: String
    fileprivate(set) var selected: Bool

    init(
        vertex: Int = UnknownVertex,
        content: String? = nil,
        contentKind: ContentKind = .text,
        position: Point = Point(x: 0, y: 0),
        size: Size = Size(width: 0, height: 0),
        shapeString: String = "",
        selected: Bool = false
    )
    {
        self.vertex = vertex
        self.content = content
        self.contentKind = contentKind
        self.position = position
        self.size = size
        self.shapeString = shapeString
        self.selected = selected
    }

    // TODO: remove this method and use buil-in mechanism of structs coping
    func copy(_ vertex: Int) -> Node {
        var node = Node(vertex: vertex)
        node.content = content
        node.contentKind = contentKind
        node.position = position
        node.size = size
        node.shapeString = shapeString
        node.selected = selected
        return node
    }

    func setVertex(_ vertex: Int) -> NodeType {
        return copy(vertex)
    }

    func setPosition(_ position: Point) -> NodeType {
        var node = copy(vertex)
        node.position = position
        return node
    }

    func setSize(_ size: Size) -> NodeType {
        var node = copy(vertex)
        node.size = size
        return node
    }

    func offset(_ offset: Point) -> NodeType {
        var node = copy(vertex)
        node.position = node.position + offset
        return node
    }

    func setSelected(_ selected: Bool) -> NodeType {
        var node = copy(vertex)
        node.selected = selected
        return node
    }
}
