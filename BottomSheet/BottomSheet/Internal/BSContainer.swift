import UIKit
import SnapKit


final class BSContainer: UIViewController {

    // MARK: Properties
    
    private let underlyingController: BottomSheetDidScrollResponder
    private let overlyingSheetController: BSScrollableSheetContainer
    private lazy var bottomSheetContainerView = BSContainerView(underlyingView: underlyingController.view, overlyingSheetView: overlyingSheetController.view)

    // MARK: Initializers
    
    init(underlyingViewController: BottomSheetDidScrollResponder, overlyingSheetController: UIPageViewController & RootSheet & hasRoundedTopCorners) {
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

// MARK: - Extensions

extension BSContainer: BottomSheetDelegate {
    func bottomSheet(_ bottomSheet: hasBottomSheetDelegate, didScrollTo contentOffset: CGPoint) {
        bottomSheetContainerView.topDistance = max(0, -contentOffset.y)
        underlyingController.bottomsheetDidScrollTo(contentOffset)
    }
}
