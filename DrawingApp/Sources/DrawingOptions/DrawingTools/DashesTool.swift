//
//  DashesTool.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 09/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

class DashesTool: DrawingTool {
    var title: String {
        return "Dashes"
    }

    var drawingType: Drawing.Type {
        return DashedStroke.self
    }
}
