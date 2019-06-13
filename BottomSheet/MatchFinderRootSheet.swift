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
        let sheet = TransactionController(String(currentNumber), delegate: self)
        navigationStack = [sheet]
        
        addChild(sheet)
        view.addSubview(sheet.view)
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(sheet.view)
        }
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
        print()
        print("pushing \(type(of: sheet))")
        print("pre push: ", navigationStack)
        
        // remove old sheet
        if let topSheet = navigationStack.last {
            print("had something to remove")
            topSheet.view.removeFromSuperview()
            topSheet.removeFromParent()
        } else {
            print("nothing to remove")
        }

        // FIXME: Dette funker første gang. Men etter en push og en pop og så ved et nytt push så funker den ikke lenger
        
        // add new sheet
        self.navigationStack.append(sheet)
        addSheet(sheet)
        sheet.view.backgroundColor = .green
        
        print("bam sheet height: ", sheet.view.frame)
        print("post push: ", navigationStack)
    }
    
    func popSheet() {
        // remove topsheet
        print()
        print("pre pop: ", navigationStack)
        if let topSheet = navigationStack.last {
            print("had something to remove")
            topSheet.view.removeFromSuperview()
            topSheet.removeFromParent()
            navigationStack.remove(at: navigationStack.index(of: topSheet)!)
        } else {
            print("nothing to remove")
        }

        // add new sheet
        guard let sheet = navigationStack.last else {
            return
        }

        // FIXME: Cleanup
        print("bam popping to sheet: ", type(of: sheet))
        addSheet(sheet)
        
        scrollableSheet?.scrollToBottom()
        print("post pop: ", navigationStack)
    }
    
    private func addSheet(_ sheet: UIViewController) {
        addChild(sheet)
        view.addSubview(sheet.view)
        sheet.view.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
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
