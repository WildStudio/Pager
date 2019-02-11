//  Copyright © 2019 We Are Mobile First. All rights reserved.

import UIKit

protocol ItemPresentable {
    static func configuredWith(item: Presentable) -> UIViewController
}

struct BaseItemProvider: ItemPresentable  {
    public static func configuredWith(item: Presentable) -> UIViewController {
        return UIViewController()
    }
}


