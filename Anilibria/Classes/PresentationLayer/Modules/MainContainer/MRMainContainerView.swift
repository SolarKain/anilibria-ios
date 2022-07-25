import UIKit

// MARK: - View Controller

final class MainContainerViewController: BaseViewController, ChildNavigationContainer {
    @IBOutlet var menuTabBar: MenuTabController!
    @IBOutlet var childContainerView: UIView?

    var handler: MainContainerEventHandler!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.handler.didLoad()
        self.setAppearance()
    }

    public override func setAppearance() {
        super.setAppearance()
        let colors = currentTheme.colors
        self.menuTabBar.backgroundColor = colors.mainColor
        self.menuTabBar.superview?.backgroundColor = colors.mainColor
        self.childContainerView?.backgroundColor = colors.mainColor

        for item in self.menuTabBar.subviews {
            if let view = item as? MenuItemView {
                view.setAppearance(colors: colors)
            }
        }
    }
}

extension MainContainerViewController: MainContainerViewBehavior {
    func set(items: [MenuItem]) {
        self.menuTabBar.set(items) { [weak self] type in
            self?.handler.select(item: type)
        }
    }

    func set(selected: MenuItemType) {
        self.menuTabBar.set(selected: selected)
    }

    func change(visible: Bool, for item: MenuItemType) {
        self.menuTabBar.change(visible: visible, for: item)
    }
}

final class MenuTabController: UIStackView {
    private var views: [MenuItemView] = []

    func set(_ items: [MenuItem], selectionChanged: @escaping Action<MenuItemType>) {
        self.views.forEach {
            $0.removeFromSuperview()
        }

        self.views = []

        items.forEach {
            let item = MenuItemView()
            item.configure($0)
            item.setTap(selectionChanged)
            self.views.append(item)
            self.addArrangedSubview(item)
        }
    }

    func set(selected: MenuItemType) {
        self.views.forEach {
            $0.isSelected = $0.type == selected
        }
    }

    func change(visible: Bool, for item: MenuItemType) {
        let value = self.views.first(where: { $0.type == item })
        value?.isHidden = !visible
    }
}
