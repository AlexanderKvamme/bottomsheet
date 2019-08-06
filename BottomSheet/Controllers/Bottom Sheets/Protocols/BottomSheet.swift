import Foundation
import UIKit


protocol BottomSheet: UIViewController {
    var bottomSheetDelegate: BottomSheetDelegate? { get set }
}

