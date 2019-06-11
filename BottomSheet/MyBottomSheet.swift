//
//  MyBottomSheet.swift
//  BottomSheet
//
//  Created by Amia Macone on 11/06/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class MyBottomSheet: UIViewController, UIScrollViewDelegate, BottomSheet {

    // MARK: - Properties
    
    private let maxVisibleContentHeight: CGFloat = 400
    
    var bottomSheetDelegate: BottomSheetDelegate?
    var scrollView = UIScrollView()
    
    // MARK: - Initializers
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentInset.top = maxVisibleContentHeight
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = true
        scrollView.decelerationRate = .fast
        scrollView.delegate = self
        
        // Add a subview
        let blueView = UIView()
        blueView.backgroundColor = .blue
        blueView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 900)
        blueView.roundCorners(corners: [.topLeft, .topRight], amount: 24)
        scrollView.addSubview(blueView)
        
        // add a viewController
        
        let testViewController = TestViewController()
        addChild(testViewController)
        scrollView.addSubview(testViewController.view)
        
        // layout
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bottomSheetDelegate?.bottomSheet(self, didScrollTo: scrollView.contentOffset)
        
        // Make sure the content is always at least as high as the table view, to prevent the sheet
        // getting stuck half-way.
        if scrollView.contentSize.height < scrollView.bounds.height {
            scrollView.contentSize.height = scrollView.bounds.height
        }
    }
    
    // MARK: ScrollViewDelegate methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        bottomSheetDelegate?.bottomSheet(self, didScrollTo: scrollView.contentOffset)
        
        scrollView.contentSize = scrollView.frame.size
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let targetOffset = targetContentOffset.pointee.y
        let pulledUpOffset: CGFloat = 0
        let pulledDownOffset: CGFloat = -maxVisibleContentHeight
        
        if (pulledDownOffset...pulledUpOffset).contains(targetOffset) {
            if velocity.y < 0 {
                targetContentOffset.pointee.y = pulledDownOffset
            } else {
                targetContentOffset.pointee.y = pulledUpOffset
            }
        }
    }
}

