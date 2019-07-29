//
//  hasXButton.swift
//  BottomSheet
//
//  Created by Amia Macone on 26/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import UIKit


protocol hasTopLeftNavigationButton: class {
    var topLeftNavigationButton: UIButton { get set }
}

extension hasTopLeftNavigationButton where Self: UIViewController {
    
    func makeXButton() -> UIButton {
        let xButton = SShadowButton()
        xButton.setImage(UIImage(named: "x-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        xButton.tintColor = .white
        return xButton
    }
    
    func makeBackButton() -> UIButton {
        let xButton = SShadowButton()
        xButton.setImage(UIImage(named: "left-bracket")?.withRenderingMode(.alwaysTemplate), for: .normal)
        return xButton
    }
    
    func applyXButtonConstraints() {
        view.addSubview(topLeftNavigationButton)
        topLeftNavigationButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.leftMargin).offset(32+Device.additionalInsetsIfNotched)
            make.height.width.equalTo(48)
        }
    }
}

