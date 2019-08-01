//
//  SKScreenHeaderController.swift
//  BottomSheet
//
//  Created by Amia Macone on 01/08/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit
import ScrollingStackContainer


extension SKScreenHeaderController: StackContainable {
    func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
        return ScrollingStackController.ItemAppearance.view(height: 120 )
    }
}

final class SKScreenHeaderController: UIViewController {
    
    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let subheaderLabel = UILabel()
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        headerLabel.text = "Innstillinger"
        headerLabel.textColor = UIColor.solarstein.sapphire
        headerLabel.font = UIFont.kolibrix.header
        
        subheaderLabel.text = "Her kan du justere dine preferanser"
        subheaderLabel.textColor = UIColor.solarstein.sapphire
        subheaderLabel.alpha = 0.3
        subheaderLabel.font = UIFont.kolibrix.body
    }
    
    private func addSubviewsAndConstraints() {
        [headerLabel, subheaderLabel].forEach({ view.addSubview($0) })
        
        headerLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(40).priority(750)
            make.right.equalToSuperview()
        }
        
        subheaderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerLabel)
            make.top.equalTo(headerLabel.snp.bottom)
            make.right.equalToSuperview()
        }
    }
}
