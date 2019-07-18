//
//  ContactShadowView.swift
//  BottomSheet
//
//  Created by Amia Macone on 18/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class ContactShadowView: UIView {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func addShadow(ofSize size: CGSize) {
        frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        let contactRect = CGRect(x: 50, y: 0, width: frame.width-50, height: frame.height)
        layer.shadowPath = UIBezierPath(rect: contactRect).cgPath
        layer.shadowRadius = 30
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowColor = UIColor.solarstein.sapphire.cgColor
        layer.shadowColor = UIColor.green.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOpacity = 0.5
    }
}
