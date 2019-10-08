//
//  Misc.swift
//  RemoteDecode
//
//  Created by Oleksandr Ignatenko on 22/09/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

protocol TypeID {
    static var id: String { get }
}

extension TypeID {
    static var id: String { return "\(self)" }
}

class Disk {
    var space: [String: Any] = [:]
}

class Network {
    func sendRequest(_ request: String, _ callback: @escaping (String) -> Void) {
        callback("{\"name\": \"Late Autumn\"}")
    }
}

class Cache<A: TypeID> {
    private var disk = Disk()
}

class Storage<A: TypeID> {
    private var disk = Disk()

    //    private var ifEmpty:

    func mapEmpty(_ substitue: () -> A) {

    }

    func get(_ callback: @escaping (A) -> Void) {
        if let a = disk.space[A.id] as? A {
            callback(a)
        }
    }
}

class Decoder<A: TypeID> where A: Decodable {
    func decode(json: String) -> A? {
        if let data = json.data(using: .utf8) {
            return try? JSONDecoder().decode(A.self, from: data)
        } else {
            return nil
        }
    }
}

class Remote<A: TypeID> where A: Decodable {
    private var network = Network()

    private var sideEffect: (_ callback: @escaping (A) -> Void) -> Void = { _ in }

    func than(with decoder: Decoder<A>) -> Remote {
        sideEffect = { [weak self] callback in
            self?.network.sendRequest(A.id, { raw in
                if let a = decoder.decode(json: raw) {
                    callback(a)
                }
            })
        }
        return self
    }

    func run(_ callback: @escaping (A) -> Void) {
        sideEffect(callback)
    }
}

struct Report: TypeID, Codable {

}

func sample() {
    let remote = Remote<Report>().than(with: Decoder())
}
