import UIKit

final class CoordinatorFactoryImp: CoordinatorFactory {
    
    func makeDetailedTransactionCoordinator(router: Router) -> Coordinator {
        let coordinator = DetailedTransactionCoordinator(router: router, factory: ModuleFactoryImp())
        return coordinator
    }
    
    // FIXME: Tror ikke controlleren skal returneres her. Mener coordinatoren skal fikse det
    func makeMainMenuCoordinator(router: Router) -> (coordinator: Coordinator, toPresent: Presentable) {
        let controller = MainMenuViewController(router: router)
        let coordinator = MainMenuCoordinator(controller: controller, coordinatorFactory: CoordinatorFactoryImp())
        return (coordinator, controller)
    }
    
    func makeSettingsCoordinator(router: Router) -> Coordinator {
        let coordinator = SettingsCoordinator(router: router, factory: ModuleFactoryImp())
        return coordinator
    }
    
    func makeCardTransactionsCoordinator(router: Router) -> Coordinator {
        let coordinator = CardTransactionsCoordinator(router: router)
        return coordinator
    }
    
    private func router(_ navController: UINavigationController?) -> Router {
        return RouterImp(rootController: navigationController(navController))
    }
    
    private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController { return navController }
        else { return UINavigationController() }
    }
}
