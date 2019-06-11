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
    
    private let maxVisibleContentHeight: CGFloat = 400
    
    var bottomSheetDelegate: BottomSheetDelegate?
    var scrollView = UIScrollView()
    
    // MARK: - Properties
    
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

        scrollView.addSubview(blueView)
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("vdls: ", scrollView.contentOffset)
        
        bottomSheetDelegate?.bottomSheet(self, didScrollTo: scrollView.contentOffset)
        
        // Make sure the content is always at least as high as the table view, to prevent the sheet
        // getting stuck half-way.
        if scrollView.contentSize.height < scrollView.bounds.height {
            print("if")
            scrollView.contentSize.height = scrollView.bounds.height
//            scrollView.contentSize.height = 300
            print("setting scrollView.contentSize.height to \(scrollView.bounds.height)")
        } else {
            print("else")
        }
    }
    
    // MARK: ScrollViewDelegate methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("cvds inset: ", scrollView.contentInset)
        print("cvds ajdustedinset: ", scrollView.adjustedContentInset)
        print("cvds scrollView.contentOffset: ", scrollView.contentOffset)
//        print("cvds scrollView.contentOffset: ", scrollView.)
        
//        print("cvdc inset: ", scrollView.)
        bottomSheetDelegate?.bottomSheet(self, didScrollTo: scrollView.contentOffset)
        
        scrollView.contentSize = scrollView.frame.size
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        print("did Scroll with targetOffset", targetContentOffset.pointee)
        
        let targetOffset = targetContentOffset.pointee.y
        let pulledUpOffset: CGFloat = 0
        let pulledDownOffset: CGFloat = -maxVisibleContentHeight
        
        print("target range: ", pulledDownOffset...pulledUpOffset)
        if (pulledDownOffset...pulledUpOffset).contains(targetOffset) {
            print("range did contain offset")
            if velocity.y < 0 {
                print("had NEGATIVE speed, so should go down")
                targetContentOffset.pointee.y = pulledDownOffset
            } else {
                print("had positive speed, so should go up")
                targetContentOffset.pointee.y = pulledUpOffset
            }
        } else {
            print("range did NOT contain offset")
        }
        
        // Testprint
        
        print("sheet frame height: ", view.frame.height)
    }
}

