//
//  Device.swift
//  BottomSheet
//
//  Created by Amia Macone on 19/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class Device {
    static let additionalInsetsIfNotched: CGFloat = Device.hasTopNotch ? 8 : 0
    static var hasTopNotch: Bool {
        if #available(iOS 11.0,  *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        
        return false
    }
}

