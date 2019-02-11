//
//  PagerViewController.swift
//  Pager
//
//  Created by Christian Aranda on 02/02/2019.
//  Copyright © 2019 We Are Mobile First. All rights reserved.
//


import UIKit

protocol Presentable {
    var description: String { get set }
}

extension Presentable {
    static func == (lhs: Presentable, rhs: Presentable) -> Bool {
        return lhs.description == rhs.description
    }
}


struct Item: Presentable {

    var title: String
    var description: String = ""

    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.description == rhs.description
    }
}

protocol PagerMenuViewControllerDelegate: class {
    func itemPager(_ viewController: UIViewController, selectedItem item: Item)
}

final class PagerMenuViewController: UIViewController {
    private enum Constants {
        static let horizontalInset: CGFloat = 15
    }

    public var horizontalInset: CGFloat = 15
    public var buttonTitleColor: UIColor = .gray
    public var buttonTitleColorSelected: UIColor = .black
    public var buttonFontSize: CGFloat = 15
    public var buttonWidth: CGFloat = 155

    internal weak var delegate: PagerMenuViewControllerDelegate?
    @IBOutlet private var borderLineView: UIView!
    @IBOutlet private var indicatorView: UIView!
    @IBOutlet private var indicatorViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var indicatorViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var itemsStackView: UIStackView!
    @IBOutlet private var itemsStackViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var itemsStackViewTrailingConstraint: NSLayoutConstraint!
    private var itemsStackViewCenterXConstraint: NSLayoutConstraint?
    private var items: [Item] = []

    static func instantiate() -> PagerMenuViewController {
        return Storyboard.Main.instantiate(PagerMenuViewController.self)
    }

    func configure(with items: [Item]) {
        self.items = items
        createButtons(items)
        if let button = self.itemsStackView.arrangedSubviews.first as? UIButton {
            button.isSelected = true
        }
    }

    func select(item: Item) {
        _ = items.enumerated().map { index, itm in
            if itm == item {
                selectButton(atIndex: index)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        itemsStackViewCenterXConstraint?.isActive = true
        itemsStackViewLeadingConstraint.isActive = true
        itemsStackViewTrailingConstraint.isActive = true
        itemsStackViewCenterXConstraint = itemsStackView.centerXAnchor
            .constraint(equalTo: self.view.centerXAnchor)
        setPagerEnabled(false)
    }

    private func createButtons(_ items: [Presentable]) {
        itemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        _ = items.enumerated().map { index, item in
            let button = UIButton()
            button.setTitle(item.description, for: .normal)
            button.setTitleColor(.gray, for: .normal)
            button.setTitleColor(.black, for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: buttonFontSize)
            button.contentEdgeInsets = UIEdgeInsets(top: 0,
                                                    left: horizontalInset,
                                                    bottom: 0,
                                                    right: horizontalInset)
            button.sizeToFit()
            button.backgroundColor = .clear
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            itemsStackView.addArrangedSubview(button)
        }
        setPagerEnabled(true)
    }

    private func setPagerEnabled(_ isEnabled: Bool) {
        view.isUserInteractionEnabled = isEnabled
        scrollView.alpha = isEnabled ? 1.0 : 0.0
        borderLineView.alpha = isEnabled ? 1.0 : 0.0
    }

    private func selectButton(atIndex index: Int) {
        for (buttonIndex, button) in itemsStackView.arrangedSubviews.enumerated() {
            if let selected = (button as? UIButton) {
                selected.isSelected = (buttonIndex == index)
            }
        }

        pinSelectedIndicator(toPage: index, animated: true)
    }

    private func pinSelectedIndicator(toPage page: Int, animated: Bool) {
        guard let button = itemsStackView.arrangedSubviews[page] as? UIButton else { return }

        let leadingConstant = itemsStackView.frame.origin.x + button.frame.origin.x
        let widthConstant = button.frame.width

        indicatorViewLeadingConstraint.constant = leadingConstant
        indicatorViewWidthConstraint.constant = widthConstant

        let stackViewWidth = itemsStackView.frame.width

        UIView.animate(withDuration: animated ? 0.2 : 0.0, animations: {
            self.scrollView.layoutIfNeeded()
            let width = self.view.bounds.width
            self.scrollView.contentOffset = CGPoint(
                x:leadingConstant + (button.frame.width / 2) - (width / 2),
                y: 0)

            if self.scrollView.contentOffset.x > stackViewWidth ||
                self.scrollView.contentOffset.x > stackViewWidth - width {
                self.scrollView.scrollToRight(animated: false)

            } else if self.scrollView.contentOffset.x < 0.0 {
                self.scrollView.scrollToLeft(animated: false)
            }
        })
    }

    @objc private func buttonTapped(_ button: UIButton) {
        guard let item = items[safe: button.tag] else { return }
        delegate?.itemPager(self, selectedItem: item)
    }
}

extension UIScrollView {

    func scrollToRight(animated: Bool) {
        let inset = contentInset
        let contentWidth = contentSize.width
        let viewportWidth = bounds.width
        let offset = contentWidth - inset.right + inset.left - viewportWidth
        setContentOffset(CGPoint(x: offset, y: 0), animated: animated)
    }

    func scrollToLeft(animated: Bool) {
        let leftInset: CGFloat
        if #available(iOS 11.0, *) {
            leftInset = adjustedContentInset.left
        } else {
            leftInset = contentInset.left
        }
        setContentOffset(CGPoint(x: leftInset, y: 0), animated: animated)
    }
}
