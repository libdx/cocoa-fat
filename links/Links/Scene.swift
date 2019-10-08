//
//  Scene.swift
//  Links
//
//  Created by Alex Ignatenko on 11/03/16.
//  Copyright © 2016 Alex Ignatenko. All rights reserved.
//

extension NodeType {
    func contains(_ point: Point) -> Bool {
        let w = width
        let h = height

        let containsX = point.x > position.x - 0.5*w && point.x < position.x + 0.5*w
        let containsY = point.y > position.y - 0.5*h && point.y < position.y + 0.5*h
        return containsX && containsY
    }
}

struct SceneDiff {
    let nodesToReload: [Int]
    let nodesToInsert: [Int]
    let nodesToDelete: [Int]
    init(nodesToReload: [Int] = [],
        nodesToInsert: [Int] = [],
        nodesToDelete: [Int] = []
        )
    {
        self.nodesToReload = nodesToReload
        self.nodesToInsert = nodesToInsert
        self.nodesToDelete = nodesToDelete
    }
}

func +(left: SceneDiff, right: SceneDiff) -> SceneDiff {
    return SceneDiff(
        nodesToReload: left.nodesToReload + right.nodesToReload,
        nodesToInsert: left.nodesToInsert + right.nodesToInsert,
        nodesToDelete: left.nodesToDelete + right.nodesToDelete
    )
}

struct Scene {
    fileprivate(set) var diagram: DiagramType

    init() {
        var graph = Graph(vertexCount: 10)
        graph.addEdge(3, 1)
        graph.addEdge(3, 5)
        graph.addEdge(3, 7)
        graph.addEdge(2, 7)
        graph.addEdge(6, 9)
        diagram = Diagram(graph: graph)
    }

    mutating func delete() -> SceneDiff {
        let selectedNodes = diagram.allNodes.filter { $0.selected }
        let vertices = selectedNodes.map { $0.vertex }
        diagram.removeNodes(vertices)
        return SceneDiff(nodesToDelete: vertices)
    }

    mutating func insert(_ location: Point) -> SceneDiff {
        let node = diagram.addNode(Node(position: location))
        return SceneDiff(nodesToInsert: [node.vertex])
    }

    mutating func select(_ location: Point) -> SceneDiff {
        // TODO: implement single selection
        return SceneDiff();
    }

    mutating func multiSelect(_ location: Point) -> SceneDiff {

        let nodesToReload: [NodeType]

        let clickedNodes = diagram.allNodes.filter { $0.contains(location) }

        if let node = clickedNodes.first {
            // toggle selection on clicked node
            let toggledNode = node.setSelected(!node.selected)
            nodesToReload = [toggledNode]
        } else {
            // use clicked empty area unselect all nodes
            let selectedNodes = diagram.allNodes
                .filter { $0.selected == true }

            let deselectedNodes = selectedNodes.map { $0.setSelected(false) }
            nodesToReload = deselectedNodes;
        }

        let vertices = diagram.update(nodesToReload).map { $0.vertex }
        return SceneDiff(nodesToReload: vertices)
    }

    mutating func move(_ location:(current: Point, previous: Point)) -> SceneDiff {
        let nodes = diagram.allNodes.filter { $0.contains(location.previous) || $0.selected }

        let movedNodes: [NodeType] = nodes.map { node in
            let offset = location.current - location.previous
            let movedNode = diagram.update(
                node.offset(offset)
            )
            return movedNode
        }
        return SceneDiff(nodesToReload: movedNodes.map { $0.vertex })
    }

    mutating func link(_ location: Point) -> SceneDiff {
        let nodesToReload: [NodeType]

        let hitNodes = diagram.allNodes.filter { $0.contains(location) }
        if let hitNode = hitNodes.first {
            let selectedNodes = diagram.allNodes.filter { $0.selected == true }
            for selectedNode in selectedNodes {
                let edge = LinkEdge(
                    source: selectedNode.vertex,
                    target: hitNode.vertex
                )
                diagram.addLink(edge)
            }
            nodesToReload = selectedNodes + [hitNode]
        } else {
            nodesToReload = []
        }
        return SceneDiff(nodesToReload: nodesToReload.map { $0.vertex })
    }
}
