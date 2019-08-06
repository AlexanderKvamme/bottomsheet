//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let zoomableReceiptViewController = ZoomableReceiptViewController()
        let rootSheet = MatchfinderRootSheet()

        // OLD
//        let bottomSheetContainer = ScrollableBottomSheetContainer(rootSheet)
//        let initialViewController = BottomSheetContainerViewController(mainViewController: zoomableReceiptViewController, sheetViewController: bottomSheetContainer)

        // NEW: Try to make the Initial viewcontroller take a bottomsheetcontainer as a container and then rather wrap it while in its initializer
//        let bottomSheetContainer = ScrollableBottomSheetContainer(rootSheet)
//        let initialViewController = BottomSheetContainerViewController(mainViewController: zoomableReceiptViewController, sheetViewController: bottomSheetContainer)
        
        let initialViewController = BottomSheetContainerViewController(mainViewController: zoomableReceiptViewController, sheetViewController: rootSheet)
        
        window.rootViewController = initialViewController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
}

