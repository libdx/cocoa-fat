//
//  Misc.swift
//  FunctionsInProtocols
//
//  Created by Oleksandr Ignatenko on 26/04/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

protocol Identifiable {
    var id: String { get }
}

struct User {}
struct CurrencyRates {}
struct ProductList {}

struct PaymentCredentials {
    var transactionToken: TransactionToken? { return nil }
}
struct PaymentAcknowledgment {}
struct PaymentSummary {}

protocol UserDepending {
    var user: User { get }
}

protocol CurrencyRatesDepending {
    var currencyRates: CurrencyRates { get }
}

protocol ProductListDepending {
    var productList: ProductList { get }
}

protocol PaymentTransactionDepending {
    var paymentTransaction: PaymentTransaction { get }
}

struct TransactionToken {}

protocol PaymentTransaction {
    func process(with token: TransactionToken)
    func commit()
    func rollback()
}

protocol TokenSupport {
    var token: String { get }
}

protocol PaymentSupport {
    func start()
    func confirm()
    func abort()
    func requestCredentials(for user: User, with: ProductList)
    func receiveCredentials(_ creds: PaymentCredentials)
    func receiveSummary(_ summary: PaymentSummary)
    func receiveAcknowledgment(_ ack: PaymentAcknowledgment)
    func receiveError(_ error: Error)
}

extension PaymentSupport where
    Self: UserDepending,
    Self: ProductListDepending,
    Self: CurrencyRatesDepending,
    Self: PaymentTransactionDepending {
    func start() {
        requestCredentials(for: user, with: productList)
    }

    func confirm() {
        paymentTransaction.commit()
    }

    func abort() {
        paymentTransaction.rollback()
    }

    func receiveCredentials(_ creds: PaymentCredentials) {
        if let token = creds.transactionToken {
            paymentTransaction.process(with: token)
        }
    }

    func receiveSummary(_ summary: PaymentSummary) {
        let _ = currencyRates
    }
}

struct SearchResults {}

final class ElasticSearchClient {
    func request(with query: String) {}
}

protocol ElasticSearchClientDepending {
    var elasticSearchClient: ElasticSearchClient { get }
}

protocol Searching {
    func search(term: String)
    func receiveResults(_ searchResults: SearchResults)
}

extension Searching where Self: ElasticSearchClientDepending {
    func search(term: String) {
        let query = term
        elasticSearchClient.request(with: query)
    }
}

protocol Caching {
    associatedtype Model
    func save(_ model: Model) -> Model
    func load() -> Model?
}

extension Caching where Model: Codable {
    func save(_ model: Model) -> Model {
        return model
    }

    func load() -> Model? {
        return nil
    }
}

protocol Term {}

protocol ModelLoadable {
    static func load(_ term: Term) -> Self?
    func save()
}

protocol ModelLoading {
    associatedtype Model
    static func load(_ term: Term) -> [Model]
    func save()
}

extension Array: ModelLoading {
    typealias Model = Element

    static func load(_ term: Term) -> Array {
        return []
    }

    func save() {}
}

struct PaymentDetailsState {}

protocol PaymentDetailsStateDisplaying {
    func display(_ state: PaymentDetailsState)
}

import UIKit

extension PaymentDetailsStateDisplaying where Self: UIViewController {
    func display(_ state: PaymentDetailsState) {
        title = "Bar"
    }
}

extension PaymentDetailsStateDisplaying where Self: UITableViewController {
    func display(_ state: PaymentDetailsState) {
        title = "Foo"
    }
}
