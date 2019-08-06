import Foundation
import UIKit

// MARK: Protocols

protocol SheetScrollResponder: UIViewController {
    var delegate: hasBackgroundTapHandler? { get set }
    
    func bottomsheetDidScrollTo(_ value: CGPoint)
}
