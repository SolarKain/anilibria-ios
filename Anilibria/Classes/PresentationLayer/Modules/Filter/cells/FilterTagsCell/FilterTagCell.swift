import UIKit

public final class FilterTagCell: RippleViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backView: UIView!

    private var bag: Any?
    private var isFilterSelected: Bool = false
    private static let titleBuilder: AttributeStringBuilder = AttributeStringBuilder()
        .set(font: UIFont.font(ofSize: 15, weight: .regular))

    func configure(_ item: Selectable<String>) {
        self.isFilterSelected = item.isSelected
        self.titleLabel.text = item.value
        self.subscribe(item)
        self.setAppearance()
    }

    public override func setAppearance() {
        super.setAppearance()
        self.backgroundColor = .clear
        let colors = currentTheme.colors
        var defaultTitleColor: UIColor = .white
        if !colors.isBlackTheme {
            defaultTitleColor = .black
        }
        self.titleLabel.textColor = isFilterSelected ? .white : defaultTitleColor
        self.backView.backgroundColor = isFilterSelected ? colors.noticeColor : colors.secondaryBackgroundColor
    }

    private func subscribe(_ item: Selectable<String>) {
        self.bag = item.observe(\Selectable<String>.isSelected) { [weak self] _,_ in
            self?.renderSelect(item)
        }
    }

    static func size(for item: Selectable<String>) -> CGSize {
        let height: CGFloat = 38
        let width: CGFloat = self.titleBuilder.build(item.value).width(for: height) + 30
        return CGSize(width: width, height: height)
    }

    private func renderSelect(_ item: Selectable<String>) {
        UIView.animate(withDuration: 0.3) {
            self.isFilterSelected = item.isSelected
            self.setAppearance()
        }
    }
}
