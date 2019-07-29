//
//  CardTransactionFactory.swift
//  BottomSheet
//
//  Created by Amia Macone on 29/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation

protocol CardTransactionsFactory {
    func makeCardTransactionsModule(router: Router) -> CardTransactionsView
}
