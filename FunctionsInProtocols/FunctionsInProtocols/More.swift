//
//  More.swift
//  FunctionsInProtocols
//
//  Created by Oleksandr Ignatenko on 28/04/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

enum Result<V, E> {
    case success(v: V)
    case error//(e: E)
}

protocol Storing {
    static func load(id: String) -> Self?
    func save()
}

protocol KeychainStoring: Storing {}
protocol UserDefaultsStoring: Storing {}

extension KeychainStoring {
    //...
}

extension UserDefaultsStoring {
    //...
}

struct _AuthToken: KeychainStoring {
    let value: String

    static func load(id: String) -> _AuthToken? { return nil }
    func save() {}
}

//////////////

protocol Networking {
    associatedtype AuthToken
    var token: AuthToken? { get }
    var headers: [String: String] { get }
    var baseURL: URL { get }

    func fetch<Resource>() -> Result<Resource, Error>
    func authenticate(username: String, password: String) -> Result<AuthToken, Error>
}

extension Networking {
    func setupNetworkingStack() {
        // ...
    }

    func fetch<Resource>() -> Result<Resource, Error> {
        return .error
    }

    func authenticate(username: String, password: String) -> Result<AuthToken, Error> {
        return .error
    }
}

///////////////

protocol ShoppingMallSupport {
    var productsPath: String { get }
    var createShoppingCardPath: String { get }

    func fetchProducts() // -> ...
    func createShoppingCard() // -> ...
    func addProduct(/*shopping card, product id*/)
    func purchase(/*shopping card*/)
}

extension Networking where Self: ShoppingMallSupport {
    var baseURL: URL {
        return URL(string: "http://example.com")!
    }

    var headers: [String: String] {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
}

extension ShoppingMallSupport {

    var productsPath: String {
        return "products"
    }

    var createShoppingCardPath: String {
        return "cards/new"
    }

    func fetchProducts() // -> ...
    {}
    func createShoppingCard() // -> ...
    {}
    func addProduct(/*shopping card, product id*/) {}
    func purchase(/*shopping card*/) {}
}

struct ShoppingMallAuthToken {}

final class ShoppingMallClient: Networking, ShoppingMallSupport {
    typealias AuthToken = ShoppingMallAuthToken

    static let shared = ShoppingMallClient()

    var token: ShoppingMallAuthToken?
}

//////////////////
