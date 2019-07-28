//
//  ModuleCellView.swift
//  BottomSheet
//
//  Created by Amia Macone on 22/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class ModuleCellView: UIView {
    
    // MARK: - Properties
    
    private let iconView = UIImageView()
    private let headerLabel = UILabel()
    private let bodyTextView = UITextView()
    
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
        headerLabel.font = UIFont.kolibrix.bold
        headerLabel.textColor = UIColor.solarstein.sapphire
        bodyTextView.font = UIFont.kolibrix.body
        bodyTextView.isUserInteractionEnabled = false
        bodyTextView.textColor = .black
        bodyTextView.alpha = 0.3
    }
    
    private func addSubviewsAndConstraints() {
        [iconView, headerLabel, bodyTextView].forEach({ addSubview($0) })
        
        iconView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(60)
            make.width.height.equalTo(20)
        }
        
        headerLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(16)
            make.top.equalTo(iconView).offset(-6)
            make.right.equalToSuperview()
        }
        
        bodyTextView.snp.makeConstraints { (make) in
            make.left.equalTo(headerLabel).offset(-4)
            make.right.equalToSuperview().offset(-60)
            make.top.equalTo(headerLabel.snp.bottom)
            make.height.equalTo(54)
        }
        
        snp.makeConstraints { (make) in
            make.bottom.equalTo(bodyTextView.snp.bottom).offset(16)
            make.width.greaterThanOrEqualTo(350)
        }
    }
    
    // MARK: - Internal methods
    
    func update(withModel model: ModuleModel) {
        iconView.image = model.icon
        headerLabel.text = model.headerText.uppercased()
        bodyTextView.text = model.bodyText
    }
}

