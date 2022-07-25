import UIKit
import RxSwift

public protocol AppTheme {
    func apply()

    var colors: ThemeColor { get set }
    var defaultFont: AppFont? { get }
}

public protocol ViewTheme {
    var currentTheme: AppTheme { get }
    func setAppearance()
}

public enum ThemeType {
    case light
    case dark
}

public class MainTheme: AppTheme {
    public static var shared: AppTheme = MainTheme()
    
    public var type: ThemeType = .dark
    
    public lazy var colors: ThemeColor = {
        switch self.type {
        case .light:
            return WhiteThemeColors()
        case .dark:
            return BlackThemeColors()
        }
    }()
    
    public init() {}
    
    public init(type: ThemeType) {
        self.type = type
        self.apply()
    }

    public func apply() {
        self.configureNavBar()
        self.configureTextView()
        self.configureCollectionView()
    }

    func configureNavBar() {
        let navbar = UINavigationBar.appearance()
        navbar.isTranslucent = true
        navbar.isOpaque = false
        navbar.titleTextAttributes = [
            .foregroundColor: colors.mainTextColor,
            .font: UIFont.font(ofSize: 17, weight: .medium)
        ]
        navbar.backgroundColor = colors.mainColor
        navbar.barTintColor = colors.mainColor
        navbar.tintColor = colors.mainTextColor
        navbar.shadowImage = UIImage()
    }

    func configureTextView() {
        UITextView.appearance().tintColor = colors.mainTextColor
        UITextField.appearance().tintColor = colors.mainTextColor
    }

    func configureCollectionView() {
        UICollectionView.appearance().isPrefetchingEnabled = false
        UICollectionView.appearance().backgroundColor = colors.mainColor
    }

    // MARK: - Font

    public var defaultFont: AppFont?
}

extension UIImageView {
    func setImageColor(_ color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
