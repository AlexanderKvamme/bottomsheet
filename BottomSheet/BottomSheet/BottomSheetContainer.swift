import UIKit
import SnapKit

// MARK: - BSContainer

final class BottomSheetContainer: UIViewController {

    // MARK: Properties
    
    private let underlyingController: BottomSheetDidScrollResponder
    private let overlyingSheetController: BSScrollableSheetContainer
    private lazy var bottomSheetContainerView = BSContainerView(underlyingView: underlyingController.view, overlyingSheetView: overlyingSheetController.view)

    // MARK: Initializers
    
    init(underlyingViewController: BottomSheetDidScrollResponder, overlyingSheetController: BottomSheetViewController) {
        let bottomSheetContainer = BSScrollableSheetContainer(overlyingSheetController)
        self.underlyingController = underlyingViewController
        self.overlyingSheetController = bottomSheetContainer
        
        super.init(nibName: nil, bundle: nil)
        
        addChild(underlyingViewController)
        addChild(overlyingSheetController)
        
        bottomSheetContainer.bottomSheetDelegate = self
        
        view = bottomSheetContainerView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        underlyingController.didMove(toParent: self)
        overlyingSheetController.didMove(toParent: self)
    }
}

// MARK: Extensions

extension BottomSheetContainer: BottomSheetDelegate {
    func bottomSheet(_ bottomSheet: hasBottomSheetDelegate, didScrollTo contentOffset: CGPoint) {
        bottomSheetContainerView.topDistance = max(0, -contentOffset.y)
        underlyingController.bottomsheetDidScrollTo(contentOffset)
    }
}

// MARK: - BSContainerView

fileprivate class BSContainerView: UIView {
    
    // MARK: Properties
    
    private let mainView: UIView
    private let sheetView: UIView
    private let sheetBackground = BSBackgroundView()
    private var sheetBackgroundTopConstraint: Constraint? = nil
    var topDistance: CGFloat = 0 {
        didSet {
            sheetBackgroundTopConstraint?.layoutConstraints[0].constant = topDistance
        }
    }
    
    // MARK: Initializers
    
    init(underlyingView: UIView, overlyingSheetView: UIView) {
        self.mainView = underlyingView
        self.sheetView = overlyingSheetView
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    // MARK: Methods
    
    private func setupViews() {
        // The main view fills the view completely
        addSubview(mainView)
        
        mainView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        // The sheet background
        addSubview(sheetBackground)
        sheetBackground.snp.makeConstraints { (make) in
            self.sheetBackgroundTopConstraint = make.top.equalTo(safeAreaLayoutGuide.snp.top).constraint
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        sheetBackground.backgroundColor = UIColor.solarstein.sapphire
        
        // The sheet table view goes all the way up to the status bar
        addSubview(sheetView)
        
        sheetView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: UIView overrides
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if sheetBackground.bounds.contains(sheetBackground.convert(point, from: self)) {
            return sheetView.hitTest(sheetView.convert(point, from: self), with: event)
        }
        return mainView.hitTest(mainView.convert(point, from: self), with: event)
    }
}

// MARK: - BSBackgroundView

/// Used to calculate hitbox in the bottomsheetcontainer
fileprivate class BSBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        roundCorners(corners: [.topLeft, .topRight])
        // Make sure border isn't visible
        layer.bounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: bounds.size.height))
    }
}
