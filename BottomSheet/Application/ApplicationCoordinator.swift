//
//  ApplicationCoordinator.swift
//  BottomSheet
//
//  Created by Amia Macone on 24/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation

fileprivate var onboardingWasShown = false
fileprivate var isAutorized = false

fileprivate enum LaunchInstructor {
    case main, auth, onboarding
    
    static func configure(tutorialWasShown: Bool = onboardingWasShown,
                          isAutorized: Bool = isAutorized) -> LaunchInstructor {
        switch (tutorialWasShown, isAutorized) {
        case (true, false), (false, false): return .auth
        case (false, true): return .onboarding
        case (true, true): return .main
        }
    }
}

// MARK: - Class ApplicationCoordinator

final class ApplicationCoordinator: BaseCoordinator {
    
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    private var instructor: LaunchInstructor {
        return LaunchInstructor.configure()
    }
    
    // MARK: Initializer
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    // MARK: Methods
    
    override func start() {
        // Use a switch on the instructor value to decide if user is logged inn and decide flow
        runMainMenuFlow()
    }
    
    /// Main flow is just the main view controller as RootModule
    private func runMainMenuFlow() {
        let (coordinator, presentable) = coordinatorFactory.makeMainMenuCoordinator(router: router)
        // remove self on finish?
        addDependency(coordinator)
        router.setRootModule(presentable)
        coordinator.start()
    }
}

