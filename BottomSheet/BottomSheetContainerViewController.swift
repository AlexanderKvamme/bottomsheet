//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit
import SnapKit

protocol SheetScrollResponder: UIViewController {
    func bottomsheetDidScrollTo(_ value: CGPoint)
}

class BottomSheetContainerViewController: UIViewController {

//    private let mainViewController: UIViewController
    private let mainViewController: SheetScrollResponder
    private let sheetViewController: ScrollableBottomSheetContainer
    private lazy var bottomSheetContainerView = BottomSheetContainerView(mainView: mainViewController.view,
                                                                         sheetView: sheetViewController.view)
    
    //    init(mainViewController: SheetScrollResponder, sheetViewController: BottomSheetViewController) {
    init(mainViewController: SheetScrollResponder, sheetViewController: UIPageViewController & RootSheet & hasRoundedTopCorners) {
        
        let bottomSheetContainer = ScrollableBottomSheetContainer(sheetViewController)
        
        // OLD
//        self.mainViewController = mainViewController
//        self.sheetViewController = sheetViewController
        
        // NEW
        // FIXME: Make this happend inside this init:
        // ScrollableBottomSheetContainer(rootSheet)
        self.mainViewController = mainViewController
        self.sheetViewController = bottomSheetContainer
        
        super.init(nibName: nil, bundle: nil)
        
        addChild(mainViewController)
        addChild(sheetViewController)
        
//        sheetViewController.bottomSheetDelegate = self
        bottomSheetContainer.bottomSheetDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = bottomSheetContainerView
    }
    
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
