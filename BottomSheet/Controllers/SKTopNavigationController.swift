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


extension SKTopNavigationController: StackContainable { }

final class SKTopNavigationController: UIViewController, hasTopLeftNavigationButton, hasNavigationHeader {
    
    // MARK: - Properties
    
    lazy var topLeftNavigationButton = makeBackButton()
    lazy var navigationHeaderLabel = makeNavigationHeaderLabel()
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupNavigationBar()
        
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
    
    private func setupNavigationBar() {
        topLeftNavigationButton.setImage(UIImage(named: "left-bracket")?.withRenderingMode(.alwaysTemplate), for: .normal)
        topLeftNavigationButton.tintColor = UIColor.solarstein.sapphire
        //        topLeftNavigationButton.addTarget(self, action: #selector(finish), for: .touchUpInside)
        
        navigationHeaderLabel.text = "Juli"
    }
}
