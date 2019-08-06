import UIKit
import SnapKit


final class BottomSheetContainer: UIViewController {

    // MARK: Properties
    
    private let underlyingController: BottomSheetDidScrollResponder
    private let overlyingSheetController: ScrollableBottomSheetContainer
    private lazy var bottomSheetContainerView = BottomSheetContainerView(underlyingView: underlyingController.view, overlyingSheetView: overlyingSheetController.view)

    // MARK: Initializers
    
    init(underlyingViewController: BottomSheetDidScrollResponder, overlyingSheetController: UIPageViewController & RootSheet & hasRoundedTopCorners) {
        let bottomSheetContainer = ScrollableBottomSheetContainer(overlyingSheetController)
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

extension BottomSheetContainer: BottomSheetDelegate {
    func bottomSheet(_ bottomSheet: BottomSheet, didScrollTo contentOffset: CGPoint) {
        bottomSheetContainerView.topDistance = max(0, -contentOffset.y)
        underlyingController.bottomsheetDidScrollTo(contentOffset)
    }
}
