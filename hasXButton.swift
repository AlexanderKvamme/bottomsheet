//
//  hasXButton.swift
//  BottomSheet
//
//  Created by Amia Macone on 26/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import UIKit


protocol hasXButton: class {
    var xButton: SShadowButton { get set }
}

extension hasXButton where Self: UIViewController {
    
    func makeXButton() -> SShadowButton {
        let xButton = SShadowButton()
        xButton.setImage(UIImage(named: "x-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        xButton.tintColor = .white
        return xButton
    }
    
    func applyXButtonConstraints() {
        view.addSubview(xButton)
        xButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.leftMargin).offset(32+Device.additionalInsetsIfNotched)
            make.height.width.equalTo(48)
        }
    }
}

