import Foundation
import UIKit


protocol RootSheet {
    func didTapNext()
    func pop()
    func push(_ sheet: UIViewController)
    
    var router: Router { get }
    
    var scrollableSheet: ScrollableBottomSheetContainer? { get set }
}
