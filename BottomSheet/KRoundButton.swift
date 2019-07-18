//
//  KRoundButton.swift
//  BottomSheet
//
//  Created by Amia Macone on 12/06/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class KRoundButton: UIButton {
    
    // MARK: - Properties
    
    static var size = CGSize(width: 200, height: 48)
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setup(with color: UIColor) {
        backgroundColor = color
        layer.cornerRadius = 20
        titleLabel?.font = UIFont.kolibrix.bold
        titleLabel?.alpha = 0.2
    }
}
