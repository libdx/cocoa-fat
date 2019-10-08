//
//  ViewController.swift
//  TableHeaderDemo
//
//  Created by Oleksandr Ignatenko on 25/01/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    @IBAction func toggle() {
        updateHeader()
    }

    func updateHeader() {
        let view = tableView.tableHeaderView!

        UIView.animate(withDuration: 0.25) {
//            self.tableView.beginUpdates()

            if view.frame.height == 96 {
                view.frame.size.height = 200
            } else {
                view.frame.size.height = 96
            }

            self.tableView.tableHeaderView = view
//            self.tableView.endUpdates()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
}

