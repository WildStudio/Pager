//
//  ViewController.swift
//  PagerExampleApp
//
//  Created by Christian Aranda on 11/02/2019.
//  Copyright © 2019 We Are Mobile First. All rights reserved.
//

import UIKit
import Pager

class Model: Item {
    let image: String

    init(title: String, description: String, imageName: String) {
        self.image = imageName
        super.init(title: title, description: description)
    }
}

class ViewController: UIViewController {

    let dataSource = [Model(title: "Air Jordan I", description: "The original. The icon. When you say Air Jordan, this is the sneaker people think of. It still looks fresh more than 30 years later, and it's hard to imagine the popularity of the first Jordan fading anytime soon.", imageName: "I"),
                      Model(title: "Air Jordan III", description: "This was the first sneaker to sport the famed Jumpman logo, and Jordan Brand might not exist today without it. It looks good, it feels good. It's basically perfect.", imageName: "III"),
                      Model(title: "Air Jordan XI", description: "There's a reason this is the retro edition Nike puts out every year at Christmas. This is the shoe everyone wants on their feet, and it's been that way since the moment Boyz II Men rocked them at the 1996 Grammys.", imageName: "XI"),
                      Model(title: "Air Jordan IV", description: "This is the sneaker featured in the legendary scene in Do The Right Thing -- the movie that led to Spike Lee becoming Jordan's right-hand man in an unforgettable series of ads.", imageName: "IV"),
                      Model(title: "Air Jordan XII", description: "The sneaker that took the Jordan line from a Nike product to its own brand has held up remarkably well through the years, thanks in large part to its association with Michael's epic Flu Game.", imageName: "XII"),
                      Model(title: "Air Jordan V", description: "As a kid, I remember these more for Will Smith wearing them on The Fresh Prince of Bel-Air than for Michael wearing them on the court. Either way, they looked damn good.", imageName: "V"),
                      Model(title: "Air Jordan VII", description: "These were the shoes on Michael's feet when he played with the Dream Team in the 1992 Olympics. That itself would be worthy of a high ranking, but they also look and feel really good", imageName: "VII")]

    @IBAction func didTapStartButton(_ sender: Any) {
        let controller = Pager.PageContainerViewController.instantiate()
        present(controller, animated: true)

        let controllers = dataSource.map { _ in PageDetailViewController.instantiate() ?? PageDetailViewController() }
        controller.configure(with: dataSource, controllers: controllers)
    }
}

