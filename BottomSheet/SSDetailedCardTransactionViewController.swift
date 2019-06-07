//
//  SSDetailedCardTransactionViewController.swift
//  BottomSheet
//
//  Created by Amia Macone on 07/06/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


private let maxVisibleContentHeight: CGFloat = 600


class SSDetailedCardtransactionViewController: UIViewController, BottomSheet {
    
    var bottomSheetDelegate: BottomSheetDelegate?
    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//          scrollView.contentInset.top = maxVisibleContentHeight
        scrollView.backgroundColor = .green
        scrollView.showsVerticalScrollIndicator = false
        scrollView.decelerationRate = .fast
        scrollView.delegate = self
        
        let tapRec = UITapGestureRecognizer(target: self, action: #selector(didTap))
        scrollView.addGestureRecognizer(tapRec)

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        print("isInteraction", scrollView.isUserInteractionEnabled)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bottomSheetDelegate?.bottomSheet(self, didScrollTo: scrollView.contentOffset)
        
        // Make sure the content is always at least as high as the table view, to prevent the sheet
        // getting stuck half-way.
        if scrollView.contentSize.height < scrollView.bounds.height {
            scrollView.contentSize.height = scrollView.bounds.height
        }
    }
    
    // MARK: Methods
    
    @objc func didTap() {
        print("did tap")
    }
}

extension SSDetailedCardtransactionViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("didScroll")
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let targetOffset = targetContentOffset.pointee.y
        let pulledUpOffset: CGFloat = -100
        let pulledDownOffset: CGFloat = -maxVisibleContentHeight
        
        if (pulledDownOffset...pulledUpOffset).contains(targetOffset) {
            if velocity.y < 0 {
                targetContentOffset.pointee.y = pulledDownOffset
            } else {
                targetContentOffset.pointee.y = pulledUpOffset
            }
        } else {
            print("else")
        }
    }
}
