//
//  SceneView+Diff.swift
//  Links
//
//  Created by Alex Ignatenko on 13/06/16.
//  Copyright © 2016 Alex Ignatenko. All rights reserved.
//

import AppKit

extension SceneView {

    func reloadData() {
        guard let dataSource = dataSource else {
            return
        }

        for view in self.subviews {
            view.removeFromSuperview()
        }

        if linksView.superview == nil {
            linksView.backgroundColor = NSColor.background()
            self.addSubview(linksView)
        }
        linksView.frame = self.bounds

        nodes = [Node]()
        var links = [Link]()

        for vertex in dataSource.vertices() {
            let node = dataSource.node(forVertex: vertex, withView: Node.createView())
            self.addSubview(node.configureView())
            nodes.append(node)

            links += dataSource.links(fromVertex: vertex)
        }
        linksView.links = links
    }

    func applyDiff(_ diff: SceneDiff?) {
        guard let diff = diff else {
            return
        }

        for vertex in diff.nodesToReload {
            self.reloadNode(vertex)
        }

        for vertex in diff.nodesToInsert {
            self.insertNode(vertex)
        }

        for vertex in diff.nodesToDelete {
            self.deleteNode(vertex)
        }
    }

    // TODO: pass `animated` flag to insertNode func
    // TODO: pass vertices as array or set
    func insertNode(_ vertex: Int) {
        guard let dataSource = dataSource else {
            return
        }

        let node = dataSource.node(forVertex: vertex, withView: Node.createView())
        let view = node.configureView()
        self.animateInsertion(view)
        nodes.append(node)
    }

    // TODO: add completion callback
    @discardableResult
    func animateInsertion(_ view: NodeView) -> NodeView {
        let size = view.frame.size
        let position = view.position
        view.frame.size = CGSize(width: 0, height: 0)
        view.frame.origin = position
        self.addSubview(view)
        NSAnimationContext.runAnimationGroup({ contex in
            contex.duration = 0.25
            let aView = view.animator()
            aView.frame.size = size
            aView.setCenter(position)
            }) {}
        return view
    }

    func deleteNode(_ vertex: Int) {
        guard let index = nodes.index(where: { $0.vertex == vertex }) else {
            assert(false) //tmp
        }

        let node = nodes[index]
        nodes.remove(at: index)
        node.view.removeFromSuperview()

        linksView.links = updatedLinks(forVertex: vertex)
    }

    func reloadNode(_ vertex: Int) {
        guard let index = nodes.index(where: { $0.vertex == vertex }) else {
            assert(false) //tmp
        }

        let oldNode = nodes[index]

        guard let node = dataSource?.node(forVertex: vertex, withView: oldNode.view) else {
            assert(false) //tmp
        }

        node.configureView()

        nodes.remove(at: index)
        nodes.insert(node, at: index)

        linksView.links = updatedLinks(forVertex: vertex)
    }

    fileprivate func updatedLinks(forVertex vertex: Int) -> [Link] {
        guard let dataSource = dataSource else {
            return linksView.links
        }

        let links = linksView.links
        let otherLinks = links.filter {
            $0.edge.source != vertex && $0.edge.target != vertex
        }
        
        return dataSource.links(fromVertex: vertex) + otherLinks
    }
}
