
//
//  MainCoordinator.swift
//  BottomSheet
//
//  Created by Alexander Kvamme on 20/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class MainMenuCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let viewController: UIViewController
    let coordinatorFactory: CoordinatorFactory
    
    // MARK: - Initializers
    
    init(controller: UIViewController, coordinatorFactory: CoordinatorFactory) {
        self.viewController = controller
        self.coordinatorFactory = coordinatorFactory
    }
    
    // MARK: - Methods
    
    func start() {
        print("would start main menu coordinator")
//        router.setRootModule(controller)
    }
}

