
import UIKit
import SnapKit


class BottomSheetContainerViewController: UIViewController {

    // MARK: Properties
    
    private let mainViewController: SheetScrollResponder
    private let sheetViewController: ScrollableBottomSheetContainer
    private lazy var bottomSheetContainerView = BottomSheetContainerView(mainView: mainViewController.view,
                                                                         sheetView: sheetViewController.view)

    // MARK: Initializers
    
    init(mainViewController: SheetScrollResponder, sheetViewController: UIPageViewController & RootSheet & hasRoundedTopCorners) {
        let bottomSheetContainer = ScrollableBottomSheetContainer(sheetViewController)
        self.mainViewController = mainViewController
        self.sheetViewController = bottomSheetContainer
        
        super.init(nibName: nil, bundle: nil)
        
        addChild(mainViewController)
        addChild(sheetViewController)
        
        bottomSheetContainer.bottomSheetDelegate = self
        
        view = bottomSheetContainerView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainViewController.didMove(toParent: self)
        sheetViewController.didMove(toParent: self)
    }
}

extension BottomSheetContainerViewController: BottomSheetDelegate {
    func bottomSheet(_ bottomSheet: BottomSheet, didScrollTo contentOffset: CGPoint) {
        bottomSheetContainerView.topDistance = max(0, -contentOffset.y)
        mainViewController.bottomsheetDidScrollTo(contentOffset)
    }
}
