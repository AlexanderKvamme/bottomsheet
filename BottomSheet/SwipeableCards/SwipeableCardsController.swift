//
//  CardController.swift
//  horizontalcards
//
//  Created by Amia Macone on 14/06/2019.
//  Copyright © 2019 Amia Macone. All rights reserved.
//

import Foundation
import UIKit
import CHIPageControl
import ScrollingStackContainer

fileprivate let verticalSpaceForPageControl: CGFloat = 30
fileprivate let additionalBottomSpacingBeforeSectionBelow: CGFloat = 40

extension SwipeableCardsController: StackContainable {
    func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
        return ScrollingStackController.ItemAppearance.view(height: SwipeableCardCell.estimatedItemSize.height + verticalSpaceForPageControl + additionalBottomSpacingBeforeSectionBelow)
    }
}


final class SwipeableCardsController: UIViewController {
    
    // MARK: - Properties
    
    static var horizontalInsets: CGFloat = 32
    static var horizontalInterItemSpacing: CGFloat = 16

    lazy private var data = makeDummyData()
    private var collectionView: UICollectionView!
    private let layout = UICollectionViewFlowLayout()
    private let pageControl = CHIPageControlAleppo(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
    private var currentCardIndex = 0
    private var shadow = ShadowView(opacity: 0.15)
    private var bottomSpaceView = UIView()
    
    // MARK: - Initializers
    
    init() {
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = SwipeableCardCell.estimatedItemSize
        layout.minimumLineSpacing = SwipeableCardsController.horizontalInterItemSpacing
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        collectionView.register(SwipeableCardCell.self, forCellWithReuseIdentifier: SwipeableCardCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.decelerationRate = .fast
        collectionView.contentInset = UIEdgeInsets(top: 0, left: SwipeableCardsController.horizontalInsets, bottom: 0, right: SwipeableCardsController.horizontalInsets)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delaysContentTouches = false
        collectionView.contentInsetAdjustmentBehavior = .scrollableAxes
        
        pageControl.numberOfPages = 4
        pageControl.radius = 4
        pageControl.tintColor = UIColor.solarstein.mariner
        pageControl.currentPageTintColor = UIColor.solarstein.sapphire
        pageControl.padding = 6
    }
    
    private func addSubviewsAndConstraints() {
        [shadow, collectionView, bottomSpaceView, pageControl].forEach{( view.addSubview($0) )}
        
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(verticalSpaceForPageControl/3)
            make.left.right.equalToSuperview()
            make.height.equalTo(verticalSpaceForPageControl/3)
            make.bottom.equalToSuperview().offset(-verticalSpaceForPageControl/3-additionalBottomSpacingBeforeSectionBelow)
        }
        
        shadow.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(collectionView)
            make.bottom.equalTo(collectionView).offset(-70)
        }
    }
}

extension SwipeableCardsController: UIScrollViewDelegate {
    
    // used to avoid choppy animation when weakly swiping a new card and finger is released with acceleration
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let newCardIndex = (scrollView.contentOffset.x / SwipeableCardCell.estimatedItemSize.width).rounded()
        let newCellIndex = IndexPath(item: Int(newCardIndex), section: 0)
        let accumulatedInterItemSpacing = CGFloat(newCellIndex.row) * SwipeableCardsController.horizontalInterItemSpacing
        let accumulatedCardSize = CGFloat(newCellIndex.row)*SwipeableCardCell.estimatedItemSize.width
        let targetXPoint = -32 + accumulatedCardSize + accumulatedInterItemSpacing
        scrollView.setContentOffset(CGPoint(x: targetXPoint, y: 0), animated: true)
    }
}

extension SwipeableCardsController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return SwipeableCardCell.estimatedItemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.contentInset.right = CGFloat(data.count-1) * 8
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwipeableCardCell.identifier, for: indexPath) as! SwipeableCardCell
        cell.update(with: data[indexPath.row])
        cell.alpha = 0.5
        
        if indexPath.row == 0 {
            cell.setFaded(false)
        }
    
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pointee = targetContentOffset.pointee
        let cardSize = SwipeableCardCell.estimatedItemSize
        let newCardIndex = (pointee.x / cardSize.width).rounded()
        let newPageIndex = getPageNumber(for: Int(newCardIndex), currentCardNumber: currentCardIndex)
        
        var oldCellIndex: IndexPath!
        var newCellIndex: IndexPath!
        
        if abs(newCardIndex - CGFloat(currentCardIndex)) < 2 {
            oldCellIndex = IndexPath(item: Int(currentCardIndex), section: 0)
            newCellIndex = IndexPath(item: Int(newCardIndex), section: 0)
        } else {
            oldCellIndex = IndexPath(item: Int(currentCardIndex), section: 0)
            newCellIndex = IndexPath(item: Int(newCardIndex), section: 0)
        }
        
        let accumulatedSpacing = (newCardIndex-1)*SwipeableCardsController.horizontalInterItemSpacing - SwipeableCardsController.horizontalInsets/2
        let endPosition = newCardIndex*cardSize.width + accumulatedSpacing
        let veloIsZero = velocity.x == 0
        
        if newCellIndex == oldCellIndex && !veloIsZero {
            return
        }
        
        targetContentOffset.pointee.x = endPosition

        // update pageControl
        pageControl.set(progress: newPageIndex, animated: true)
        
        guard newCellIndex != oldCellIndex else { return }
        
        UIView.animate(withDuration: 0.2) {
            if let oldCell = self.collectionView.cellForItem(at: oldCellIndex) as? SwipeableCardCell {
                oldCell.setFaded(true)
            } else {
                print("could not get cellForItem for oldCellIndex: \(oldCellIndex.row)")
            }
            
            // fade in new cell
            if let newCell = self.collectionView.cellForItem(at: newCellIndex) as? SwipeableCardCell {
                newCell.setFaded(false)
            } else {
                print("could not get cellForItem for newCellIndex: \(newCellIndex!.row). Cell is probably out of visible area")
            }
        }

        currentCardIndex = Int(newCardIndex)
    }
    
    // MARK: Helpers
    
    private func makeDummyData() -> [String] {
        return ["Barnehagesstylist Jan Thomas, Parkveien 0", "Barnehagesstylist Jan Thomas, Parkveien 1", "Barnehagesstylist Jan Thomas, Parkveien 2", "card 3", "card 4", "card 5", "card 6", "card 7", "card 8", "card 9"]
    }
    
    func getPageNumber(for newCardNumberIndex: Int, currentCardNumber: Int) -> Int {
        let swipingForward = newCardNumberIndex > currentCardIndex
        let swipingBackward = newCardNumberIndex < currentCardNumber
        
        if swipingForward {
            let targetIndexIsLast = newCardNumberIndex == data.count - 1
            
            if targetIndexIsLast {
                return pageControl.numberOfPages-1
            } else {
                return min(pageControl.currentPage+1, 2)
            }
        } else if swipingBackward {
            let targetIndexIsFirst = newCardNumberIndex == 0
            
            if targetIndexIsFirst {
                return 0
            } else {
                let oneIndexBack = min(newCardNumberIndex, pageControl.currentPage-1)
                return min(newCardNumberIndex, max(oneIndexBack, 1))
            }
        } else {
            return pageControl.currentPage
        }
    }
}

