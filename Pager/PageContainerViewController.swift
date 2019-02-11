//
//  ViewController.swift
//  Pager
//
//  Created by Christian Aranda on 02/02/2019.
//  Copyright © 2019 We Are Mobile First. All rights reserved.
//

import UIKit

final class PageContainerViewController: UIViewController {

    private var dataSource: PagesDataSource!
    private weak var pageViewController: UIPageViewController?
    private weak var pagerViewController: PagerMenuViewController?


    @IBOutlet private var loadingOverlayView: UIView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    private var currentPageIndex: Int = 0
    private var nextPageIndex: Int = 0

    internal static func instantiate() -> PageContainerViewController {
        return Storyboard.Main.instantiate(PageContainerViewController.self)
    }

    let items = [Item(title: "Item 1", description: "item 1"), Item(title: "Item 2", description: "item 2"), Item(title: "Item 3", description: "item 3"), Item(title: "Item 4", description: "item 4")]

    override func viewDidLoad() {
        super.viewDidLoad()

        pageViewController = children
            .compactMap { $0 as? UIPageViewController }.first
        pageViewController?.setViewControllers(
            [.init()],
            direction: .forward,
            animated: false,
            completion: nil
        )
        pageViewController?.delegate = self
        pagerViewController = children
            .compactMap { $0 as? PagerMenuViewController }.first
        pagerViewController?.delegate = self

        //        hideLoadingOverlay(false, false)

        configurePagerDataSource(items)
        pagerViewController?.configure(with:items)
    }

    private func configure() {
        //        guard isViewLoaded else {
        //            return
        //        }
        //
        //        switch viewModel.viewState.value {
        //        case .ready:
        //            guard !viewModel.channels.isEmpty else { return }
        //            hideLoadingOverlay(true, false)
        //            configurePagerDataSource(viewModel.channels)
        //            channelPagerViewController?.configure(with: viewModel.channels)
        //        default:
        //            break
        //        }
    }

    private func navigateToPage(item: Item) {
        pagerViewController?.select(item: item)
    }

    public func configurePagerDataSource(_ items: [Item]) {
        guard !items.isEmpty else { return }

        hideLoadingOverlay(true, false)
        dataSource = PagesDataSource(items: items)

        pageViewController?.dataSource = self.dataSource

        DispatchQueue.main.async {
            self.pageViewController?.setViewControllers(
                [self.dataSource.controller(for: 0)].compactMap { $0 } ,
                direction: .forward,
                animated: false,
                completion: { [weak self] _ in self?.pageViewController?.view.backgroundColor = .black }
            )
        }
    }

    private func setPageViewControllerScrollEnabled(_ enabled: Bool) {
        pageViewController?.dataSource = enabled == false ? nil : dataSource
    }

    private func hideLoadingOverlay(_ isHidden: Bool, _ animated: Bool) {
        if !isHidden {
            activityIndicator.startAnimating()
            loadingOverlayView.isHidden = false
            loadingOverlayView.alpha = 0.0
        }

        let duration = animated ? 0.2 : 0.0
        UIView.animate(withDuration: duration, animations: { [weak self] in
            let alpha: CGFloat = isHidden ? 0.0 : 1.0
            self?.loadingOverlayView.alpha = alpha
            }, completion: { [weak self] _ -> Void in
                if isHidden {
                    self?.activityIndicator.stopAnimating()
                    self?.loadingOverlayView.isHidden = true
                }
        })
    }
}

extension PageContainerViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        //        self.viewModel.pageTransition(completed: completed)
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        willTransitionTo pendingViewControllers: [UIViewController]) {

        guard let index = pendingViewControllers.first.flatMap(self.dataSource.index(for:)) else {
            return
        }

        nextPageIndex = index
    }

    func pageTransition(completed: Bool) {
        if completed {
            currentPageIndex = nextPageIndex
            navigateToPage(item: items[safe: currentPageIndex]!)
        }
    }
}

extension PageContainerViewController: PagerMenuViewControllerDelegate {
    func itemPager(_ viewController: UIViewController, selectedItem item: Item) {
        guard let controller = self.dataSource.controller(for: item) else {
            fatalError("Controller not found for item \(item)")
        }

        _ = items.enumerated().map { index, itm in
            if itm == item {
                let currentIndex = currentPageIndex
                nextPageIndex = index

                let direction: UIPageViewController.NavigationDirection = currentIndex > index ? .reverse : .forward

                self.pageViewController?.setViewControllers(
                    [controller], direction: direction, animated: true, completion: { complete -> Void in
                        self.pageTransition(completed: complete)
                })

            }
        }
    }
}
