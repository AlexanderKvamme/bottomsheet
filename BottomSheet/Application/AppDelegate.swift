//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: Coordinator?
    var rootController = UINavigationController()
    
    lazy private var applicationCoordinator = makeCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootController
        
        // NEW
        let router = RouterImp(rootController: rootController)
        let coordinatorFactory = CoordinatorFactoryImp()
        coordinator = ApplicationCoordinator(router: router, coordinatorFactory: coordinatorFactory)
        coordinator?.start()
        
        // OLD
//        coordinator = MainCoordinator(navigationController: navigationController)
//        coordinator?.start()

        // ANCIENT
//        let zoomableReceiptViewController = ZoomableReceiptViewController()
//        let rootSheet = MatchfinderRootSheet(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//        let bottomSheetContainer = ScrollableBottomSheetContainer(rootSheet)
//        window.rootViewController = BottomSheetContainerViewController(mainViewController: zoomableReceiptViewController, sheetViewController: bottomSheetContainer)
        
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
    // MARK: - Methods
    
    private func makeCoordinator() -> Coordinator {
        return ApplicationCoordinator(
            router: RouterImp(rootController: self.rootController),
            coordinatorFactory: CoordinatorFactoryImp()
        )
    }
}

