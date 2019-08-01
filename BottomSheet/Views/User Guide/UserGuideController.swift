//
//  UserGuideController.swift
//  BottomSheet
//
//  Created by Amia Macone on 31/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import ScrollingStackContainer
import UIKit


extension UserGuideController: StackContainable {
    func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
        return ScrollingStackController.ItemAppearance.view(height: 140)
    }
}

final class UserGuideController: UIViewController {
    
    // MARK: - Properties
    
    private var userGuideCard: UserGuideCard?
    private var shadow = ShadowView(opacity: 0.125)
    
    // MARK: - Initializers
    
    init(model: UserGuideModel) {
        super.init(nibName: nil, bundle: nil)
        
        addUserGuide()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func addUserGuide() {
        let model = UserGuideModel(badgeValue: 19)
        userGuideCard = UserGuideCard(userGuideModel: model)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(shakeUserGuide))
        userGuideCard?.addGestureRecognizer(tapRecognizer)
        
        if let card = userGuideCard {
            [shadow, card].forEach({ view.addSubview($0) })
            
            let horizontalInsets: CGFloat = 32
            card.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(horizontalInsets).priority(750)
                make.right.equalToSuperview().offset(-horizontalInsets).priority(750)
                make.bottom.equalToSuperview().offset(-40)
            }
            
            shadow.snp.makeConstraints { (make) in
                make.top.equalTo(card)
                make.left.equalTo(card).offset(50)
                make.right.equalTo(card).offset(-50)
                make.bottom.equalTo(card).offset(20)
            }
        }
    }
    
    @objc private func shakeUserGuide() {
        userGuideCard?.shakeByX()
    }
}
