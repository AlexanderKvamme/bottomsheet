//
//  BSProtocols.swift
//  BottomSheet
//
//  Created by Amia Macone on 06/08/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


protocol BottomSheetDelegate: AnyObject {
    func bottomSheet(_ bottomSheet: hasBottomSheetDelegate, didScrollTo contentOffset: CGPoint)
}


protocol hasBottomSheetDelegate: AnyObject {
    var bottomSheetDelegate: BottomSheetDelegate? { get set }
}


protocol BottomSheetDidScrollResponder: UIViewController {
    func bottomsheetDidScrollTo(_ value: CGPoint)
}
