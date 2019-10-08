//
//  EraseTool.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 09/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

class EraseTool: DrawingTool {
    var title: String {
        return "Erase"
    }

    var drawingType: Drawing.Type {
        return Eraser.self
    }
}
