import UIKit

// MARK: - View Controller

final class ConfigurationViewController: BaseViewController {
    @IBOutlet var titleLabel: UILabel!
    var handler: ConfigurationEventHandler!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.handler.didLoad()
    }

    override func setAppearance() {
        super.setAppearance()
        let colors = currentTheme.colors
        self.titleLabel.textColor = colors.isBlackTheme ? colors.mainTextColor : .black.withAlphaComponent(0.6)
    }
}

extension ConfigurationViewController: ConfigurationViewBehavior {}
