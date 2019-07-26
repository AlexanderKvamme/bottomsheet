import UIKit

final class CoordinatorFactoryImp: CoordinatorFactory {
    
    //  func makeTabbarCoordinator() -> (configurator: Coordinator, toPresent: Presentable?) {
    ////    let controller = TabbarController.controllerFromStoryboard(.main)
    //    let controller: TabbarController!
    //    let coordinator = TabbarCoordinator(tabbarView: controller, coordinatorFactory: CoordinatorFactoryImp())
    //    return (coordinator, controller)
    //  }
    
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
    
    func makeAuthCoordinatorBox(router: Router) -> Coordinator & AuthCoordinatorOutput {
        let coordinator = AuthCoordinator(router: router, factory: ModuleFactoryImp())
        return coordinator
    }
    
    func makeItemCoordinator() -> Coordinator {
        return makeItemCoordinator(navController: nil)
    }
    
    func makeOnboardingCoordinator(router: Router) -> Coordinator & OnboardingCoordinatorOutput {
        return OnboardingCoordinator(with: ModuleFactoryImp(), router: router)
    }
    
    func makeItemCoordinator(navController: UINavigationController?) -> Coordinator {
        let coordinator = ItemCoordinator(
            router: router(navController),
            factory: ModuleFactoryImp(),
            coordinatorFactory: CoordinatorFactoryImp()
        )
        return coordinator
    }
    
    func makeSettingsCoordinator(router: Router) -> Coordinator {
        let coordinator = SettingsCoordinator(router: router, factory: ModuleFactoryImp())
        return coordinator
    }
    
    func makeItemCreationCoordinatorBox() ->
        (configurator: Coordinator & ItemCreateCoordinatorOutput,
        toPresent: Presentable?) {
            
            fatalError("fix this")
            return makeItemCreationCoordinatorBox()
            //      return makeItemCreationCoordinatorBox(navController: navigationController(nil))
    }
    
    //  func makeItemCreationCoordinatorBox(navController: UINavigationController?) ->
    //    (configurator: Coordinator & ItemCreateCoordinatorOutput,
    //    toPresent: Presentable?) {
    //
    //      let router = self.router(navController)
    //      let coordinator = ItemCreateCoordinator(router: router, factory: ModuleFactoryImp())
    //      return (coordinator, router)
    //  }
    
    private func router(_ navController: UINavigationController?) -> Router {
        return RouterImp(rootController: navigationController(navController))
    }
    
    private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController { return navController }
            //    else { return UINavigationController.controllerFromStoryboard(.main) }
        else { return UINavigationController() }
    }
}
