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
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    // MARK: - Methods
    
    func setup(with color: UIColor) {
        backgroundColor = color
        layer.cornerRadius = 20
    }
}
