//
//  DetailedTransactionSheet.swift
//  BottomSheet
//
//  Created by Amia Macone on 18/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class CTPickerConfirmationSheet: BSBottomSheet {

    // MARK: - Properties
    
    private let backButton = KRoundButton()
    private var transactionCardView: TransactionCardView!
    private var transactionStatusView: TransactionStatusView!
    
    weak var rootSheetController: BottomSheetViewController?
    
    // MARK: - Initializers
    
    init(delegate: BottomSheetViewController) {
        rootSheetController = delegate
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
        
        addHorizontalDragIndicator()
        addTransactionCard()
        addTransactionStatusView()
    }
    
    private func setup() {
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
            make.top.equalToSuperview().offset(SheetTopVisibility.minimum.rawValue-40)
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
        let model = TransactionCardModel(title: "Barnehagedørprodusenten AS", value: "399 kr", tax: "Legg til MVA", account: "Legg til konto")
        let cardView = TransactionCardView()
        cardView.update(with: model)
        return cardView
    }
}


final class TransactionCardModel {

    // MARK: - Properties
    
    let title: String
    let value: String
    let tax: String
    let account: String
    
    // MARK: - Initializers
    
    init(title: String, value: String, tax: String, account: String) {
        self.title = title
        self.value = value
        self.tax = tax
        self.account = account
    }
}

