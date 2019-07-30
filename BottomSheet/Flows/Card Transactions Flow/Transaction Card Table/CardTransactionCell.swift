//
//  CardTransactionCell.swift
//  BottomSheet
//
//  Created by Amia Macone on 29/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit

    
final class CardTransactionCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "CardTransactionCell"
    static let estimatedItemSize = CGSize(width: UIScreen.main.bounds.width-CardController.horizontalInsets*2, height: 160)

    private let cellView = CardTransactionCellView()
    
    // MARK: - Initializers
    
    init() {
        super.init(style: .default, reuseIdentifier: CardTransactionCell.identifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(cellView)
        cellView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

