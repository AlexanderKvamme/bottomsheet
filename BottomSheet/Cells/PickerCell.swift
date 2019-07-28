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
    let checkbox = Checkbox(frame: .zero)
    
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
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(label)
        contentView.addSubview(checkbox)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(checkbox.snp.right).offset(16)
            make.top.right.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        
        checkbox.snp.makeConstraints { (make) in
            make.size.equalTo(20)
            make.left.equalToSuperview().offset(80)
            make.centerY.equalToSuperview()
        }
    }
    
    func update(with data: String) {
        label.text = data
    }
}


final class Checkbox: UIView {

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    
    private func setup() {
        layer.cornerRadius = 4
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        
        alpha = 0.6
    }
}
