//
//  SKTopNavigationController.swift
//  BottomSheet
//
//  Created by Amia Macone on 31/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit
import ScrollingStackContainer


enum BackButtonStyle {
    case bracket
    case cross
}

extension SKTopNavigationController: StackContainable { }

final class SKTopNavigationController: UIViewController, hasTopLeftNavigationButton, hasNavigationHeader {
    
    // MARK: - Properties
    
    lazy var topLeftNavigationButton = makeBackButton()
    lazy var navigationHeaderLabel = makeNavigationHeaderLabel()
    
    // MARK: - Initializers
    
    init(backButtonStyle: BackButtonStyle, faded: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        
        setupNavigationBar(style: backButtonStyle, faded: faded)
        
        applyXButtonConstraints()
        applyNavigationHeaderConstraints()
        
        view.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupNavigationBar(style: BackButtonStyle, faded: Bool) {
        if style == .bracket {
            topLeftNavigationButton.setImage(UIImage(named: "left-bracket")?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            topLeftNavigationButton.setImage(UIImage(named: "x-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        
        if faded {
            topLeftNavigationButton.alpha = 0.1
        }
        
        topLeftNavigationButton.tintColor = UIColor.solarstein.sapphire
        navigationHeaderLabel.text = ""
    }
}
