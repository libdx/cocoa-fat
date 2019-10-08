//
//  DrawingTool.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 09/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

protocol DrawingTool {
    var title: String { get }
    var drawingType: Drawing.Type { get }
}
