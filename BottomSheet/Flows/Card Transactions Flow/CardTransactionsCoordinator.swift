//
//  CardTransactionsCoordinator.swift
//  BottomSheet
//
//  Created by Amia Macone on 29/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation

final class CardTransactionsCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    
    private var router: Router
    
    // MARK: - Initializers
    
    init(router: Router) {
        self.router = router
    }
    
    // MARK: - Methods
    
    override func start() {
        let module = ModuleFactoryImp().makeCardTransactionsModule(router: router)
        module.onFinish = { [weak self] in
            self?.router.popModule()
        }
        
        router.push(module.toPresent())
    }
}
