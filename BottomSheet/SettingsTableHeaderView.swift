//
//  SettingsTableHeaderView.swift
//  BottomSheet
//
//  Created by Amia Macone on 23/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class SettingsTableHeaderView: UIView {
    
    // MARK: - Properties
    
    private var iconView = UIImageView()
    private var titleLabel = UILabel()
    
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
        iconView.image = UIImage(named: "x-icon")
        
        titleLabel.font = UIFont.kolibrix.subheader
        titleLabel.textColor = UIColor.solarstein.sapphire
    }
    
    private func addSubviewsAndConstraints() {
        [iconView, titleLabel].forEach{( addSubview($0) )}
        
        iconView.snp.makeConstraints { (make) in
            make.height.width.equalTo(24)
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(32)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(8)
        }
    }
    
    func setTitle(_ value: String) {
        titleLabel.text = value
    }
}


