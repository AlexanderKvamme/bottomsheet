//
//  SettingsCell.swift
//  BottomSheet
//
//  Created by Amia Macone on 23/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class SettingsCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SettingsCell"
    
    private let cellView = SettingsCellView()
    
    // MARK: - Initializers
    
    init() {
        super.init(style: .default, reuseIdentifier: SettingsCell.identifier)
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        // Add a sample control
        let uiControl = UISwitch(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        accessoryView = uiControl
        accessoryView?.alpha = 0.5
        selectionStyle = .none
    }
    
    private func addSubviewsAndConstraints() {
        contentView.addSubview(cellView)
        cellView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
        }
    }
}


