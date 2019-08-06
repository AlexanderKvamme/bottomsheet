import Foundation
import UIKit


/// Superclass for RootViews to provide a navigationstack
class BottomSheetViewController: UIPageViewController, hasRoundedTopCorners, RootSheet {
    
    // MARK: - Properties
    
    var navigationStack = [UIViewController]()
    weak var scrollableSheet: BSScrollableSheetContainer?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.solarstein.sapphire
        roundTopCorners()
    }
    
    func didTapNext() {
        print("implement me")
    }
    
    func pop() {
        print("implement me")
    }
}
