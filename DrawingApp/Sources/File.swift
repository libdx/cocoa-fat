//
//  File.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 10/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

struct FilePath {
    static let documents = FilePath("Documents")

    let string: String

    init(_ string: String) {
        self.string = string
    }
}

import UIKit

final class File<A: Codable> {
    static func all(in: FilePath) -> [File] {
        return []
    }

    static func first(in directory: FilePath = .documents, _ predicate: (File) -> Bool) -> File? {
        return File.all(in: directory).filter(predicate).first
    }

    let name: String
    let thumbnail: UIImage? = nil

    private var contents: A?

    init(name: String) {
        self.name = name
    }

    @discardableResult
    func save() -> Bool {
        return false
    }

    func load() -> A? {
        if let contents = contents {
            return contents
        }

        var data: Data?
        data = nil
        if let data = data {
            let decoder = JSONDecoder()
            contents = try? decoder.decode(A.self, from: data)
        }
        return contents
    }
}

struct Moo: Codable {}

func sample() {
    let _ = File<Moo>.all(in: .documents)

    let _ = File<Moo>
        .all(in: .documents)
        .filter { $0.name == "New Image"}
        .first?.load()

    let _ = File<Moo>.first(in: .documents) { $0.name == "New Image" }?.load()
}
