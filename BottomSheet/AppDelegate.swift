import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Initial view controller
//        let underlyingController = ZoomableReceiptViewController()
//        let overlyingSheet = MatchfinderRootSheet()
//        let initialViewController = BottomSheetContainer(underlyingViewController: underlyingController, overlyingSheetController: overlyingSheet)

        // TODO: Test med pickersheet
        let underlyingController = ZoomableReceiptViewController()
        let overlyingSheet = PickerExampleRootSheet()
        let initialViewController = BottomSheetContainer(underlyingViewController: underlyingController, overlyingSheetController: overlyingSheet)
        
        // Set window
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = initialViewController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

