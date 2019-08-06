import Foundation
import UIKit


protocol BottomSheetDelegate: AnyObject {
    func bottomSheet(_ bottomSheet: hasBottomSheetDelegate, didScrollTo contentOffset: CGPoint)
}

protocol hasBottomSheetDelegate: AnyObject {
    var bottomSheetDelegate: BottomSheetDelegate? { get set }
}

protocol BottomSheetDidScrollResponder: UIViewController {
    func bottomsheetDidScrollTo(_ value: CGPoint)
}
