//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit
import SnapKit


class BottomSheetContainerViewController: UIViewController {

    private let mainViewController: UIViewController
    private let sheetViewController: BottomSheetViewController
    private lazy var bottomSheetContainerView = BottomSheetContainerView(mainView: mainViewController.view,
                                                                         sheetView: sheetViewController.view)
    
    init(mainViewController: UIViewController, sheetViewController: BottomSheetViewController) {
        self.mainViewController = mainViewController
        self.sheetViewController = sheetViewController
        
        super.init(nibName: nil, bundle: nil)
        
        addChild(mainViewController)
        addChild(sheetViewController)
        
        sheetViewController.bottomSheetDelegate = self
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
    }
}
