//
//  TestViewController.swift
//  BottomSheet
//
//  Created by Amia Macone on 11/06/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


protocol RootSheet {
    func didTapNext()
    func pop()
    func push(_ sheet: UIViewController)
    
    var scrollableSheet: ScrollableBottomSheetContainer? { get set }
}

protocol hasRoundedTopCorners {
    func roundTopCorners()
}

extension hasRoundedTopCorners where Self: UIViewController {
    func roundTopCorners() {
        view.roundCorners(corners: [.topLeft, .topRight])
    }
}

/// This is the sheet main controller. It is a pagecontroller which contains any sheetpages and will be the controller
/// of the the sheetpages. 
final class MatchfinderRootSheet: UIPageViewController, RootSheet, hasRoundedTopCorners {
    
    // MARK: - Properties
    
    private var navigationStack = [UIViewController]()
    
    weak var scrollableSheet: ScrollableBottomSheetContainer?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.solarstein.sapphire
        roundTopCorners()
        setInitialSheet()
    }
    
    // MARK: - Methods
    
    private func setInitialSheet() {
        let sheet = TransactionSheet("initial sheet", delegate: self)
        navigationStack = [sheet]
        addSheetLayout(sheet)
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
        // remove topsheet
        if let topSheet = navigationStack.last {
            removeSheetLayout(topSheet)
            navigationStack.remove(at: navigationStack.index(of: topSheet)!)
        }

        // add new sheet
        guard let sheet = navigationStack.last else {
            assertionFailure("no sheet to display after pop")
            return
        }

        addSheetLayout(sheet)
        scrollableSheet!.scrollToBottom()
    }
    
    private func addSheetLayout(_ sheet: UIViewController) {
        addChild(sheet)
        view.addSubview(sheet.view)
        sheet.view.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    private func removeSheetLayout(_ sheet: UIViewController) {
        sheet.view.removeFromSuperview()
        sheet.removeFromParent()
    }
    
    func didTapNext() {
        let pickerSheet = PickerSheet("Pick something", delegate: self)
        push(pickerSheet)
    }
    
    func pop() {
        popSheet()
    }
}
