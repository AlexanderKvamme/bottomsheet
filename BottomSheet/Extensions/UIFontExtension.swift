//
//  UIFontExtension.swift
//  horizontalcards
//
//  Created by Amia Macone on 15/07/2019.
//  Copyright © 2019 Amia Macone. All rights reserved.
//

import Foundation
import UIKit

// MARK: Interface/API to be used in app

extension UIFont {
    
    // MARK: - Enums
    
    enum kolibrix {
        static let header =     sofia(style: .bold, ofSize: 40)
        static let subheader =  sofia(style: .bold, ofSize: 24)
        static let navigation = sofia(style: .semibold, ofSize: 24)
        static let bold =       sofia(style: .bold, ofSize: 16)
        static let body =       sofia(style: .regular, ofSize: 16)
        static let small =       sofia(style: .regular, ofSize: 12)
    }
    
    enum FontWeight: String {
        case regular = "SofiaPro-Regular"
        case semibold = "SofiaPro-Semibold"
        case bold = "SofiaPro-Bold"
    }
    
    // MARK: Fileprivate helper methods
    
    fileprivate static func sofia(style: FontWeight, ofSize: CGFloat) -> UIFont {
        UIFont.familyNames.forEach({ familyName in
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            print(familyName, fontNames)
        })
        
        return UIFont(name: style.rawValue, size: ofSize)!
    }
}
