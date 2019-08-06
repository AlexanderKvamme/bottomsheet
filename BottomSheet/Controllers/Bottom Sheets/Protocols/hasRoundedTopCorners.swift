import UIKit


// MARK: Protocols

protocol hasRoundedTopCorners {
    func roundTopCorners()
}

// MARK: Extensions

extension hasRoundedTopCorners where Self: UIViewController {
    func roundTopCorners() {
        view.roundCorners(corners: [.topLeft, .topRight])
    }
}
