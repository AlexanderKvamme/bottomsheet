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
    
    private var maxVisibleContentHeight: CGFloat = UIScreen.main.bounds.height - 200 // FIXME: clean up. Spacing fra toppen
    
    var bottomSheetDelegate: BottomSheetDelegate?
    private var scrollView = UIScrollView()
    private var testViewController = TestViewController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentInset.top = maxVisibleContentHeight
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = true
        scrollView.decelerationRate = .fast
        scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // add a viewController
        addChild(testViewController)

        scrollView.addSubview(testViewController.view)
        testViewController.view.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
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
        
        // Make sure the content is always at least as high as the table view, to prevent the sheet getting stuck half-way.
        if scrollView.contentSize.height < scrollView.bounds.height {
            scrollView.contentSize.height = scrollView.bounds.height
        }
        
        scrollView.contentSize = testViewController.view.frame.size
    }
    
    // MARK: ScrollViewDelegate methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        bottomSheetDelegate?.bottomSheet(self, didScrollTo: scrollView.contentOffset)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let targetOffset = targetContentOffset.pointee.y
        let pulledUpOffset: CGFloat = -200
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
