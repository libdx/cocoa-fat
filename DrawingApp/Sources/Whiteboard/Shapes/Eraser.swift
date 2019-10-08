//
//  Eraser.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 09/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation
import CoreGraphics

struct Eraser: Equatable {
    var stroke: Stroke
}

extension Eraser: Drawing {
    init(points: [CGPoint], options: GraphicsOptions) {
        stroke = Stroke(points: points, options: options)
    }

    mutating func append(point: CGPoint) {
        stroke.append(point: point)
    }

    func draw(in context: CGContext, with options: WhiteboardView.Options) {
        var stroke = self.stroke
        stroke.color = options.backgroundColor.cgColor
        stroke.draw(in: context, with: options)
    }
}
