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

    let items = [Item(title: "Air Jordan 1", description: "Air Jordan 1"),
                 Item(title: "Air Jordan 2", description: "Air Jordan 2"),
                 Item(title: "Air Jordan 3", description: "Air Jordan 3"),
                 Item(title: "Air Jordan 4", description: "Air Jordan 4"),
                 Item(title: "Air Jordan 5", description: "Air Jordan 5"),
                 Item(title: "Air Jordan 6", description: "Air Jordan 6"),
                 Item(title: "Air Jordan 7", description: "Air Jordan 7")]

    @IBAction func didTapStartButton(_ sender: Any) {
        let controller = Pager.PageContainerViewController.instantiate()
        present(controller, animated: true)

        let controllers = items.map { _ in PageDetailViewController.instantiate() ?? PageDetailViewController() }
        controller.configure(with: items, controllers: controllers)
    }
}

