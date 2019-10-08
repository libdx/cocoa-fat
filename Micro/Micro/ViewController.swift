//
//  ViewController.swift
//  Micro
//
//  Created by Oleksandr Ignatenko on 30/05/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

enum ProfileCellContents/*: Equatable */ {
    case text(value: String)
    case `switch`(value: Bool, title: String, details: String)
    case note(value: String, description: String)
}

class ProfileTableViewController: UITableViewController {
    func table() -> Table<ProfileCellContents, Void> {
        let model = (title: "moo", isOn: true, note: "Some asdf")

        let rows: [Row<ProfileCellContents>] = [
            Row(id: "0", contents: .text(value: model.title)),
            Row(id: "1", contents: .switch(value: model.isOn, title: "Send Notifications", details: "")),
            Row(id: "3", contents: .note(value: model.note, description: "Note"))
        ]

        let sections: [Section<ProfileCellContents, Void>] = [
            Section(id: "0", contents: (), rows: rows)
        ]

        return Table(id: "SomeTable", sections: sections)
    }
}

protocol OrderCellContents {
    var height: CGFloat { get }
}

protocol CellConfigurator {
    func configureCell(_ cell: UITableViewCell)
}

extension OrderCellContents {
    func configureCell(_ cell: UITableViewCell) {

    }
}

extension OrderCellContents {
    var height: CGFloat {
        return 44
    }
}

struct SwitchOrderCellContents: OrderCellContents {
    let isOn: Bool
    let title: String
}

struct TextOrderCellContents: OrderCellContents {
    let text: String
}

class OrderTableViewController: UITableViewController {
    func table() -> Table<OrderCellContents, Void> {
        let model = (title: "moo", isOn: true, note: "Some asdf")

        let rows: [Row<OrderCellContents>] = [
            Row(id: "0", contents: TextOrderCellContents(text: model.title)),
            Row(id: "1", contents: SwitchOrderCellContents(isOn: model.isOn, title: "Send Notifications")),
        ]

        let sections: [Section<OrderCellContents, Void>] = [
            Section(id: "0", contents: (), rows: rows)
        ]

        return Table(id: "SomeTable", sections: sections)
    }
}
