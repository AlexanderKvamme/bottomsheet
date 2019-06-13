//
//  TestViewController.swift
//  BottomSheet
//
//  Created by Amia Macone on 11/06/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


protocol RootSheet: isSelfSizeable {
    func didTapNext()
    func didTapBack()
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
final class MatchfinderRootSheet: UIPageViewController, RootSheet, isSelfSizeable, hasRoundedTopCorners {
    
    // MARK: - Properties
    
    private var currentNumber = 0
    private var navigationStack = [UIViewController]()
    
    weak var scrollableSheet: ScrollableBottomSheetContainer?
    
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
//        setViewControllers([transactionController], direction: .forward, animated: false, completion: nil)
        navigationStack = [transactionController]
        
        addChild(transactionController)
        view.addSubview(transactionController.view)
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(transactionController.view)
        }

//        present(transactionController, animated: true, completion: nil)
        
        
//        view.snp.makeConstraints { (make) in
//            make.edges.equalTo(transactionController.view)
//        }
        
//        transactionController.view.snp.makeConstraints { (make) in
//            make.top.left.right.bottom.equalTo(view)
//        }
    }
    
    private func getSize(of sheet: UIViewController) -> CGFloat {
        if type(of: sheet) == TransactionMenuSheet.self {
            print("got size TransactionMenuSheet.preferredSize.height")
            return TransactionMenuSheet.preferredSize.height
        } else if type(of: sheet) == PickerSheet.self {
            return PickerSheet.preferredSize.height
        } else {
            print("got size 900")
            return 900
        }
    }
    
    func push(_ sheet: UIViewController) {
//        setViewControllers([sheet], direction: .forward, animated: true, completion: nil)
//        setViewControllers([sheet], direction: .forward, animated: true) { (finished) in
//            print("bam finished")
//            self.navigationStack.append(sheet)
//            sheet.view.snp.makeConstraints { (make) in
//                make.top.left.right.bottom.equalTo(self.view)
//            }
//        }
        
        self.navigationStack.append(sheet)
        
        addChild(sheet)
        view.addSubview(sheet.view)
        
        sheet.view.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(view)
        }
        
        print("updating size after push")
        print("bam test getting height:" , sheet.view.frame.height)
//        updateSize(sheet.view.frame.height)
        
//        view.snp.removeConstraints()
//        view.addSubview(sheet.view)
//        view.snp.makeConstraints { (make) in
//            make.top.left.right.bottom.equalTo(sheet.view)
//            make.height.equalTo(sheet.view)
//        }
        
//        sheet.view.snp.makeConstraints { (make) in
//            make.top.left.right.bottom.equalTo(view)
//        }
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
        
        print("would scroll after pop")
        
        scrollableSheet?.scrollToBottom()
    }
    
    func didTapNext() {
        print("did tap next")
        currentNumber += 1
        // show a new viewcontroller with a higher numbere label
//        let incrementedTransactionSheet = TransactionController(String(currentNumber), delegate: self)
//        push(incrementedTransactionSheet)
        let pickerSheet = PickerSheet("Pick something", delegate: self)
        push(pickerSheet)
    }
    
    func didTapBack() {
        print("didTap back in root")
        popSheet()
    }
}
