//
//  Types.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 03/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

struct LineDash: Equatable {
    var phase: CGFloat
    var lengths: [CGFloat]
}

extension LineDash {
    static let solid = LineDash(phase: 0, lengths: [0])
    static let dashDot = LineDash(phase: 0, lengths: [10, 10, 1])
    static let dash = LineDash(phase: 0, lengths: [20])
}

struct GraphicsOptions: Equatable {
    var lineWidth: CGFloat = 10
    var strokeColor = UIColor.darkGray
    var lineDash = LineDash.dash
}

protocol Drawing {
    init(points: [CGPoint], options: GraphicsOptions)
    func draw(in context: CGContext, with options: WhiteboardView.Options)
}

struct Shape: Equatable {
    var points: [CGPoint] = []
    var options = GraphicsOptions()
    var drawingType: Drawing.Type = Stroke.self

    mutating func append(point: CGPoint) {
        points.append(point)
    }
}

extension Shape {
    func draw(in context: CGContext, with options: WhiteboardView.Options) {
        let drawing = drawingType.init(points: points, options: self.options)
        drawing.draw(in: context, with: options)
    }
}

func ==(_ lhs: Shape, _ rhs: Shape) -> Bool {
    return lhs.points == rhs.points &&
    lhs.options == rhs.options &&
    lhs.drawingType == rhs.drawingType
}
