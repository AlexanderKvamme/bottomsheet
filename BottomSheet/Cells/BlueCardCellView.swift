//
//  CardCell.swift
//  horizontalcards
//
//  Created by Amia Macone on 15/07/2019.
//  Copyright © 2019 Amia Macone. All rights reserved.
//

import Foundation
import UIKit


/// This Transaction card view is used in Card Transactions' detailed view and has a light white border
class BlueCardCellView: UIView {
    
    // MARK: - Properties
    
    static let estimatedItemSize = CGSize(width: UIScreen.main.bounds.width-32*2, height: 160)
    
    private let headerLabel = UILabel()
    private let valueLabel = UILabel()
    private let mvaLabel = UILabel()
    private let accountLabel = UILabel()
    private let dateView = DateView(day: 1, month: .September, style: .light)
    private let statusIndicator = CardStatusIndicator()
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setup()
        addSubviewsAndConstraints()
        style()
    }
    
    init(with model: TransactionCardModel) {
        super.init(frame: .zero)
        
        setup()
        addSubviewsAndConstraints()
        style()
        
        update(with: model)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        headerLabel.text = "Barnehagedørprodusenten AS"
        headerLabel.font = UIFont.kolibrix.bold
        headerLabel.textColor = UIColor.solarstein.seashell
        
        valueLabel.font = UIFont.kolibrix.subheader
        valueLabel.textColor =  UIColor.solarstein.seashell
        valueLabel.text = "399 kr"
        
        mvaLabel.font = UIFont(name: "RobotoMono-Bold", size: 16)
        mvaLabel.textColor = UIColor.solarstein.salmon
        mvaLabel.text = "Legg til MVA"
        
        accountLabel.font = UIFont(name: "RobotoMono-Bold", size: 16)
        accountLabel.textColor = UIColor.solarstein.salmon
        accountLabel.text = "Legg til konto"
        
        backgroundColor = UIColor.solarstein.sapphire
        
        let tapGesture = UITapGestureRecognizer(target: self as UIView, action: #selector(shakeByX))
        addGestureRecognizer(tapGesture)
    }
    
    private func addSubviewsAndConstraints() {
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
        }
        
        addSubview(mvaLabel)
        mvaLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom).offset(17)
            make.left.equalToSuperview().offset(16)
        }
        
        addSubview(accountLabel)
        accountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(mvaLabel.snp.bottom)
            make.left.equalToSuperview().offset(16)
        }
        
        addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(accountLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
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
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(8)
            make.width.equalTo(36)
        }
    }
    
    private func style() {
        let clr = UIColor.hex("FFFCF9").withAlphaComponent(0.03)
        layer.borderColor = clr.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 20
    }
    
    func addShadow() {
        let size = BlueCardCellView.estimatedItemSize
        frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let contactRect = CGRect(x: 0, y: 24, width: frame.width, height: frame.height)
        layer.shadowPath = UIBezierPath(rect: contactRect).cgPath
        layer.shadowRadius = 30
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
    }
    
    func update(with model: TransactionCardModel) {
        headerLabel.text = model.title
        valueLabel.text = model.value
        mvaLabel.text = model.tax
        accountLabel.text = model.account
    }
}

