//: Playground - noun: a place where people can play

import UIKit

let tup = ("A", 42, 5.0, URL(string: "http://example.com")!)

func iterate<Tuple>(_ tuple:Tuple, body:(_ label:String?,_ value:Any)->Void) {
    for child in Mirror(reflecting: tuple).children {
        body(child.label, child.value)
    }
}

iterate(tup) { print("\($0!): \($1)") }

protocol AnyValidator {
    func validate(any: Any) -> Bool
}

protocol Validator: AnyValidator {
    associatedtype Value

    func validate(value: Value) -> Bool
}

extension Validator {
    func validate(any: Any) -> Bool {
        guard let v = any as? Value else { return false }
        return validate(value: v)
    }
}

final class EmailValidator: Validator {
    func validate(value: String) -> Bool {
        return value.contains("@")
    }
}

final class MonthValidator: Validator {
    func validate(value: Int) -> Bool {
        return 0 < value && value <= 12
    }
}

let emailValidator = EmailValidator()
let monthValidator = MonthValidator()

let validators: [AnyValidator] = [emailValidator, monthValidator]

validators[0].validate(any: "example")
validators[0].validate(any: "me@example.com")
validators[0].validate(any: 42)

validators[1].validate(any: 45)
validators[1].validate(any: 6)
validators[1].validate(any: "two")

let emailValidators: [EmailValidator] = validators.flatMap { guard let v = $0 as? EmailValidator else {return nil}; return v }
emailValidators

let monthsValidators: [MonthValidator] = validators.flatMap { guard let v = $0 as? MonthValidator else {return nil}; return v }
monthsValidators

monthsValidators[0].validate(value: 4)
//monthsValidators[0].validate(value: "4") // compile error

