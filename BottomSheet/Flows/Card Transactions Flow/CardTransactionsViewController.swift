//
//  CardTransactionsViewController.swift
//  BottomSheet
//
//  Created by Amia Macone on 29/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit
import ScrollingStackContainer


final class CardTransactionsViewController: ScrollingStackController, CardTransactionsView {

    // MARK: - Properties

    private let customNav = SKTopNavigationController(backButtonStyle: .bracket, faded: false)
    private var userGuideController: UserGuideController? = nil
    private let swipeableCardsController = SwipeableCardsController()
    private var topSectionController: SectionDescriptionViewController!
    private var bottomSectionController: SectionDescriptionViewController!
    private let cardsTable = TransactionCardTableView()
    private let cardsTableViewController = CardsTableController()
    
    var onFinish: (() -> ())?
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)

        setup()
        addSubviewsAndConstraints()
        
        viewControllers = [customNav, UserGuideController(model: UserGuideModel(badgeValue: 8)), topSectionController, swipeableCardsController, bottomSectionController, cardsTableViewController] as [StackContainable]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func addSubviewsAndConstraints() {
        guard let scrollView = scrollView else { fatalError() }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        customNav.topLeftNavigationButton.addTarget(self, action: #selector(finish), for: .touchUpInside)
        customNav.navigationHeaderLabel.text = "August"
        
        makeSectionHeaders()
        makeUserGuide()
        setupScrollView()
        addSwipeableCards()
    }
    
    private func makeSectionHeaders() {
        let topSectionView = SectionDescriptionView(header: "Ventende", description: "Transaksjoner som mangler føring, match mot kvittering eller annet")
        topSectionController = SectionDescriptionViewController(descriptionView: topSectionView)
        topSectionView.setBadgeNumber(9)
        let bottomSectionDescription = SectionDescriptionView(header: "Godkjente", description: "Transaksjoner som er kontert, og er ferdig matchet mot en kvittering")
        bottomSectionController = SectionDescriptionViewController(descriptionView: bottomSectionDescription)
    }
    
    private func makeUserGuide() {
        userGuideController = UserGuideController(model: UserGuideModel(badgeValue: 8))
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView(frame: .zero)
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.backgroundColor = .white
    }
    
    private func addSwipeableCards() {
        let controller = SwipeableCardsController()
        addChild(controller)
    }
    
    @objc private func finish() {
        onFinish?()
    }
}

