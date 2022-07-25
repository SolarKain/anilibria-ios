import Foundation
import IGListKit

class BaseCollectionCell: UICollectionViewCell, ListAdapterDataSource, ViewTheme {
    public var currentTheme: AppTheme = MainTheme.shared

    // MARK: - Outlets

    @IBOutlet var collectionView: UICollectionView!
    var items: [ListDiffable] = []

    // MARK: - Properties

    public lazy var adapter: ListAdapter = {
        ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
    }()

    public var scrollViewDelegate: UIScrollViewDelegate? {
        get {
            return self.adapter.scrollViewDelegate
        }
        set {
            self.adapter.scrollViewDelegate = newValue
        }
    }

    private lazy var manager: AdapterManager = { [unowned self] in
        AdapterManager(items: self.adapterCreators())
    }()

    // MARK: - Setup

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }

    func setup() {
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
        self.setAppearance()
    }

    public func setAppearance() {
        self.backgroundColor = currentTheme.colors.mainColor
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let newTheme: AppTheme
        if traitCollection.userInterfaceStyle == .light {
            newTheme = MainTheme(type: .light)
        } else {
            newTheme = MainTheme(type: .dark)
        }
        self.currentTheme = newTheme
        self.setAppearance()
    }

    // MARK: - Methods

    public func adapterCreators() -> [AdapterCreator] {
        fatalError("Override me")
    }

    public func update(animated: Bool = true,
                       completion: ListUpdaterCompletion? = nil) {
        self.adapter.performUpdates(animated: animated, completion: completion)
    }

    public func reload(completion: ListUpdaterCompletion? = nil) {
        self.adapter.reloadData(completion: completion)
    }

    // MARK: - IGListAdapterDataSource

    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.items
    }

    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return self.manager.adapter(from: object)
    }

    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
