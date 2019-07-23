//
//  SettingsCoordinator.swift
//  BottomSheet
//
//  Created by Amia Macone on 23/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit

final class SettingsCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func start() {
        let vc = SettingsViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}

