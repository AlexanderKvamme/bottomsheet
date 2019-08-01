import UIKit

protocol CoordinatorFactory {
    func makeSettingsCoordinator(router: Router) -> Coordinator
    func makeMainMenuCoordinator(router: Router) -> (coordinator: Coordinator, toPresent: UIViewController)
    func makeDetailedTransactionCoordinator(router: Router) -> Coordinator
    func makeCardTransactionsCoordinator(router: Router) -> Coordinator
}
