//  Copyright © 2019 We Are Mobile First. All rights reserved.

import UIKit

final class PagesDataSource: NSObject, UIPageViewControllerDataSource {
    private let viewControllers: [UIViewController]
    private let items: [Item]
//    public var itemPresentable: UIViewController

    init?(items: [Item]) {
        self.items = items
        self.viewControllers = items.map(PageDetailViewController.configuredWith(item:))
    }

    func index(for controller: UIViewController) -> Int? {
        return viewControllers.index(of: controller)
    }

    func item(for controller: UIViewController) -> Presentable? {
        return index(for: controller).map { items[$0] }
    }

    func controller(for index: Int) -> UIViewController? {
        guard index >= 0 && index < self.viewControllers.count else { return nil }
        return viewControllers[index]
    }

    func controller(for item: Item) -> UIViewController? {
        var controller: UIViewController?
        _ = items.enumerated().map { index, itm in
            if itm == item {
                controller = viewControllers[index]
            }
        }

        return controller
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let pageIdx = viewControllers.index(of: viewController) else {
            fatalError("Couldn't find \(viewController) in \(viewControllers)")
        }

        let nextPageIdx = pageIdx + 1
        guard nextPageIdx < viewControllers.count else {
            return nil
        }

        return viewControllers[nextPageIdx]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let pageIdx = viewControllers.index(of: viewController) else {
            fatalError("Couldn't find \(viewController) in \(viewControllers)")
        }

        let previousPageIdx = pageIdx - 1
        guard previousPageIdx >= 0 else {
            return nil
        }

        return viewControllers[previousPageIdx]
    }
}
