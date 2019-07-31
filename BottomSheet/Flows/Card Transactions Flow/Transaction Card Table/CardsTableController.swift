//
//  CardsTableController.swift
//  BottomSheet
//
//  Created by Amia Macone on 31/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit
import ScrollingStackContainer


/// Needed for tableview to provide its own height automatically by ScrollingStackContainer
extension CardsTableController: StackContainable {
    func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
        return ScrollingStackController.ItemAppearance.scroll(cardsTable, insets: UIEdgeInsets.zero)
    }
}

final class CardsTableController: UIViewController {
    
    // MARK: - Properties
    
    private let cardsTable = TransactionCardTableView()
    private let cardsDataSourceAndDelegate = TransactionCardTableDataSourceAndDelegate()
    private let shadow = ShadowView()
    lazy private var footerView = makeFooterView()
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        cardsTable.dataSource = cardsDataSourceAndDelegate
        cardsTable.delegate = cardsDataSourceAndDelegate
        
        setupFooter()
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
    
    private func setupFooter() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFooter))
        footerView.addGestureRecognizer(tapGesture)
        cardsTable.tableFooterView = footerView
    }
    
    private func makeFooterView() -> UIView {
        return ShowMoreCellsFooterView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
    }
    
    @objc private func didTapFooter() {
        footerView.shakeByX()
    }
}

