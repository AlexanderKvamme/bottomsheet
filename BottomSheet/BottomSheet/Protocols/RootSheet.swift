//
//  RootSheet.swift
//  BottomSheet
//
//  Created by Amia Macone on 06/08/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit

protocol RootSheet {
    func didTapNext()
    func pop()
    func push(_ sheet: UIViewController)
    
    var scrollableSheet: BSScrollableSheetContainer? { get set }
}

/// base functionality for RootSheets to handle pushing and popping
extension RootSheet where Self: BottomSheetViewController {
    
    func didTapNext() {
        print("implement me")
    }
    
    func push(_ sheet: UIViewController) {
        // remove topsheet
        if let topSheet = navigationStack.last {
            removeSheetLayout(topSheet)
        }
        
        // add new sheet
        self.navigationStack.append(sheet)
        addSheetLayout(sheet)
        scrollableSheet!.scrollToBottom()
    }
    
    func popSheet() {
        // add new sheet
        guard let sheet = navigationStack.last else {
            print("no sheet to display after pop")
            return
        }
        
        // remove topsheet
        if let topSheet = navigationStack.last {
            removeSheetLayout(topSheet)
            navigationStack.remove(at: navigationStack.index(of: topSheet)!)
        }
        
        addSheetLayout(sheet)
        scrollableSheet!.scrollToBottom()
    }
    
    func addSheetLayout(_ sheet: UIViewController) {
        addChild(sheet)
        view.addSubview(sheet.view)
        sheet.view.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func removeSheetLayout(_ sheet: UIViewController) {
        sheet.view.removeFromSuperview()
        sheet.removeFromParent()
    }
}
