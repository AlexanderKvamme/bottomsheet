import Foundation
import UIKit


/// Superclass for RootViews to provide a navigationstack
class RootViewController: UIPageViewController, hasRoundedTopCorners, RootSheet {
    
    // MARK: - Properties
    
    var navigationStack = [UIViewController]()
//    var scrollableSheet: ScrollableBottomSheetContainer? { get set }
    weak var scrollableSheet: ScrollableBottomSheetContainer?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.solarstein.sapphire
        roundTopCorners()
    }
    
    private func setInitialSheet() {
        let sheet = PickerSheet("Please pick something!", choices: ["one", "two", "three"], delegate: self)
        navigationStack = [sheet]
        addSheetLayout(sheet)
    }
    
    func didTapNext() {
        let choices = ["Its like", "this", "and a", "that", "and a dis and a", "its like this", "and like this", "and like", "THAT", "What it to", "Mic check", "One, two"]
        let pickerSheet = PickerSheet("Pick something", choices: choices, delegate: self)
        push(pickerSheet)
    }
    
    func pop() {
        popSheet()
    }
}
