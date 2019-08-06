import Foundation
import UIKit


protocol BottomSheetDelegate: AnyObject {
    func bottomSheet(_ bottomSheet: BottomSheet, didScrollTo contentOffset: CGPoint)
}

protocol hasBackgroundTapHandler: class {
    func backgroundSheetWasTapped()
}
