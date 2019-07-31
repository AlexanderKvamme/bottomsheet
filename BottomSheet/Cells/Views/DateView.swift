//
//  DateLabel.swift
//  horizontalcards
//
//  Created by Amia Macone on 15/07/2019.
//  Copyright © 2019 Amia Macone. All rights reserved.
//

import Foundation
import UIKit

// Enums

enum DateViewStyle {
    case dark
    case light
}

// MARK: - Class

class DateView: UIView {
    
    // MARK: - Properties
    
    private var dayLabel = UILabel()
    private var monthLabel = UILabel()
    private var style: DateViewStyle
    
    // MARK: - Initializers
    
    init(day: Int, month: Month, style: DateViewStyle) {
        self.style = style
        super.init(frame: CGRect.zero)
       
        monthLabel.text = month.rawValue.uppercased()
        
        addSubviewsAndConstraints()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        dayLabel.text = "29"
        
        dayLabel.font = UIFont.kolibrix.header
        dayLabel.adjustsFontSizeToFitWidth = true
        dayLabel.textAlignment = .center
        dayLabel.alpha = 0.3
        
        monthLabel.alpha = 0.3
        monthLabel.font = UIFont.kolibrix.bold
        monthLabel.textAlignment = .center
        monthLabel.adjustsFontSizeToFitWidth = true
        
        adjustVisuals(for: style)
    }
    
    private func addSubviewsAndConstraints() {
        addSubview(monthLabel)
        addSubview(dayLabel)
        
        dayLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(monthLabel.snp.top)
        }
        
        monthLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func adjustVisuals(for style: DateViewStyle) {
        switch style {
        case .dark:
            dayLabel.textColor = UIColor.solarstein.sapphire
            monthLabel.textColor = UIColor.solarstein.sapphire
        case .light:
            dayLabel.textColor = .white
            monthLabel.textColor = .white
        }
    }
}

enum Month: String {
    case January = "Jan"
    case September = "Sept"
}