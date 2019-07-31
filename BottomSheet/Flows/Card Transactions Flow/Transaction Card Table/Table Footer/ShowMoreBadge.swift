//
//  ShowMoreBadge.swift
//  BottomSheet
//
//  Created by Amia Macone on 31/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class ShowMoreBadge: UIView {
    
    // MARK: - Properties
    
    static let estimatedSize = CGSize(width: 112, height: 24)
    
    private let label = UILabel()
    private let backgroundView = UIView()
    
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
        layer.cornerRadius = ShowMoreBadge.estimatedSize.height/2
        clipsToBounds = true
        
        backgroundView.backgroundColor = UIColor.solarstein.poloBlue
        backgroundView.alpha = 0.1
        
        label.text = "SE ALLE >"
        label.setCharacterSpacing(1)
        label.textColor = UIColor.solarstein.sapphire
        label.font = UIFont.kolibrix.smallBadge
        label.alpha = 0.3
        label.textAlignment = .center
    }
    
    private func addSubviewsAndConstraints() {
        [backgroundView, label].forEach({ addSubview($0) })
        
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

