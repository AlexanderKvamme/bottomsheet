//
//  DetailedTransactionCoordinator.swift
//  BottomSheet
//
//  Created by Amia Macone on 28/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation

class DetailedTransactionCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    
    private var router: Router
    private var factory: DetailedTransactionFactory
    
    // MARK: - Initializers
    
    init(router: Router, factory: DetailedTransactionFactory) {
        self.router = router
        self.factory = factory
    }
    
    // MARK: - Methods
    
    override func start() {
        let detailedTransactionModule = factory.makeDetailedTransactionModule(router: router)
        detailedTransactionModule.onFinish = { [weak self] in
            self?.router.popModule()
        }
        
        router.push(detailedTransactionModule)
    }
}
