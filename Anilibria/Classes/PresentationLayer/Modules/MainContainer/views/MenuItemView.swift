import UIKit

final class MenuItemView: LoadableView {
    @IBOutlet weak var button: RippleButton!
    @IBOutlet var iconView: UIImageView!
    private(set) var type: MenuItemType?
    private var colors = MainTheme.shared.colors

    private var tapHandler: Action<MenuItemType>?

    public var isSelected: Bool = false {
        didSet {
            self.iconView.tintColor = self.isSelected ? colors.infoColor : colors.mainTextColor
        }
    }

    func configure(_ item: MenuItem) {
        self.iconView.image = item.icon
        self.type = item.type
        self.setAppearance(colors: self.colors)
    }

    func setAppearance(colors: ThemeColor) {
        self.colors = colors
        self.iconView.backgroundColor = colors.mainColor
        self.button.backgroundColor = colors.mainColor
        self.backgroundColor = colors.mainColor
        self.iconView.tintColor = self.isSelected ? colors.infoColor : colors.mainTextColor
    }

    func setTap(_ handler: @escaping Action<MenuItemType>) {
        self.tapHandler = handler
    }

    @IBAction func tapAction(_ sender: Any) {
        if let type = self.type {
            self.tapHandler?(type)
        }
    }
}
