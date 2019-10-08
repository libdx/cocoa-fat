//
//  GraphTests.swift
//  Links
//
//  Created by Alex Ignatenko on 11/03/16.
//  Copyright © 2016 Alex Ignatenko. All rights reserved.
//

import XCTest

class GraphTests: XCTestCase {

    static let VertexCount = 30

    var graph: GraphType = Graph(vertexCount: GraphTests.VertexCount)

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertEqual(graph.vertexCount, GraphTests.VertexCount)
        XCTAssertEqual(graph.edgeCount, 0)
        XCTAssertTrue(graph.hasVertext(15))
    }

    func testVertecesAdding() {
        let initialLastVertex = GraphTests.VertexCount - 1

        XCTAssertEqual(graph.addVertex(), initialLastVertex + 1)
        XCTAssertEqual(graph.addVertex(), initialLastVertex + 2)
        XCTAssertEqual(graph.addVertex(), initialLastVertex + 3)
        XCTAssertEqual(graph.vertexCount, GraphTests.VertexCount + 3)

        XCTAssertTrue(graph.hasVertext(initialLastVertex + 1))
        XCTAssertTrue(graph.hasVertext(initialLastVertex + 2))
        XCTAssertTrue(graph.hasVertext(initialLastVertex + 3))
    }

    func testVertecesRemoving() {
        graph.addEdge(5, 10)
        graph.addEdge(5, 18)

        XCTAssertTrue(graph.hasEdge(5, 10))
        XCTAssertTrue(graph.hasEdge(5, 18))

        XCTAssertEqual(graph.removeVertex(5), 5)
        XCTAssertEqual(graph.removeVertex(21), 21)

        XCTAssertEqual(graph.vertexCount, GraphTests.VertexCount - 2)
        XCTAssertFalse(graph.hasVertext(5))
        XCTAssertFalse(graph.hasVertext(21))

        for _ in graph.adjacent(5) {
            XCTAssertTrue(false)
        }

        // expect to not have adjacent to 5
        for v in graph.adjacent(10) {
            XCTAssertNotEqual(v, 5)
        }

        for _ in graph.adjacent(21) {
            XCTAssertTrue(false)
        }

        XCTAssertFalse(graph.hasEdge(5, 10))
        XCTAssertFalse(graph.hasEdge(5, 18))
    }

    func testEdgeAdding() {
        graph.addEdge(0, 1)
        graph.addEdge(0, 2)
        graph.addEdge(0, 3)
        graph.addEdge(0, 4)
        graph.addEdge(15, 7)
        graph.addEdge(15, 8)
        graph.addEdge(15, 9)

        XCTAssertEqual(graph.edgeCount, 7)
        XCTAssertTrue(graph.hasEdge(0, 1))
        XCTAssertTrue(graph.hasEdge(0, 2))
        XCTAssertTrue(graph.hasEdge(0, 3))
        XCTAssertTrue(graph.hasEdge(0, 4))
        XCTAssertTrue(graph.hasEdge(15, 7))
        XCTAssertTrue(graph.hasEdge(15, 8))
        XCTAssertTrue(graph.hasEdge(15, 9))
    }

    func testEdgeRemoving() {
        graph.addEdge(1, 3)
        graph.addEdge(1, 4)
        graph.addEdge(21, 17)
        graph.addEdge(21, 18)
        XCTAssertEqual(graph.edgeCount, 4)

        graph.removeEdge(1, 3)
        XCTAssertEqual(graph.edgeCount, 3)

        graph.removeEdge(17, 21)
        XCTAssertEqual(graph.edgeCount, 2)
    }

    func testAddingEdgesToNewVertex() {
        let new = graph.addVertex()
        graph.addEdge(5, new)
        graph.addEdge(new, 7)

        var vertices: Set = [5, 7]
        for v in graph.adjacent(new) {
            XCTAssertTrue(vertices.contains(v))
            vertices.remove(v)
        }
    }

    func testAdjacentByAddingEdges() {
        graph.addEdge(2, 5)
        graph.addEdge(2, 6)
        graph.addEdge(2, 7)
        graph.addEdge(2, 8)

        var vertices: Set = [5, 6, 7, 8]
        for v in graph.adjacent(2) {
            XCTAssertTrue(vertices.contains(v))
            vertices.remove(v)
        }
        XCTAssertEqual(vertices.count, 0)
    }

    func testAdjacentByDeletingEdges() {
        graph.addEdge(2, 5)
        graph.addEdge(2, 6)
        graph.addEdge(2, 7)
        graph.addEdge(2, 8)

        graph.removeEdge(2, 7)

        var vertices: Set = [5, 6, 8]
        for v in graph.adjacent(2) {
            XCTAssertTrue(vertices.contains(v))
            vertices.remove(v)
        }
        XCTAssertEqual(vertices.count, 0)
    }

    func testOutOfBoundaries() {
        // TODO: add edges between non-existing vertices etc.
    }
}
