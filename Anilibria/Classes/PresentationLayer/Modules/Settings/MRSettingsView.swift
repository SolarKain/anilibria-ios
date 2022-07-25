import UIKit

// MARK: - View Controller

final class SettingsViewController: BaseViewController {
    @IBOutlet var selectedQualityLabel: UILabel!
    @IBOutlet var appNameLabel: UILabel!
    @IBOutlet var appVersionLabel: UILabel!
    @IBOutlet var globalNotifySwitch: UISwitch!

    @IBOutlet var notificationsView: BorderedView!
    @IBOutlet var notificationsTitle: UILabel!

    @IBOutlet var commonSettingsView: BorderedView!
    @IBOutlet var qualityLabel: UILabel!
    @IBOutlet var aboutView: BorderedView!
    var handler: SettingsEventHandler!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.handler.didLoad()
    }

    override func setupStrings() {
        super.setupStrings()
        self.navigationItem.title = L10n.Screen.Settings.title
    }

    override func setAppearance() {
        super.setAppearance()
        let colors = currentTheme.colors

        self.notificationsView.backgroundColor = colors.secondaryBackgroundColor
        self.commonSettingsView.backgroundColor = colors.secondaryBackgroundColor
        self.aboutView.backgroundColor = colors.secondaryBackgroundColor

        self.notificationsTitle.textColor = colors.mainTextColor
        self.qualityLabel.textColor = colors.mainTextColor
        self.appNameLabel.textColor = colors.mainTextColor
    }

    @IBAction func qualityAction(_ sender: Any) {
        self.handler.selectQuality()
    }

    @IBAction func globalSwitchAction(_ sender: Any) {
        self.handler.change(global: self.globalNotifySwitch.isOn)
    }
}

extension SettingsViewController: SettingsViewBehavior {
    func set(name: String, version: String) {
        self.appNameLabel.text = name
        self.appVersionLabel.text = version
    }

    func set(quality: VideoQuality) {
        self.selectedQualityLabel.text = quality.name
    }

    func set(global: Bool, animated: Bool) {
        self.globalNotifySwitch.setOn(global, animated: animated)
    }
}
