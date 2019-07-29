//
//  hasNavigationHeader.swift
//  BottomSheet
//
//  Created by Amia Macone on 29/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit

protocol hasNavigationHeader: class {
    var navigationHeaderLabel: UILabel { get set }
}

extension hasNavigationHeader where Self: UIViewController{
    func makeNavigationHeaderLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.kolibrix.navigation
        label.alpha = 0.1
        label.text = "Header"
        label.textColor = UIColor.solarstein.sapphire
        label.textAlignment = .center
        return label
    }
    
    func applyNavigationHeaderConstraints() {
        view.addSubview(navigationHeaderLabel)
        navigationHeaderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.leftMargin).offset(32+Device.additionalInsetsIfNotched + 64)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.rightMargin).offset(-32+Device.additionalInsetsIfNotched - 64)
            make.height.equalTo(48)
        }
    }
}
