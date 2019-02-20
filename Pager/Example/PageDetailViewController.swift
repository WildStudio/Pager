//
//  PageDetailViewController.swift
//  Pager
//
//  Created by Christian Aranda on 06/02/2019.
//  Copyright © 2019 We Are Mobile First. All rights reserved.
//

import UIKit
import Pager


final class PageDetailViewController: UIViewController {
    
    private static let storyboard = "Demo"
    
    @IBOutlet private var imageView: UIImageView?
    @IBOutlet private var titleLabel: UILabel?
    @IBOutlet private var subtitleLabel: UILabel?
    var descriptionText: String?
    var titleText: String?
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let description = descriptionText,
            let title = titleText,
            let name = imageName else { return }
        
        titleLabel?.text = title
        subtitleLabel?.text = description
        imageView?.image = UIImage(named: name)
    }
    
    static func instantiate() -> PageDetailViewController? {
        let storyboard = UIStoryboard(name: PageDetailViewController.storyboard, bundle: nil)
        
        guard let viewController = storyboard.instantiateInitialViewController() as? PageDetailViewController else {
            return nil
        }
        
        return viewController
    }
}

extension PageDetailViewController: ItemPresentable {
    func configuredWith(item: Item) -> UIViewController {
        guard let model = item as? Model else {
            descriptionText = item.description
            return self
        }
        
        titleText = model.title
        descriptionText = model.description
        imageName = model.image
        
        return self
    }
}
