//
//  DetailedTransactionSheet.swift
//  BottomSheet
//
//  Created by Amia Macone on 18/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class DetailedTransactionSheet: UIViewController, HasHorizontalSheetIndicator {

    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let firstButton = KRoundButton()
    private let secondButton = KRoundButton()
    private let backButton = KRoundButton()
    private var transactionCardView: TransactionCardView!
    private var transactionStatusView: TransactionStatusView!
    
    weak var rootSheetController: RootSheetController?
    
    // MARK: - Initializers
    
    init(_ string: String, delegate: RootSheetController) {
        headerLabel.text = string
        rootSheetController = delegate
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
        
        addHorizontalDragIndicator()
        addTransactionCard()
        addTransactionStatusView()
    }
    
    private func setup() {
        // setup header
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 32)
        headerLabel.textAlignment = .center
        
        // setup buttons
        backButton.setTitle("TILBAKE", for: .normal)
        backButton.titleLabel?.setCharacterSpacing(1)
        backButton.setup(with: UIColor.solarstein.mariner.withAlphaComponent(0.05))
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        UIView.performWithoutAnimation {
            addSubviewsAndConstraints()
            view.layoutIfNeeded()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func addSubviewsAndConstraints() {
        // layout header
        view.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        // layout buttons
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(KRoundButton.size.height)
        }
        
        view.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(600)
        }
    }
    
    @objc func didTapBackButton() {
        rootSheetController?.pop()
    }
    
    private func addTransactionCard() {
        transactionCardView = makeDummyCard()
        
        view.addSubview(transactionCardView)
        transactionCardView.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.size.equalTo(TransactionCardView.estimatedItemSize)
        }
        
        transactionCardView.addShadow()
    }
    
    private func addTransactionStatusView() {
        transactionStatusView = TransactionStatusView()
        
        view.addSubview(transactionStatusView)
        transactionStatusView.snp.makeConstraints { (make) in
            make.top.equalTo(transactionCardView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(TransactionStatusView.estimatedItemSize)
        }
        
        transactionStatusView.addShadow()
    }
    
    private func makeDummyCard() -> TransactionCardView {
        return TransactionCardView()
    }
}


final class TransactionCardModel {
    
    // MARK: - Properties
    
    // MARK: - Initializers
    
    // MARK: - Life Cycle
    
    // MARK: - Methods
    
}

