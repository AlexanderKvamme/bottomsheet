//
//  SettingsCellView.swift
//  BottomSheet
//
//  Created by Amia Macone on 23/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//


import Foundation
import UIKit


final class SettingsCellView: UIView {
    
    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let bodyLabel = UILabel()
    
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
        headerLabel.text = "Header label"
        headerLabel.textColor = UIColor.solarstein.sapphire
        headerLabel.font = UIFont.kolibrix.bold
        
        bodyLabel.text = "Bodyblow"
        bodyLabel.textColor = UIColor.solarstein.sapphire
        bodyLabel.font = UIFont.kolibrix.body
        bodyLabel.alpha = 0.3
    }
    
    private func addSubviewsAndConstraints() {
        [headerLabel, bodyLabel].forEach({ addSubview($0) })
        
        headerLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(32)
            make.top.equalToSuperview().offset(16)
        }
        
        bodyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerLabel)
            make.top.equalTo(headerLabel.snp.bottom)
        }
        
        snp.makeConstraints { (make) in
            make.bottom.equalTo(bodyLabel.snp.bottom).offset(16)
        }
    }
}

