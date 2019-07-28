//
//  DetailedTransactionFactory.swift
//  BottomSheet
//
//  Created by Amia Macone on 28/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation

protocol DetailedTransactionFactory {
    func makeDetailedTransactionModule() -> DetailedTransactionView
}
