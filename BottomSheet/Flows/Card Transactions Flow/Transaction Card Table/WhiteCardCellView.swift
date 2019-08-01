//
//  CardTransactionCellView.swift
//  BottomSheet
//
//  Created by Amia Macone on 29/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit

/// White version of the cards. Used to represent cards with no unfinished tasks
final class WhiteCardCellView: UIView {
    
    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let valueLabel = UILabel()
    private let mvaLabel = UILabel()
    private let accountLabel = UILabel()
    private let dateView = DateView(day: 1, month: .September, style: .dark)
    private let statusIndicator = CardStatusIndicator()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        
        statusIndicator.setStatus(.green)
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 20
        
        let alpha: CGFloat = 0.3
        
        headerLabel.text = "Støvleprodusenten AS, Euforiesgate 19"
        headerLabel.font = UIFont.kolibrix.bold
        headerLabel.textColor = UIColor.solarstein.sapphire
        headerLabel.alpha = 0.4
        
        valueLabel.font = UIFont(name: "RobotoMono-Bold", size: 16)
        valueLabel.textColor =  UIColor.solarstein.sapphire
        valueLabel.text = "399 kr"
        accountLabel.setCharacterSpacing(1.33)
        valueLabel.alpha = alpha
        
        mvaLabel.font = UIFont(name: "RobotoMono-Bold", size: 12)
        mvaLabel.textColor = UIColor.solarstein.sapphire
        mvaLabel.text = "Inngående mva ingen sats".uppercased()
        mvaLabel.setCharacterSpacing(1)
        mvaLabel.alpha = alpha
        
        accountLabel.font = UIFont(name: "RobotoMono-Bold", size: 12)
        accountLabel.textColor = UIColor.solarstein.sapphire
        accountLabel.text = "3251 - IK - Husholdning".uppercased()
        accountLabel.setCharacterSpacing(1)
        accountLabel.alpha = alpha
    }
    
    private func addSubviewsAndConstraints() {
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().priority(750)
        }
        
        addSubview(mvaLabel)
        mvaLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom).offset(17)
            make.left.equalTo(headerLabel)
        }
        
        addSubview(accountLabel)
        accountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(mvaLabel.snp.bottom).offset(4)
            make.left.equalTo(headerLabel)
        }
        
        addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(accountLabel.snp.bottom).offset(16)
            make.left.equalTo(headerLabel)
        }
        
        addSubview(dateView)
        dateView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(mvaLabel.snp.top)
            make.height.width.equalTo(50)
        }
        
        addSubview(statusIndicator)
        statusIndicator.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalTo(valueLabel).offset(-3)
            make.height.equalTo(8)
            make.width.equalTo(36)
        }
    }
}
