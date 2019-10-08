//
//  Style.swift
//  Style
//
//  Created by Oleksandr Ignatenko on 25/01/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

public protocol Text {
    var fontSize: Float { get }
    var textColor: UIColor { get }
}

public protocol Shape /*Boundary*/ {
    var cornerRadius: CGFloat { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var clipsToBounds: Bool { get }
}

public class Base {
    public init() {}
}

public class P1: Base, Text {
    public let fontSize: Float = 25
    public let textColor: UIColor = UIColor.black
}

public class P4: Base, Text {
    public let fontSize: Float = 14
    public let textColor: UIColor = UIColor.black
}

public class ThinRoundRect: Base, Shape {
    public let cornerRadius: CGFloat = 5
    public let borderColor: UIColor = UIColor.red
    public let borderWidth: CGFloat = 1
    public var clipsToBounds: Bool { return false }
}

public class ClippedRoundRect: ThinRoundRect {
    public override var clipsToBounds: Bool { return true }
}

//public protocol Applier {
//    associatedtype Element
//    associatedtype Style
//
//    func apply(style: Style, to e: Element)
//}
//
//public extension Applier {
//    func apply(style: Style, to e: Element) {
//
//    }
//}

public class Applier<E, S> {
    public typealias Element = E
    public typealias Style = S

    public init() {
        
    }

    public func apply(style: S, to e: E) {

    }
}

public extension Applier where E == UIView, S: Shape  {
    public func apply(style: Shape, on view: UIView) {
        view.layer.cornerRadius = style.cornerRadius
        view.layer.borderColor = style.borderColor.cgColor
        view.layer.borderWidth = style.borderWidth
        view.clipsToBounds = style.clipsToBounds
    }
}

public extension Applier where E == UILabel, S: Text  {
    public func apply(style: Text, to label: UILabel) {
        label.textColor = style.textColor
        label.font = UIFont.systemFont(ofSize: CGFloat(style.fontSize))
    }
}

public extension Applier where E == UIButton, S: Text  {
    public func apply(style: Text, to button: UIButton) {
        button.setTitleColor(style.textColor, for: .normal)
        if let titleLabel = button.titleLabel {
            let applier = Applier<UILabel, Text>()
            applier.apply(style: style, to: titleLabel)
        }
    }
}
