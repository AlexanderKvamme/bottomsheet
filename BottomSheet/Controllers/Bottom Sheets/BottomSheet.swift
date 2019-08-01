//
//  BottomSheet.swift
//  BottomSheet
//
//  Created by Amia Macone on 18/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


protocol BottomSheet: UIViewController {
    var bottomSheetDelegate: BottomSheetDelegate? { get set }
}

