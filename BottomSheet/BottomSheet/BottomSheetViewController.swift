import Foundation
import UIKit

// MARK: - RootSheet

protocol RootSheet {
    func didTapNext()
    func pop()
    func push(_ sheet: UIViewController)
    
    var scrollableSheet: BSScrollableSheetContainer? { get set }
}

// MARK: - BottomSheetViewController

/// Superclass for RootViews to provide a navigationstack
class BottomSheetViewController: UIPageViewController, RootSheet {
    
    // MARK: Properties
    
    var navigationStack = [UIViewController]()
    weak var scrollableSheet: BSScrollableSheetContainer?
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.solarstein.sapphire
        roundTopCorners()
    }
    
    final func roundTopCorners() {
        view.roundCorners(corners: [.topLeft, .topRight])
    }

    // MARK: RootSheet Conformance
    
    func didTapNext() {
        print("implement me")
    }
    
    final func setInitial(sheet: UIViewController) {
        navigationStack = [sheet]
        addSheetLayout(sheet)
    }
    
    final func push(_ sheet: UIViewController) {
        // remove topsheet
        if let topSheet = navigationStack.last {
            removeSheetLayout(topSheet)
        }
        
        // add new sheet
        self.navigationStack.append(sheet)
        addSheetLayout(sheet)
        scrollableSheet!.scrollToBottom()
    }
    
    final func pop() {
        guard let topSheet = navigationStack.last, navigationStack.count > 1 else { return }

        removeSheetLayout(topSheet)
        navigationStack.remove(at: navigationStack.index(of: topSheet)!)
        
        if let previousSheet = navigationStack.last {
            addSheetLayout(previousSheet)
            scrollableSheet!.scrollToBottom()
        }
    }
    
    private func addSheetLayout(_ sheet: UIViewController) {
        addChild(sheet)
        view.addSubview(sheet.view)
        sheet.view.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    private func removeSheetLayout(_ sheet: UIViewController) {
        sheet.view.removeFromSuperview()
        sheet.removeFromParent()
    }
}
