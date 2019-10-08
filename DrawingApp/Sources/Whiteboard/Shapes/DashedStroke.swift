//
//  DashedStroke.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 09/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation
import CoreGraphics

struct DashedStroke: Equatable {
    var lineDash: LineDash
    var stroke: Stroke
}

extension DashedStroke: Drawing {
    init(points: [CGPoint], options: GraphicsOptions) {
        stroke = Stroke(points: points, options: options)
        lineDash = options.lineDash
    }

    mutating func append(point: CGPoint) {
        stroke.append(point: point)
    }

    func draw(in context: CGContext, with options: WhiteboardView.Options) {
        context.setLineDash(phase: lineDash.phase, lengths: lineDash.lengths)
        stroke.draw(in: context, with: options)
    }
}
