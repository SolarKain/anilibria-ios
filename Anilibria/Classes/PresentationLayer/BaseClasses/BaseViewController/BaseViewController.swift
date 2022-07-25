import RxSwift
import UIKit

class BaseViewController: UIViewController, WaitingBehavior, LanguageBehavior {
    let disposeBag = DisposeBag()

    public var statusBarStyle: UIStatusBarStyle = .default
    public var currentTheme: AppTheme = MainTheme.shared

    deinit {
        print("[D] \(self) destroyed")
        NotificationCenter.default.removeObserver(self)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBackButton()
        self.setupStrings()
        self.setAppearance()
    }

    func initialize() {}

    func setupStrings() {}

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }

    func setupBackButton() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                style: .plain,
                                                                target: nil,
                                                                action: nil)
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let newTheme: AppTheme
        if traitCollection.userInterfaceStyle == .light {
            newTheme = MainTheme(type: .light)
        } else {
            newTheme = MainTheme(type: .dark)
        }
        self.currentTheme = newTheme
        MainTheme.shared = newTheme
        self.setAppearance()
    }

    // MARK: - App Terminated

    func addTermenateAppObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.appWillTerminate),
                                               name: UIApplication.willTerminateNotification, object: nil)
    }

    func setAppearance() {
        currentTheme.apply()
        let colors = currentTheme.colors
        let navbar = self.navigationController?.navigationBar
        self.view.backgroundColor = colors.mainColor
        navbar?.titleTextAttributes = [
            .foregroundColor: colors.mainTextColor,
            .font: UIFont.font(ofSize: 17, weight: .medium)
        ]
        navbar?.backgroundColor = colors.mainColor
        navbar?.barTintColor = colors.mainColor
    }

    @objc func appWillTerminate() {}

    // MARK: - Keyboard

    private var addedValue: CGFloat = 0
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyBoardWillShow(keyboardHeight: keyboardRectangle.height)
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        self.keyBoardWillHide()
    }

    public func keyBoardWillShow(keyboardHeight: CGFloat) {}

    public func keyBoardWillHide() {}

    // MARK: - Orientation

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}
