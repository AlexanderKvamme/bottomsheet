//
//  MyBottomSheet.swift
//  BottomSheet
//
//  Created by Amia Macone on 11/06/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


enum SheetTopVisibility: CGFloat {
    case minimum = 120
    case visibleHeader = 200
}

/// This class controls anything related to the scrolling of a bottomsheet
final class ScrollableBottomSheetContainer: UIViewController, UIScrollViewDelegate, BottomSheet {

    // MARK: - Properties
    
    var sheetTopVisibility = SheetTopVisibility.minimum
    var bottomSheetDelegate: BottomSheetDelegate?
    private var scrollView = UIScrollView()
    private var mainSheet: UIPageViewController & RootSheet
    
    // MARK: - Initializers
    
    init(_ mainSheet: UIPageViewController & RootSheet) {
        self.mainSheet = mainSheet
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviewsAndConstraints()
    }
    
    // MARK: - private Methods
    
    private func setup() {
        mainSheet.scrollableSheet = self
        
        scrollView.contentInset.top = getMaxVisibleContentHeight()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = true
        scrollView.decelerationRate = .fast
        scrollView.delegate = self
    }
    
    private func addSubviewsAndConstraints() {
        addChild(mainSheet)
        
        scrollView.addSubview(mainSheet.view)
        view.addSubview(scrollView)
        
        mainSheet.view.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func getMaxVisibleContentHeight() -> CGFloat {
        return UIScreen.main.bounds.height - sheetTopVisibility.rawValue
    }
        
    // MARK: overridden methods
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bottomSheetDelegate?.bottomSheet(self, didScrollTo: scrollView.contentOffset)
        
        // Make sure the content is always at least as high as the content, to prevent the sheet getting stuck half-way.
        if self.scrollView.contentSize.height < self.scrollView.bounds.height {
            self.scrollView.contentSize.height = self.scrollView.bounds.height
        }
        
        self.scrollView.contentSize = self.mainSheet.view.frame.size
    }
    
    // MARK: internal methods
    
    func scrollToBottom() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.scrollView.layoutSubviews()
            let targetOffsetToBottom = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.height)
            self.scrollView.setContentOffset(targetOffsetToBottom, animated: true)
        })
    }
    
    // MARK: - ScrollViewDelegate methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        bottomSheetDelegate?.bottomSheet(self, didScrollTo: scrollView.contentOffset)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let targetOffset = targetContentOffset.pointee.y
        let pulledUpOffset: CGFloat = -200
        let pulledDownOffset: CGFloat = -getMaxVisibleContentHeight()
        
        if (pulledDownOffset...pulledUpOffset).contains(targetOffset) {
            if velocity.y < 0 {
                targetContentOffset.pointee.y = pulledDownOffset
            } else {
                targetContentOffset.pointee.y = pulledUpOffset
            }
        }
    }
    
}

