import UIKit

private extension ActionCell {
    struct Appearance {
        let borderColor: CGColor = UIColor.lightGray.cgColor
        let borderWidth: CGFloat = 1
    }
}

public final class ActionCell: RippleViewCell {
    @IBOutlet var titleLabel: UILabel!

    private let appearance = Appearance()

    func configure(_ item: String) {
        self.titleLabel.text = item
        self.setAppearance()
    }

    public override func setAppearance() {
        super.setAppearance()
        self.rippleContainerView.backgroundColor = currentTheme.colors.secondaryBackgroundColor
        self.rippleContainerView.layer.borderWidth = appearance.borderWidth
        self.rippleContainerView.layer.borderColor = currentTheme.colors.isBlackTheme ?
        appearance.borderColor : currentTheme.colors.mainColor.cgColor
    }

    public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        self.layer.zPosition = CGFloat.createFromParts(int: layoutAttributes.indexPath.section,
                                                       fractional: layoutAttributes.indexPath.row)
    }
}
