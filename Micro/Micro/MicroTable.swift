//
//  MicroTable.swift
//  Micro
//
//  Created by Oleksandr Ignatenko on 30/05/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

struct Row<A/*: Equatable */> {
    let id: String
    let contents: A
}

// TODO: Header, Footer
struct Section<A/*: Equatable */, B/*: Equatable */> {
    let id: String
    let contents: B
    let rows: [Row<A>]
}

struct Table<A/*: Equatable */, B/*: Equatable */> {
    let id: String
    let sections: [Section<A, B>]
}
