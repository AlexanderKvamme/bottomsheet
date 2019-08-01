//
//  TransactionCardTableViewController
//  BottomSheet
//
//  Created by Amia Macone on 29/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit
import ScrollingStackContainer


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
        
        register(WhiteCardTransactionCell.self, forCellReuseIdentifier: WhiteCardTransactionCell.identifier)
        estimatedRowHeight = WhiteCardTransactionCell.estimatedItemSize.height
    }
}

