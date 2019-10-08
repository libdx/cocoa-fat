//
//  DiagramTests.swift
//  Links
//
//  Created by Alex Ignatenko on 11/03/16.
//  Copyright © 2016 Alex Ignatenko. All rights reserved.
//

import XCTest

class DiagramTests: XCTestCase {

    static let VertexCount = 30

    var diagram: DiagramType!

    override func setUp() {
        super.setUp()

        var graph = Graph(vertexCount: DiagramTests.VertexCount)
        graph.addEdge(0, 1)
        graph.addEdge(0, 1)
        graph.addEdge(0, 1)
        graph.addEdge(0, 5)
        graph.addEdge(5, 10)
        graph.addEdge(5, 11)
        graph.addEdge(6, 21)
        graph.addEdge(21, 5)
        graph.addEdge(21, 7)
        graph.addEdge(21, 8)

        XCTAssertTrue(graph.hasEdge(21, 5))

        diagram = Diagram(graph: graph)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testAccessNodes() {
        let node = diagram.nodeAt(7)
        XCTAssertNotNil(node)
        XCTAssertEqual(node?.vertex, 7)
    }

    func testAccessLinks() {
        let links = diagram.linksAt(5, 21)
        XCTAssertEqual(links.count, 1)
        let edge = LinkEdge(source: 5, target: 21)
        XCTAssertEqual(links.first?.edge.source, edge.source)
        XCTAssertEqual(links.first?.edge.target, edge.target)
    }

    func testAddingNode() {
        let initialLastVertex = DiagramTests.VertexCount - 1

        let node = diagram.addNode()
        XCTAssertEqual(node.vertex, initialLastVertex + 1)
        XCTAssertEqual(diagram.nodesCount, DiagramTests.VertexCount + 1)
        XCTAssertNotNil(diagram.nodeAt(node.vertex))
    }

    func testRemovingNode() {
        let node = diagram.removeNode(6)
        XCTAssertEqual(node.vertex, 6)
        XCTAssertEqual(diagram.nodesCount, DiagramTests.VertexCount - 1)
        XCTAssertNil(diagram.nodeAt(node.vertex))
    }

    func testRemovingBatchOfNodes() {
        let verticesToRemove = [3, 4, 6]
        let nodes = diagram.removeNodes(verticesToRemove)
        let vertices = nodes.map { $0.vertex }
        XCTAssertEqual(diagram.nodesCount, DiagramTests.VertexCount - verticesToRemove.count)
        XCTAssertEqual(vertices, verticesToRemove)

        for v in verticesToRemove {
            XCTAssertNil(diagram.nodeAt(v))
        }
    }

    func testAddingLink() {
        let link = diagram.addLink((source: 9, target: 7))
        XCTAssertEqual(link.edge.source, 9)
        XCTAssertEqual(link.edge.target, 7)

        XCTAssertEqual(diagram.linksAt(9, 7).count, 1)
    }

    func testRemovingLink() {
        let link = diagram.removeLink((source: 21, target: 5))
        XCTAssertEqual(link?.edge.source, 21)
        XCTAssertEqual(link?.edge.target, 5)

        XCTAssertEqual(diagram.linksAt(21, 5).count, 0)
    }

    func testRemovingNonExistingLink() {
        let initialLinksCount = diagram.linksCount

        let link = diagram.removeLink((source: 0, target: 20))
        XCTAssertNil(link)

        XCTAssertEqual(diagram.linksCount, initialLinksCount)
    }
}
