//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit
import SnapKit

protocol SheetScrollResponder: UIViewController {
    func bottomsheetDidScrollTo(_ value: CGPoint)
}

class BottomSheetContainerViewController: UIViewController, hasXButton {

    // MARK: - Properties
    
    lazy var xButton = makeXButton()
    
    private let mainViewController: SheetScrollResponder
    private let sheetViewController: BottomSheetViewController
    private lazy var bottomSheetContainerView = BottomSheetContainerView(mainView: mainViewController.view,
                                                                         sheetView: sheetViewController.view)
    
    // MARK: - Initializers
    
    init(mainViewController: SheetScrollResponder, sheetViewController: BottomSheetViewController) {
        self.mainViewController = mainViewController
        self.sheetViewController = sheetViewController
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Methods
    
    private func setup() {
        addChild(mainViewController)
        addChild(sheetViewController)
        
        sheetViewController.bottomSheetDelegate = self
    }
    
    private func addSubviewsAndConstraints() {
        applyXButtonConstraints()
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

