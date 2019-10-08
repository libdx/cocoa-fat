//
//  Accept.swift
//  Trya
//
//  Created by Oleksandr Ignatenko on 25/01/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import UIKit
import Style

extension UIView {
    public func accept(state: Style.Shape) {
        layer.cornerRadius = state.cornerRadius
        layer.borderColor = state.borderColor.cgColor
        layer.borderWidth = state.borderWidth
        clipsToBounds = state.clipsToBounds
    }
}

extension UILabel {

    public func accept(state: Style.Text) {
        textColor = state.textColor
        font = UIFont.systemFont(ofSize: CGFloat(state.fontSize))
    }

    public func accept(state: Style.ClippedRoundRect) {
        
    }
}

extension UIButton {
    public func accept(state: Style.Text) {
        setTitleColor(state.textColor, for: .normal)
        titleLabel?.accept(state: state)
    }
}

protocol Component: class {
    associatedtype State
    associatedtype ViewState

    func viewState(for state: State) -> ViewState

    func apply(state: State)
}
