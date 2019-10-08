//
//  Stroke.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 09/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

struct Stroke: Equatable {
    var points: [CGPoint] = []
    var width: CGFloat = 0
    var color: CGColor = UIColor.black.cgColor
}

extension Stroke: Drawing {
    init(points: [CGPoint], options: GraphicsOptions) {
        self.points = points
        width = options.lineWidth
        color = options.strokeColor.cgColor
    }

    mutating func append(point: CGPoint) {
        points.append(point)
    }

    func draw(in context: CGContext, with options: WhiteboardView.Options) {
        context.setLineWidth(CGFloat(width))
        context.setStrokeColor(color)
        context.setLineCap(.round)

        let first = points[0]
        let rest = points[1 ..< points.count]

        context.move(to: first)
        for point in rest {
            context.addLine(to: point)
        }
        context.strokePath()
    }
}
