//
//  TransactionTableDataSourceAndDelegate.swift
//  BottomSheet
//
//  Created by Amia Macone on 29/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class TransactionCardTableDataSourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    lazy var cardModels = makeDummyCardModels()
    
    // MARK: - Private Methods
    
    private func makeDummyCardModels() -> [TransactionCardModel] {
        var models = [TransactionCardModel]()
        models.append(TransactionCardModel(title: "First", value: "value", tax: "tax", account: "account"))
        models.append(TransactionCardModel(title: "Second", value: "value", tax: "tax", account: "account"))
        models.append(TransactionCardModel(title: "Third", value: "value", tax: "tax", account: "account"))
        models.append(TransactionCardModel(title: "Fourth", value: "value", tax: "tax", account: "account"))
        models.append(TransactionCardModel(title: "Fifth", value: "value", tax: "tax", account: "account"))
        return models
    }
    
    // MARK: Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CardTransactionCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CardTransactionCell.estimatedItemSize.height
    }
}
