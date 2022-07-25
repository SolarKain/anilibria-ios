import UIKit

// MARK: - View Controller

final class OtherViewController: BaseViewController {
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var headContainer: UIView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var authButton: UIButton!
    @IBOutlet var linksStakView: UIStackView!
	@IBOutlet var historyView: UIView!
    @IBOutlet var teamView: UIView!
    @IBOutlet var supportView: UIView!
    @IBOutlet var settingsView: UIView!

    var handler: OtherEventHandler!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.handler.didLoad()

		if UIDevice.current.userInterfaceIdiom == .pad {
			historyView.isHidden = true
		}
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func setAppearance() {
        super.setAppearance()
        let colors = currentTheme.colors
        self.userNameLabel.textColor = colors.mainTextColor
        self.authButton.setTitleColor(colors.mainTextColor, for: .normal)
        self.linksStakView.backgroundColor = colors.secondaryBackgroundColor
        self.historyView.backgroundColor = colors.secondaryBackgroundColor
        self.headContainer.backgroundColor = colors.mainColor
        self.topLineView.backgroundColor = colors.mainColor
        self.teamView.backgroundColor = colors.secondaryBackgroundColor
        self.supportView.backgroundColor = colors.secondaryBackgroundColor
        self.settingsView.backgroundColor = colors.secondaryBackgroundColor

        for item in linksStakView.subviews {
            if let view = item as? LinkView {
                view.setAppearance(colors: currentTheme.colors)
            }
        }
    }

    // MARK: - Actions

    @IBAction func loginLogOutAction(_ sender: Any) {
        self.handler.loginOrLogout()
    }

    @IBAction func historyAction(_ sender: Any) {
        self.handler.history()
    }

    @IBAction func teamAction(_ sender: Any) {
        self.handler.team()
    }

    @IBAction func donateAction(_ sender: Any) {
        self.handler.donate()
    }

    @IBAction func settingsAction(_ sender: Any) {
        self.handler.settings()
    }
}

extension OtherViewController: OtherViewBehavior {
    func set(user: User?) {
        self.userNameLabel.text = user?.name ?? L10n.Common.guest
        let title = user == nil ? L10n.Buttons.signIn : L10n.Buttons.signOut
        self.authButton.setTitle(title, for: .normal)
    }

    func set(links: [LinkData]) {
        let views = links.lazy.compactMap { item -> LinkView? in
            let view = LinkView.fromNib()
            view?.configure(item)
            view?.setAppearance(colors: self.currentTheme.colors)
            view?.setTap { [weak self] in
                self?.handler.tap(link: $0)
            }
            return view
        }
        for view in views {
            self.linksStakView.addArrangedSubview(view)
        }
    }
}
