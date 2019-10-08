//
//  Diagram.swift
//  Links
//
//  Created by Alex Ignatenko on 11/03/16.
//  Copyright © 2016 Alex Ignatenko. All rights reserved.
//

struct Diagram: DiagramType {
    fileprivate(set) var graph: GraphType

    struct NodeData {
        let position: Point
        let selected: Bool
    }

    fileprivate var nodesData: [Int: NodeData] = [
        0: NodeData(position: Point(x: 210, y: 120), selected: false),
        1: NodeData(position: Point(x: 102, y: 120), selected: false),
        2: NodeData(position: Point(x: 130, y: 270), selected: false),
        3: NodeData(position: Point(x: 270, y: 80), selected: true),
        4: NodeData(position: Point(x: 50, y: 120), selected: false),
        5: NodeData(position: Point(x: 180, y: 210), selected: false),
        6: NodeData(position: Point(x: 260, y: 290), selected: true),
        7: NodeData(position: Point(x: 105, y: 220), selected: false),
        8: NodeData(position: Point(x: 150, y: 140), selected: false),
        9: NodeData(position: Point(x: 340, y: 160), selected: false)
    ]

    // tmp
    var allNodes: [NodeType] {
        var nodes = [NodeType]()
        for v in graph.allVertices {
            if let node = nodeAt(v) {
                nodes.append(node)
            }
        }
        return nodes
    }

    var allVertices: Set<Int> {
        return graph.allVertices //tmp
    }

    func adjacent(_ v: Int) -> AnyIterator<Int> { //tmp
        return graph.adjacent(v)
    }

//    func find(predicate: (node: NodeType) -> Bool) -> [NodeType] {
//
//    }

    // TODO: consider to create diff method on Node
    mutating func update(_ newNode: NodeType) -> NodeType { //tmp
        let v = newNode.vertex

        nodesData[v] = NodeData(
            position: newNode.position,
            selected:  newNode.selected
        )

        return newNode
    }

    mutating func update(_ nodes: [NodeType]) -> [NodeType] { //tmp
        return nodes.map { update($0) }
    }

    var nodesCount: Int {
        return graph.vertexCount
    }

    var linksCount: Int {
        return graph.edgeCount
    }

    init(graph: GraphType) {
        self.graph = graph
    }

    mutating func addNode(_ node: NodeType) -> NodeType {
        let vertex = graph.addVertex()
        nodesData[vertex] = NodeData(position: node.position, selected: false)
        return node.setVertex(vertex)
    }

    mutating func addNode() -> NodeType {
        let vertex = graph.addVertex()
        return Node(vertex: vertex)
    }

    // TODO: consider to mark nodes as deleted and actually delete them on `save` method
    mutating func removeNode(_ vertex: Int) -> NodeType {
        let vertex = graph.removeVertex(vertex)
        nodesData.removeValue(forKey: vertex)
        return Node(vertex: vertex)
    }

    mutating func removeNodes(_ vertices: [Int]) -> [NodeType] {
        return vertices.map { removeNode($0) }
    }

    mutating func addLink(_ edge: LinkEdge) -> LinkType {
        let edge = graph.addEdge(edge.source, edge.target)
        return Link(edge: edge)
    }

    mutating func removeLink(_ edge: LinkEdge) -> LinkType? {
        guard graph.hasEdge(edge.source, edge.target) else {
            return nil
        }

        graph.removeEdge(edge.source, edge.target)
        return Link(edge: edge)
    }

    func nodeAt(_ vertex: Int) -> NodeType? {
        guard graph.hasVertext(vertex) else {
            return nil
        }

        // TODO: node need to be fetched from database
        let nodeData = nodesData[vertex] ?? NodeData(position: Point(x: 0, y: 0), selected: false)
        return Node(
            vertex: vertex,
            position: nodeData.position,
            size: Size(width: 60, height: 30),
            selected: nodeData.selected
        )
    }

    func linksAt(_ v: Int, _ w: Int) -> [LinkType] {
        // current implementation supports only one edge (link) between vertices (nodes)
        guard graph.hasEdge(v, w) else {
            return []
        }

        return [Link(edge: (source: v, target: w))]
    }
}
