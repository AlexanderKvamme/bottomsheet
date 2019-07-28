import UIKit



final class ModuleFactoryImp:
    SettingsModuleFactory,
    DetailedTransactionFactory
{
    
    func makeDetailedTransactionModule(router: Router) -> DetailedTransactionView {
        let zoomableReceiptViewController = ZoomableReceiptViewController()
//        let rootSheet = MatchfinderRootSheet(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil, router: Router)
        let rootSheet = MatchfinderRootSheet(router: router)
        let bottomSheetContainer = ScrollableBottomSheetContainer(rootSheet)
        let container = DetailedTransactionViewController(mainViewController: zoomableReceiptViewController, sheetViewController: bottomSheetContainer)
        return container
    }
    
    func makeSettingsModule() -> SettingsView {
        return SettingsViewController()
    }
}

