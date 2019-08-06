import UIKit
import SnapKit


class DetailedTransactionViewController: UIViewController, isSheetViewController, DetailedTransactionView, hasTopLeftNavigationButton {
    
    // MARK: - Properties
    
    var onFinish: (() -> ())?
    
    var mainViewController: SheetScrollResponder
    var sheetViewController: BottomSheet
    var bottomSheetContainerView: BottomSheetContainerView
    lazy var topLeftNavigationButton = makeXButton()
    
    init(mainViewController: SheetScrollResponder, sheetViewController: BottomSheet & hasBackgroundTapHandler) {
        self.mainViewController = mainViewController
        self.mainViewController.delegate = sheetViewController
        self.sheetViewController = sheetViewController
        self.bottomSheetContainerView = BottomSheetContainerView(mainView: mainViewController.view, sheetView: sheetViewController.view)
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewController.didMove(toParent: self)
        sheetViewController.didMove(toParent: self)
        
        applyXButtonConstraints()
        topLeftNavigationButton.addTarget(self, action: #selector(performFinish), for: .touchUpInside)
    }
    
    // MARK: - Methods
    
    @objc private func performFinish() {
        onFinish?()
    }
    
    private func setup() {
        addChild(mainViewController)
        addChild(sheetViewController)
        
        sheetViewController.bottomSheetDelegate = self
        
        // FIXME: - Cleanup
        // alternativ til loadView
        
        view.addSubview(bottomSheetContainerView)
        bottomSheetContainerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        applyXButtonConstraints()
        topLeftNavigationButton.addTarget(self, action: #selector(performFinish), for: .touchUpInside)
    }
}

extension DetailedTransactionViewController: BottomSheetDelegate {
    func bottomSheet(_ bottomSheet: BottomSheet, didScrollTo contentOffset: CGPoint) {
        bottomSheetContainerView.topDistance = max(0, -contentOffset.y)
        mainViewController.bottomsheetDidScrollTo(contentOffset)
    }
}

