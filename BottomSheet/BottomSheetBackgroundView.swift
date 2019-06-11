//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit


/// Used to calculate hitbox in the bottomsheetcontainer
class BottomSheetBackgroundView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
 
        // Make sure border isn't visible
        layer.bounds = CGRect(origin: bounds.origin,
                              size: CGSize(width: bounds.size.width,
                                           height: bounds.size.height))
    }
}
