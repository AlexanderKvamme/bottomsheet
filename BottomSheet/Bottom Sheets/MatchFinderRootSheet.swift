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
    
    var router: Router { get }
    
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
    let router: Router
    
    // MARK: - Initializers
    
    init(router: Router) {
        self.router = router
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.solarstein.sapphire
        roundTopCorners()
        setInitialSheet()
    }
    
    // MARK: - Methods
    
    private func setInitialSheet() {
        let sheet = DetailedTransactionSheet(delegate: self)
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

        // TODO: clean up
        addSheetLayout(sheet)
        scrollableSheet!.scrollToBottom()
        
        router.popModule()
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
        let choices = ["Its like", "this", "and a", "that", "and a dis and a", "its like this", "and like this", "and like", "THAT", "What it to", "Mic check", "One, two"]
        let pickerSheet = PickerSheet("Pick something", choices: choices, delegate: self)
        push(pickerSheet)
    }
    
    func pop() {
        popSheet()
    }
}
