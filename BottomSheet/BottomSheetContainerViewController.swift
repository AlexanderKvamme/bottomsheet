//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit
import SnapKit


protocol BottomSheetDelegate: AnyObject {
    func bottomSheet(_ bottomSheet: BottomSheet, didScrollTo contentOffset: CGPoint)
}

protocol BottomSheet: AnyObject {
    var bottomSheetDelegate: BottomSheetDelegate? { get set }
}

typealias BottomSheetViewController = UIViewController & BottomSheet

class BottomSheetContainerView: UIView {
 
    // MARK: - Properties
   
    private let mainView: UIView
    private let sheetView: UIView
    private let sheetBackground = BottomSheetBackgroundView()
    private var sheetBackgroundTopConstraint: Constraint? = nil
    
    // MARK: Computed properties
    
    var topDistance: CGFloat = 0 {
        didSet {
            sheetBackgroundTopConstraint?.layoutConstraints[0].constant = topDistance
        }
    }

    // MARK: - Initializers
    
    init(mainView: UIView, sheetView: UIView) {
        self.mainView = mainView
        self.sheetView = sheetView
        
        super.init(frame: .zero)
    
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    // MARK: - Methods
    private func setupViews() {
        // The main view fills the view completely
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        // The sheet background
        addSubview(sheetBackground)
        sheetBackground.snp.makeConstraints { (make) in
            self.sheetBackgroundTopConstraint = make.top.equalTo(safeAreaLayoutGuide.snp.top).constraint
            make.height.left.right.equalToSuperview()
        }
        
        // The sheet table view goes all the way up to the status bar
        addSubview(sheetView)
        sheetView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
        bringSubviewToFront(sheetView)
    }

    // MARK: - UIView overrides
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("sheet bounds: ", sheetBackground.bounds)
        print("hit point: ", point)
        if sheetBackground.bounds.contains(sheetBackground.convert(point, from: self)) {
            print("hit sheet")
            return sheetView.hitTest(sheetView.convert(point, from: self), with: event)
        }
        print("main bounds", mainView.bounds)
        print("hit main")
        return mainView.hitTest(mainView.convert(point, from: self), with: event)
    }
}

class BottomSheetContainerViewController: UIViewController {

    // MARK: - Properties
   
    private let mainViewController: UIViewController
    private let sheetViewController: BottomSheetViewController
    private lazy var bottomSheetContainerView = BottomSheetContainerView(mainView: mainViewController.view,
                                                                         sheetView: sheetViewController.view)
    
    // MARK: - Initializers
    
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
    
    // MARK: - Life Cycle
    
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
