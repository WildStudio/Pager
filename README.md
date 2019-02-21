<img src="https://github.com/WildStudio/Pager/blob/master/header.png">

<a href="https://github.com/WildStudio/Pager">

<h4>iOS UI library written on Swift.</h4>
___

Pager library is the easiest way of setting up a Pager.  It comes with some convenience methods like, disabling swipe, and navigating backwards and forwards. Pager handles the menu navigation to navigate to a specific page.

<img align="center" src="https://github.com/WildStudio/Pager/blob/master/animation.gif" width="140" height="315" /></a>

## Requirements

- iOS 10.0+
- Xcode 9

## Installation

Just add the Source folder to your project.

or use [CocoaPods](https://cocoapods.org) with Podfile:

``` ruby
pod 'Pager'
```
## Usage

1) Create a your Model object inheriting from: `Ìtem` lie this:

```
class Model: Item {
    let image: String

    init(title: String, description: String, imageName: String) {
        self.image = imageName
        super.init(title: title, description: description)
    }
}

```

2) Create your detail view controller and conform to `ItemPresentable` lie this:

```
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
```

3) Create PagerContainerViewController and configure:

```

let controller = Pager.PageContainerViewController.instantiate()
present(controller, animated: true)

let controllers = dataSource.map { _ in PageDetailViewController.instantiate() ?? PageDetailViewController() }
controller.configure(with: dataSource, controllers: controllers)
```

## License

Pager is released under the MIT license.

If you use the open-source library in your project, please make sure to credit.
