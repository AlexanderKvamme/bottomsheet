//
//  CardTransactionsViewController.swift
//  BottomSheet
//
//  Created by Amia Macone on 29/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class CardTransactionsViewController: UIViewController, CardTransactionsView, hasXButton, hasNavigationHeader {

    // MARK: - Properties

    lazy var xButton = makeXButton()
    lazy var navigationHeaderLabel = makeNavigationHeaderLabel()
    private let swipeableCardsController = CardController()
    private var userGuideCard: UserGuideCard?
    private let topSectionDescription: SectionDescriptionView!
    private let bottomSectionDescription :SectionDescriptionView!
    var onFinish: (() -> ())?
    
    // MARK: - Initializers
    
    init() {
        topSectionDescription = SectionDescriptionView(header: "Ventende", description: "Transaksjoner som mangler føring, match mot kvittering eller annet")
        bottomSectionDescription = SectionDescriptionView(header: "Godkjente", description: "Transaksjoner som er kontert, og er ferdig matchet mot en kvittering")
        super.init(nibName: nil, bundle: nil)

        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        view.backgroundColor = .white
        xButton.addTarget(self, action: #selector(finish), for: .touchUpInside)
        
        navigationHeaderLabel.text = "Juli"
        
        addUserGuide()
        addSwipeableCards()
        
        topSectionDescription.setBadgeNumber(9)
    }
    
    private func addUserGuide() {
        let model = UserGuideModel(badgeValue: 19)
        userGuideCard = UserGuideCard(userGuideModel: model)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(shakeUserGuide))
        userGuideCard?.addGestureRecognizer(tapRecognizer)
        
        // FIXME: Find better solution
        
        if let card = userGuideCard {
            view.addSubview(card)
            card.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(120)
                make.left.equalToSuperview().offset(24)
                make.right.equalToSuperview().offset(-24)
                make.height.equalTo(100)
            }
        }
    }
    
    private func addSwipeableCards() {
        let controller = CardController()
        addChild(controller)
    }
    
    private func addSubviewsAndConstraints() {
        applyXButtonConstraints()
        applyNavigationHeaderConstraints()

        view.addSubview(topSectionDescription)
        topSectionDescription.snp.makeConstraints { (make) in
            // align to userGuid of one exists
            if let userGuide = userGuideCard {
                make.top.equalTo(userGuide.snp.bottom).offset(24)
            } else {
                make.top.equalTo(view.snp.top).offset(24)
            }
            
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        view.addSubview(swipeableCardsController.view)
        swipeableCardsController.view.snp.makeConstraints{ make in
            make.height.equalTo(SwipeableCardCell.estimatedItemSize.height)
            make.top.equalTo(topSectionDescription.snp.bottom).offset(24)
            make.left.right.equalToSuperview()
        }
        
        view.addSubview(bottomSectionDescription)
        bottomSectionDescription.snp.makeConstraints { (make) in
            make.top.equalTo(swipeableCardsController.view.snp.bottom).offset(48)
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    @objc private func shakeUserGuide() {
        userGuideCard?.shakeByX()
    }
    
    @objc private func finish() {
        onFinish?()
    }
}
