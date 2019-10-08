//
//  Graph.swift
//  Links
//
//  Created by Alex Ignatenko on 11/03/16.
//  Copyright © 2016 Alex Ignatenko. All rights reserved.
//

protocol GraphType {
    init(vertexCount: Int)

    var vertexCount: Int { get }
    var edgeCount: Int { get }

    var allVertices: Set<Int> { get } //tmp

    func hasVertext(_ v: Int) -> Bool
    mutating func addVertex() -> Int
    mutating func removeVertex(_ v: Int) -> Int

    func hasEdge(_ v: Int, _ w: Int) -> Bool
    mutating func addEdge(_ v: Int, _ w: Int) -> (Int, Int)
    @discardableResult
    mutating func removeEdge(_ v: Int, _ w: Int) -> (Int, Int)
    func adjacent(_ v: Int) -> AnyIterator<Int>
}

let UnknownVertex = Int.min

struct Graph : GraphType {
    fileprivate var adjacentMap: [Int: Set<Int>]

    fileprivate(set) var vertexCount: Int
    fileprivate(set) var edgeCount: Int

    init(vertexCount: Int) {
        self.vertexCount = vertexCount
        edgeCount = 0
        adjacentMap = [Int: Set<Int>](minimumCapacity: vertexCount)
        for v in 0..<vertexCount {
            adjacentMap[v] = Set<Int>()
        }
    }

    var allVertices: Set<Int> {
        return Set(adjacentMap.keys) //tmp
    }

    // TODO: consider to use incremental count for vertices
    var sortedVertices: Array<Int> {
        return Array(adjacentMap.keys).sorted(by: <)
    }

    func hasVertext(_ v: Int) -> Bool {
        return sortedVertices.contains(v)
    }

    mutating func addVertex() -> Int {
        guard let last = sortedVertices.last else {
            return UnknownVertex
        }

        let new = last + 1
        adjacentMap[new] = Set<Int>()
        vertexCount += 1

        return new
    }

    @discardableResult
    mutating func removeVertex(_ v: Int) -> Int {
        for w in adjacent(v) {
            removeEdge(v, w)
        }
        adjacentMap.removeValue(forKey: v)
        vertexCount -= 1

        return v
    }

    func hasEdge(_ v: Int, _ w: Int) -> Bool {
        guard
            let adjacentToV = adjacentMap[v],
            let adjacentToW = adjacentMap[w] else {
            return false
        }

        return adjacentToV.contains(w) && adjacentToW.contains(v)
    }

    @discardableResult
    mutating func addEdge(_ v: Int, _ w: Int) -> (Int, Int) {
        adjacentMap[v]?.insert(w)
        adjacentMap[w]?.insert(v)
        edgeCount += 1
        return (v, w)
    }

    @discardableResult
    mutating func removeEdge(_ v: Int, _ w: Int) -> (Int, Int) {
        _ = adjacentMap[v]?.remove(w)
        _ = adjacentMap[w]?.remove(v)
        edgeCount -= 1
        return (v, w)
    }

    func adjacent(_ v: Int) -> AnyIterator<Int> {
        guard let generator = adjacentMap[v]?.makeIterator() else {
            return AnyIterator(Set().makeIterator())
        }
        return AnyIterator(generator)
    }
}
