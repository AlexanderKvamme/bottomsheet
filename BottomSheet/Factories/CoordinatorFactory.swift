import UIKit

protocol CoordinatorFactory {
    
    //  func makeTabbarCoordinator() -> (configurator: Coordinator, toPresent: Presentable?)
    func makeAuthCoordinatorBox(router: Router) -> Coordinator & AuthCoordinatorOutput
    
    func makeOnboardingCoordinator(router: Router) -> Coordinator & OnboardingCoordinatorOutput
    
    func makeItemCoordinator(navController: UINavigationController?) -> Coordinator
    func makeItemCoordinator() -> Coordinator
    
    func makeSettingsCoordinator(router: Router) -> Coordinator
    
    func makeMainMenuCoordinator(router: Router) -> (coordinator: Coordinator, toPresent: Presentable)
    
    func makeDetailedTransactionCoordinator(router: Router) -> Coordinator
    
    //  func makeItemCreationCoordinatorBox() ->
    //    (configurator: Coordinator & ItemCreateCoordinatorOutput,
    //    toPresent: Presentable?)
    
    //  func makeItemCreationCoordinatorBox(navController: UINavigationController?) ->
    //    (configurator: Coordinator & ItemCreateCoordinatorOutput,
    //    toPresent: Presentable?)
}
