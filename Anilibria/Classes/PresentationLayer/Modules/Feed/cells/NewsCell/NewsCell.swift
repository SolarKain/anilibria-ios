import UIKit

public final class NewsCell: RippleViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var viewsIconView: UIImageView!
    @IBOutlet var viewsCountLabel: UILabel!
    @IBOutlet var commentsIconView: UIImageView!
    @IBOutlet var commentsCountLabel: UILabel!

    private static let titleBuilder: AttributeStringBuilder = AttributeStringBuilder()
        .set(font: UIFont.font(ofSize: 15, weight: .medium))

    func configure(_ item: News) {
        self.titleLabel.attributedText = Self.titleBuilder.build(item.title)
        self.commentsCountLabel.text = "\(item.comments)"
        self.viewsCountLabel.text = "\(item.views)"
        self.imageView.setImage(from: item.image,
                                placeholder: UIImage(named: "img_placeholder"))
        self.setAppearance()
    }

    public override func setAppearance() {
        super.setAppearance()
        let colors = currentTheme.colors
        self.rippleContainerView.backgroundColor = colors.secondaryBackgroundColor
        self.titleLabel.textColor = colors.mainTextColor
        self.viewsCountLabel.textColor = colors.secondaryTextColor
        self.commentsCountLabel.textColor = colors.secondaryTextColor
        self.viewsIconView.tintColor = colors.subviewsColor
        self.commentsIconView.tintColor = colors.subviewsColor
    }

    static func height(for item: News, with width: CGFloat) -> CGFloat {
        let containerWidth = width - 32
        let imageHight = containerWidth * 9 / 16
        let titleHight = self.titleBuilder.build(item.title).height(for: containerWidth - 20)
        return imageHight + titleHight + 67
    }

    public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        self.layer.zPosition = CGFloat.createFromParts(int: layoutAttributes.indexPath.section,
                                                       fractional: layoutAttributes.indexPath.row)
    }
}
