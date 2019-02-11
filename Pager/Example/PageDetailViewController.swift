//
//  PageDetailViewController.swift
//  Pager
//
//  Created by Christian Aranda on 06/02/2019.
//  Copyright © 2019 We Are Mobile First. All rights reserved.
//

import UIKit


final class PageDetailViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    var descriptionText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(descriptionText ?? "Text is nil")
    }

    static func instantiate() -> PageDetailViewController {
        return Storyboard.Demo.instantiate(PageDetailViewController.self)
    }
}

extension PageDetailViewController: ItemPresentable {
    static func configuredWith(item: Presentable) -> UIViewController {
        let viewController = PageDetailViewController.instantiate()
        viewController.descriptionText = item.description
        return viewController
    }
}

