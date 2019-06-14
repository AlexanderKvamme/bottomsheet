//
//  PickerCell.swift
//  BottomSheet
//
//  Created by Amia Macone on 14/06/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class PickerCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "Picker cell to repreesnt a choice"
    
    let label = UILabel()
    
    // MARK: - Initializers
    
    init() {
        super.init(style: .default, reuseIdentifier: PickerCell.identifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        label.text = "test"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.sizeToFit()
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(100)
            make.top.right.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func update(with data: String) {
        label.text = data
    }
}
