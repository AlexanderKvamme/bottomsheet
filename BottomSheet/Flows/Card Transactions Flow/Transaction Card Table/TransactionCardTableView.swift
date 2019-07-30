//
//  TransactionCardTableViewController
//  BottomSheet
//
//  Created by Amia Macone on 29/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit

final class TransactionCardTableView: UITableView {
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        backgroundColor = .clear
        separatorStyle = .none
        separatorColor = .clear
        
        register(CardTransactionCell.self, forCellReuseIdentifier: CardTransactionCell.identifier)
        estimatedRowHeight = CardTransactionCell.estimatedItemSize.height
    }
}
