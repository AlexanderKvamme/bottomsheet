import UIKit



final class ModuleFactoryImp:
    SettingsModuleFactory,
    DetailedTransactionFactory,
    CardTransactionsFactory
{
    func makeDetailedTransactionModule(router: Router) -> DetailedTransactionView {
        let backgroundSheet = ZoomableReceiptViewController()
        let rootSheet = MatchfinderRootSheet(router: router)
        let bottomSheetContainer = ScrollableBottomSheetContainer(rootSheet)
        let container = DetailedTransactionViewController(mainViewController: backgroundSheet, sheetViewController: bottomSheetContainer)
        return container
    }
    
    func makeSettingsModule() -> SettingsView {
        return SettingsViewController()
    }

    func makeCardTransactionsModule(router: Router) -> CardTransactionsView {
        return CardTransactionsViewController()
    }
}

