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


/// Needed for tableview to provide its own height automatically
extension TableContainer: StackContainable {
    func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
        return ScrollingStackController.ItemAppearance.scroll(cardsTable, insets: UIEdgeInsets.zero)
    }
}

final class TableContainer: UIViewController {
    
    // MARK: - Properties
    
    private let cardsTable = TransactionCardTableView()
    private let cardsDataSourceAndDelegate = TransactionCardTableDataSourceAndDelegate()
    private let shadow = ShadowView()
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    private func setup() {
        cardsTable.dataSource = cardsDataSourceAndDelegate
        cardsTable.delegate = cardsDataSourceAndDelegate
    }
    
    private func addSubviewsAndConstraints() {
        [shadow, cardsTable].forEach({ view.addSubview($0) })
        
        cardsTable.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(100)
        }
        
        shadow.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-70)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension NavigationController: StackContainable {
    
}


final class NavigationController: UIViewController, hasTopLeftNavigationButton, hasNavigationHeader {
    
    // MARK: - Properties
    
    lazy var topLeftNavigationButton = makeBackButton()
    lazy var navigationHeaderLabel = makeNavigationHeaderLabel()
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupNavigationBar()
        
        applyXButtonConstraints()
        applyNavigationHeaderConstraints()
        
        view.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupNavigationBar() {
        topLeftNavigationButton.setImage(UIImage(named: "left-bracket")?.withRenderingMode(.alwaysTemplate), for: .normal)
        topLeftNavigationButton.tintColor = UIColor.solarstein.sapphire
//        topLeftNavigationButton.addTarget(self, action: #selector(finish), for: .touchUpInside)
        
        navigationHeaderLabel.text = "Juli"
    }
}


extension UserGuideController: StackContainable {
    func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
        return ScrollingStackController.ItemAppearance.view(height: 140)
    }
}

final class UserGuideController: UIViewController {
    
    // MARK: - Properties
    
    private var userGuideCard: UserGuideCard?
    private var shadow = ShadowView(opacity: 0.15)
    
    // MARK: - Initializers
    
    init(model: UserGuideModel) {
        super.init(nibName: nil, bundle: nil)
        
        addUserGuide()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func addUserGuide() {
        let model = UserGuideModel(badgeValue: 19)
        userGuideCard = UserGuideCard(userGuideModel: model)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(shakeUserGuide))
        userGuideCard?.addGestureRecognizer(tapRecognizer)
        
        if let card = userGuideCard {
            [shadow, card].forEach({ view.addSubview($0) })

            card.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(24).priority(750)
                make.right.equalToSuperview().offset(-24).priority(750)
                make.bottom.equalToSuperview().offset(-40)
            }
            
            shadow.snp.makeConstraints { (make) in
                make.top.left.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-70)
            }
        }
    }

    @objc private func shakeUserGuide() {
        userGuideCard?.shakeByX()
    }
}


final class CardTransactionsViewController: ScrollingStackController, CardTransactionsView {

    // MARK: - Properties

    private let customNav = NavigationController()
    private var userGuideController: UserGuideController? = nil
    private let swipeableCardsController = SwipeableCardsController()
    private var topSectionController: SectionDescriptionViewController!
    private var bottomSectionController: SectionDescriptionViewController!
    private let cardsTable = TransactionCardTableView()
    private let cardsTableViewController = TableContainer()
    
    var onFinish: (() -> ())?
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)

        setup()
        
        guard let scrollView = scrollView else { fatalError("fix") }
        
        // Layout
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        viewControllers = [customNav, UserGuideController(model: UserGuideModel(badgeValue: 8)), topSectionController, swipeableCardsController, bottomSectionController, cardsTableViewController] as [StackContainable]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func makeSectionHeaders() {
        let topSectionView = SectionDescriptionView(header: "Ventende", description: "Transaksjoner som mangler føring, match mot kvittering eller annet")
        topSectionController = SectionDescriptionViewController(descriptionView: topSectionView)
        topSectionView.setBadgeNumber(9)
        let bottomSectionDescription = SectionDescriptionView(header: "Godkjente", description: "Transaksjoner som er kontert, og er ferdig matchet mot en kvittering")
        bottomSectionController = SectionDescriptionViewController(descriptionView: bottomSectionDescription)
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        makeSectionHeaders()
        makeUserGuide()
        setupScrollView()
        addSwipeableCards()
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

