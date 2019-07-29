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

final class CardController: UIViewController {
    
    // MARK: - Properties
    
    static var horizontalInsets: CGFloat = 32
    static var horizontalInterItemSpacing: CGFloat = 16

    private var data = ["Barnehagesstylist Jan Thomas, Parkveien 0", "Barnehagesstylist Jan Thomas, Parkveien 1", "Barnehagesstylist Jan Thomas, Parkveien 2", "card 3", "card 4", "card 5", "card 6", "card 7", "card 8", "card 9"]
    private var collectionView: UICollectionView!
    private let layout = UICollectionViewFlowLayout()
    private let pageControl = CHIPageControlAleppo(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
    
    private var currentCardIndex = 0
    
    // MARK: - Initializers
    
    init() {
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = SwipeableCardCell.estimatedItemSize
        layout.minimumLineSpacing = CardController.horizontalInterItemSpacing
        
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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: CardController.horizontalInsets, bottom: 0, right: CardController.horizontalInsets)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delaysContentTouches = false
        
        pageControl.numberOfPages = 4
        pageControl.radius = 4
        pageControl.tintColor = UIColor.solarstein.mariner
        pageControl.currentPageTintColor = UIColor.solarstein.sapphire
        pageControl.padding = 6
    }
    
    private func addSubviewsAndConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.right.bottom.equalToSuperview()
        }
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
    }
}

extension CardController: UIScrollViewDelegate {
    
    // used to avoid choppy animation when weakly swiping a new card and finger is released with acceleration
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let newCardIndex = (scrollView.contentOffset.x / SwipeableCardCell.estimatedItemSize.width).rounded()
        let newCellIndex = IndexPath(item: Int(newCardIndex), section: 0)
        let accumulatedInterItemSpacing = CGFloat(newCellIndex.row) * CardController.horizontalInterItemSpacing
        let accumulatedCardSize = CGFloat(newCellIndex.row)*SwipeableCardCell.estimatedItemSize.width
        let targetXPoint = -32 + accumulatedCardSize + accumulatedInterItemSpacing
        scrollView.setContentOffset(CGPoint(x: targetXPoint, y: 0), animated: true)
    }
}

extension CardController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        
        let accumulatedSpacing = (newCardIndex-1)*CardController.horizontalInterItemSpacing - CardController.horizontalInsets/2
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
