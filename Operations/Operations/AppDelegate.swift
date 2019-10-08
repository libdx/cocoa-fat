//
//  AppDelegate.swift
//  Operations
//
//  Created by Oleksandr Ignatenko on 25/05/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

protocol Foo {
    var value: Int { get }
}

extension Foo {
    var value: Int {
        return 42
    }
}

final class Aoo: Foo {
    var a: Int = 5
}

final class Boo: Foo {
    var b: Int = 6
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var foo: Foo = Aoo()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        switch foo {
        case let foo as Aoo:
            print(foo.value, foo.a)
            break
        case let foo as Boo:
            print(foo.value, foo.b)
            break
        default:
            break
        }


        return true
    }
}

