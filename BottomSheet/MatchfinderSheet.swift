//
//  TestViewController.swift
//  BottomSheet
//
//  Created by Amia Macone on 11/06/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


protocol SheetPageController: class {
    func didTapNext()
    func didTapBack()
    func push(_ sheet: UIViewController)
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
final class MatchfinderRootSheet: UIPageViewController, SheetPageController, isSelfSizeable, hasRoundedTopCorners {
    
    // MARK: - Properties
    
    private var currentNumber = 0
    private var navigationStack = [UIViewController]()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.solarstein.sapphire
        roundTopCorners()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setInitialSheet()
    }
    
    // MARK: - Methods
    
    private func setInitialSheet() {
        let transactionController = TransactionController(String(currentNumber), delegate: self)
        setViewControllers([transactionController], direction: .forward, animated: false, completion: nil)
        navigationStack = [transactionController]
        setSize(getSize(of: transactionController))
        
        view.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(transactionController.view)
        }
    }
    
    private func getSize(of sheet: UIViewController) -> CGFloat {
        if type(of: sheet) == TransactionMenuSheet.self {
            print("got size TransactionMenuSheet.preferredSize.height")
            return TransactionMenuSheet.preferredSize.height
        } else {
            print("got size 500")
            return 500
        }
    }
    
    func push(_ sheet: UIViewController) {
        navigationStack.append(sheet)
        setViewControllers([sheet], direction: .forward, animated: true, completion: nil)
        updateSize(getSize(of: sheet))
    }
    
    func popSheet() {
        guard navigationStack.count > 1 else {
            return
        }
        
        navigationStack.remove(at: navigationStack.count-1)
        
        guard let topSheet = navigationStack.last else {
            return
        }
        
        setViewControllers([topSheet], direction: .reverse, animated: true, completion: nil)
        updateSize(getSize(of: topSheet))
    }
    
    func didTapNext() {
        print("did tap next")
        currentNumber += 1
        // show a new viewcontroller with a higher numbere label
        let incrementedTransactionSheet = TransactionController(String(currentNumber), delegate: self)
        push(incrementedTransactionSheet)
    }
    
    func didTapBack() {
        print("didTap back in root")
        popSheet()
    }
}
