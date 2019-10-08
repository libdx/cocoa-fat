//
//  DrawTool.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 09/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

class DrawTool: DrawingTool {
    var title: String {
        return "Draw"
    }

    var drawingType: Drawing.Type {
        return Stroke.self
    }
}
