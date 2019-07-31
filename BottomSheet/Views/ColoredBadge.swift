//
//  ColoredBadge.swift
//  BottomSheet
//
//  Created by Amia Macone on 29/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class ColoredBadge: UIView {
    
    // MARK: - Properties
    
    private var numberLabel = UILabel()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .init(x: 0, y: 0, width: 80, height: 40))
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        backgroundColor = UIColor.solarstein.warningColor
        layer.cornerRadius = 10
        numberLabel.font = UIFont.kolibrix.badge
        numberLabel.textColor = .white
    }
    
    private func addSubviewsAndConstraints() {
        addSubview(numberLabel)
        numberLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    func setBadge(number: Int) {
        numberLabel.text = "\(number)"
    }
}