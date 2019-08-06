//
//  hasRoundedTopCorners.swift
//  BottomSheet
//
//  Created by Amia Macone on 06/08/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit

protocol hasRoundedTopCorners {
    func roundTopCorners()
}

extension hasRoundedTopCorners where Self: UIViewController {
    func roundTopCorners() {
        view.roundCorners(corners: [.topLeft, .topRight])
    }
}
