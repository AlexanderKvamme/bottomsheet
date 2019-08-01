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
        super.init(frame: .zero)
        
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
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-1)
        }
    }
    
    func setBadge(number: Int) {
        numberLabel.text = "\(number)"
    }
    
    // MARK: Overridden methods

    // update round corners whenever autolayout is used to set badge size
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.size.height/2
    }
}
