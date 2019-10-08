//
//  ViewController.swift
//  uTable
//
//  Created by Oleksandr Ignatenko on 15/02/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
}

protocol Section {
    var rows: [Row] { get }
}

class TableViewSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var sections: [Section] = []

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let row = section.rows[indexPath.row]
        return row.source.cellForRow(at: indexPath)
    }
}

extension TableViewSource {
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let section = sections[indexPath.section]
        let row = section.rows[indexPath.row]
        return row.editor.canEditRow(at: indexPath)
    }
}

//enum SomeContent {
//    struct Content<Value> {
//        let title: String
//        let details: String
//        let value: Value
//    }
//
//    case avatar(Content<UIImage>)
//    case username(Content<String>)
//    case sendNotifications(Content<Bool>)
//    case narrationSpeed(Content<Int>)
//}

// Content, Configuration, Actions

//struct Row<RowContent> {
//    let content: RowContent
//}
//
//struct Section<SectionContent, RowContent> {
//    let content: SectionContent
//    let rows: [Row<RowContent>]
//}

protocol Row {
    var source: CellSourcing { get }
    var editor: CellEditing { get }
}

struct SomeRow: Row {
    let source: CellSourcing
    let editor: CellEditing
}

struct OtherRow {
    let dataSource: Any
    let delegate: Any
}

struct SomeState {
    var title: String = "The Greatest Adventure"
}

func sample() {
    let tableView = UITableView()
    let state = SomeState()

    let _ = SomeRow(
        source: SomeCellSource(tableView, state: state),
        editor: SomeCellEditor()
    )

    let source = SomeCellSource(tableView, state: state)
    let row = OtherRow(
        dataSource: source,
        delegate: source
    )

    if let dataSource = row.dataSource as? CellSourcing {
        let _ = dataSource.cellForRow(at: IndexPath())
    }
}

protocol TableViewDepending {
    var tableView: UITableView! { get set }
    init(_ tableView: UITableView)
    init()
}

extension TableViewDepending {
    init(_ tableView: UITableView) {
        self.init()
        self.tableView = tableView
    }
}

protocol CellSourcing: TableViewDepending {
    init(_ tableView: UITableView)
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell
}

protocol CellEditing {
    func canEditRow(at indexPath: IndexPath) -> Bool
}

protocol CellMoving: TableViewDepending {
    func canMoveRow(at indexPath: IndexPath) -> Bool
}

final class SomeCellSource: CellSourcing {
    weak var tableView: UITableView!
    var state = SomeState()

    convenience init(_ tableView: UITableView, state: SomeState) {
        self.init(tableView)
        self.state = state
    }

    func cellForRow(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Moo", for: indexPath)
        cell.textLabel?.text = state.title
        return cell
    }
}

final class SomeCellEditor: CellEditing {
    func canEditRow(at indexPath: IndexPath) -> Bool {
        return true
    }
}

// CellDataSource
// CellDelegate


@objc protocol _TableViewDepending {
    var tableView: UITableView! { get set }
    init(_ tableView: UITableView)
    init()
}

extension _TableViewDepending {
    init(_ tableView: UITableView) {
        self.init()
        self.tableView = tableView
    }
}

@objc protocol TableViewSectionDataSource: _TableViewDepending {

}

@objc protocol TableViewCellDataSource: _TableViewDepending {
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell
    @objc optional func canEditRow(at indexPath: IndexPath) -> Bool
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: type(of: self))
    }
}

extension TableViewCellDataSource {
    func dequeueReusableCell<Cell>(at indexPath: IndexPath) -> Cell where Cell: UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
    }
}
