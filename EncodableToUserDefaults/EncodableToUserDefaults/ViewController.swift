//
//  ViewController.swift
//  EncodableToUserDefaults
//
//  Created by Oleksandr Ignatenko on 24/04/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

protocol Identifiable {
    var id: String { get }
}

struct Settings: Codable, Identifiable {
    var id: String = "44"
    var name: String = "test"
}

extension Settings: UserDefaultsStoring {}

// aka Storable
protocol UserDefaultsStoring {
    static func load(id: String) throws -> Self?
    func save() throws
}

extension UserDefaultsStoring where Self: Codable, Self: Identifiable {
    static func load(id: String) throws -> Self? {
        let defaults = UserDefaults.standard
        let key = "\(self).\(id)"
        print("load key: \(key)")
        if let data = defaults.data(forKey: key) {
            let decoder = PropertyListDecoder()
            return try decoder.decode(self, from: data)
        } else {
            return nil
        }
    }

    func save() throws {
        let encoder = PropertyListEncoder()
        let data = try encoder.encode(self)
        let defaults = UserDefaults.standard
        let key = "\(type(of: self)).\(id)"
        print("save key: \(key)")
        defaults.set(data, forKey: key)
    }
}

class ViewController: UIViewController {

    func sample() {
        let s1 = Settings()
        try! s1.save()

        let s2 = try! Settings.load(id: "44")
        print(s2)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        sample()
    }


}

