//
//  ViewController.swift
//  Reduce
//
//  Created by Oleksandr Ignatenko on 25/05/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

struct State {
    var searchTerm: String = ""
}

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

