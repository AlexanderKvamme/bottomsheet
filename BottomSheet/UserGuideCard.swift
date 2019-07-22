//
//  UserGuideCard.swift
//  
//
//  Created by Amia Macone on 22/07/2019.
//

import Foundation
import UIKit


struct UserGuideModel {
    var badgeValue: Int
}

final class UserGuideCard: UIView {

    // MARK: - Properties
    
    private var model: UserGuideModel
    private let valueLabel = UILabel()
    private let headerLabel = UILabel()
    private let subheaderLabel = UILabel()
    private let iconRightArrow = UIImageView()
    
    // MARK: - Initializers
    
    init(userGuideModel: UserGuideModel) {
        self.model = userGuideModel
        
        super.init(frame: .zero)
        
        backgroundColor = UIColor.solarstein.sapphire
        layer.cornerRadius = 20
        clipsToBounds = true
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        valueLabel.text = "\(model.badgeValue)"
        valueLabel.font = UIFont.kolibrix.header
        valueLabel.textColor = UIColor.solarstein.salmon
        
        headerLabel.text = "Du har 6 ting å se over"
        headerLabel.font = UIFont.kolibrix.bold
        headerLabel.textColor = .white
        sizeToFit()
        
        subheaderLabel.text = "Trykk for å komme i gang"
        subheaderLabel.font = UIFont.kolibrix.body
        subheaderLabel.textColor = .white
        
        iconRightArrow.image = UIImage(named: "right-bracket")?.withRenderingMode(.alwaysOriginal)
    }
    
    private func addSubviewsAndConstraints() {
        [valueLabel, headerLabel, subheaderLabel, iconRightArrow].forEach({ addSubview($0) })
        
        valueLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(32)
            make.width.equalTo(30)
        }
        
        headerLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(snp.centerY).offset(20)
            make.left.equalTo(valueLabel.snp.right).offset(16)
            make.right.equalToSuperview()
            make.bottom.equalTo(snp.centerY)
        }
        
        subheaderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerLabel)
            make.top.equalTo(headerLabel.snp.bottom)
            make.right.equalToSuperview()
        }
        
        iconRightArrow.snp.makeConstraints { (make) in
            let bracketScale = 2
            make.right.equalToSuperview().offset(-32)
            make.centerY.equalToSuperview()
            make.height.equalTo(14*bracketScale)
            make.width.equalTo(8*bracketScale)
        }
    }
}

