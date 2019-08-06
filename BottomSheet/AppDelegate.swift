//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Initial view controller
        let underlyingController = ZoomableReceiptViewController()
        let overlyingSheet = MatchfinderRootSheet()
        let initialViewController = BottomSheetContainerViewController(mainViewController: underlyingController, sheetViewController: overlyingSheet)

        // Set window
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = initialViewController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

