
//
//  MainCoordinator.swift
//  BottomSheet
//
//  Created by Alexander Kvamme on 20/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit





final class TestViewController: UIViewController {
    
    var coordinator: Coordinator!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


protocol AuthCoordinatorDelegate {
    func logIn()
}

final class AuthCoordinator: Coordinator {

    // MARK: - Properties

    var childCoordinators = [Coordinator]()
    var delegate: AuthCoordinatorDelegate!
    unowned var navigationController: UINavigationController
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func start() {
        print("would start")
    }
}


final class MainCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func start() {
        let isLoggedIn = true
        
        if isLoggedIn {
            self.showContent()
        } else {
            self.showAuthentication()
        }
    }
    
    private func showContent() {
        let vc = TestViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        
        let coordinator = AuthCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
    }
    
    private func showAuthentication() {}
}

extension MainCoordinator: AuthCoordinatorDelegate {
    func logIn() {
        print("would log in")
    }
}

