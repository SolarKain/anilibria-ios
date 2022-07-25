import UIKit

public protocol ThemeColor {
    // MARK: - Colors
    var isBlackTheme: Bool { get }
    var mainColor: UIColor { get }
    var mainBackgroundColor: UIColor { get }
    var secondaryBackgroundColor: UIColor { get }
    var mainTextColor: UIColor { get }
    var secondaryTextColor: UIColor { get }
    var infoColor: UIColor { get }
    var noticeColor: UIColor { get }
    var subviewsColor: UIColor { get }
    var pageIndicatorTintColor: UIColor { get }
    var currentPageIndicatorTintColor: UIColor { get }
    var pageBackgroundColor: UIColor { get }
}

public class WhiteThemeColors: ThemeColor {
    public var isBlackTheme: Bool = false
    public var mainColor: UIColor = .white
    public var mainBackgroundColor: UIColor = .white
    public var secondaryBackgroundColor: UIColor = #colorLiteral(red: 0.9247149825, green: 0.9219169021, blue: 0.9385299683, alpha: 1)
    public var mainTextColor: UIColor = .black
    public var secondaryTextColor: UIColor = .darkGray
    public var infoColor: UIColor = .red
    public var noticeColor: UIColor = #colorLiteral(red: 0.707420184, green: 0, blue: 0, alpha: 1)
    public var subviewsColor: UIColor = .darkGray
    public var pageIndicatorTintColor: UIColor = .black
    public var currentPageIndicatorTintColor: UIColor = .white
    public var pageBackgroundColor: UIColor = .white
}

public class BlackThemeColors: ThemeColor {
    public var isBlackTheme: Bool = true
    public var mainColor: UIColor = UIColor(hexString: "1E1E1E")!
    public var mainBackgroundColor: UIColor = UIColor(hexString: "1E1E1E")!
    public var secondaryBackgroundColor: UIColor = UIColor(hexString: "0E0E0E")!
    public var mainTextColor: UIColor = .white
    public var secondaryTextColor: UIColor = .lightGray
    public var infoColor: UIColor = .red
    public var noticeColor: UIColor = #colorLiteral(red: 0.707420184, green: 0, blue: 0, alpha: 1)
    public var subviewsColor: UIColor = .white
    public var pageIndicatorTintColor: UIColor = .white
    public var currentPageIndicatorTintColor: UIColor = .lightGray
    public var pageBackgroundColor: UIColor = .darkGray
}
