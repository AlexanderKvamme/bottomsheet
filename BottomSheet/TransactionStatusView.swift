//
//  TransactionStatusView.swift
//  BottomSheet
//
//  Created by Amia Macone on 18/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class TransactionStatusView: UIView {

    // MARK: - Properties
    
    static let estimatedItemSize = CGSize(width: UIScreen.main.bounds.width-32*2, height: 100)
    
    private let headerLabel = UILabel()
    private let subheaderLabel = UILabel()
    private let statusIcon = UIImageView()
    private let rightIcon = UIImageView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setup()
        addSubviewsAndConstraints()
        style()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        statusIcon.image = UIImage(named: "x-icon")?.withRenderingMode(.alwaysOriginal)
        rightIcon.image = UIImage(named: "bracket")?.withRenderingMode(.alwaysTemplate)
        rightIcon.tintColor = .white
        rightIcon.alpha = 0.1
        rightIcon.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        headerLabel.text = "Mangler status"
        headerLabel.font = UIFont.kolibrix.bold
        headerLabel.textColor = UIColor.solarstein.seashell
        
        subheaderLabel.text = "Trykk for å komme i gang"
        subheaderLabel.font = UIFont.kolibrix.body
        subheaderLabel.textColor = UIColor.solarstein.seashell
        
        backgroundColor = UIColor.solarstein.sapphire
    }
    
    private func addSubviewsAndConstraints() {
        addSubview(statusIcon)
        statusIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(32)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(32)
        }
        
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.left.equalTo(statusIcon.snp.right).offset(32)
            make.centerY.equalToSuperview().offset(-11)
            make.right.equalToSuperview()
        }
        
        addSubview(subheaderLabel)
        subheaderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerLabel)
            make.centerY.equalToSuperview().offset(11)
            make.right.equalToSuperview()
        }
        
        addSubview(rightIcon)
        rightIcon.snp.makeConstraints { (make) in
            let multiplier: CGFloat = 2
            make.right.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview()
            make.height.equalTo(14*multiplier)
            make.width.equalTo(8*multiplier)
        }
    }
    
    private func style() {
        // add border
        let clr = UIColor.hex("FFFCF9").withAlphaComponent(0.03)
        layer.borderColor = clr.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 20
    }
    
    func addShadow() {
        let size = TransactionStatusView.estimatedItemSize
        frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let contactRect = CGRect(x: 0, y: 24, width: frame.width, height: frame.height)
        layer.shadowPath = UIBezierPath(rect: contactRect).cgPath
        layer.shadowRadius = 30
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
    }
}

