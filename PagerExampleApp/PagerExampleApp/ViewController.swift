//
//  ViewController.swift
//  PagerExampleApp
//
//  Created by Christian Aranda on 11/02/2019.
//  Copyright © 2019 We Are Mobile First. All rights reserved.
//

import UIKit
import Pager

class ViewController: UIViewController {

    let items = [Item(title: "Item 1", description: "item 1"), Item(title: "Item 2", description: "item 2"), Item(title: "Item 3", description: "item 3"), Item(title: "Item 4", description: "item 4")]

    @IBAction func didTapStartButton(_ sender: Any) {

        var controller = Pager.PageContainerViewController.instantiate()
        controller.configure(with: items, controller: PageDetailViewController())
    }
}

