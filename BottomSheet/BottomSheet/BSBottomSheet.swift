
import Foundation
import UIKit

class BSBottomSheet: UIViewController {
    
    // MARK: - Methods
    
    func addHorizontalDragIndicator() {
        let height: CGFloat = 5
        let indicator = UIView()
        indicator.backgroundColor = .white
        indicator.alpha = 0.1
        indicator.layer.cornerRadius = height/2
        
        view.addSubview(indicator)
        indicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(height)
            make.width.equalTo(100)
        }
    }
}
