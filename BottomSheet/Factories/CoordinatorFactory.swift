import UIKit

protocol CoordinatorFactory {
    
    //  func makeTabbarCoordinator() -> (configurator: Coordinator, toPresent: Presentable?)
    func makeAuthCoordinatorBox(router: Router) -> Coordinator & AuthCoordinatorOutput
    
    func makeOnboardingCoordinator(router: Router) -> Coordinator & OnboardingCoordinatorOutput
    
    func makeItemCoordinator(navController: UINavigationController?) -> Coordinator
    func makeItemCoordinator() -> Coordinator
    
    func makeSettingsCoordinator() -> Coordinator
    func makeSettingsCoordinator(navController: UINavigationController?) -> Coordinator
    
    func makeMainMenuCoordinator(router: Router) -> (coordinator: Coordinator, toPresent: Presentable)
    
    //  func makeItemCreationCoordinatorBox() ->
    //    (configurator: Coordinator & ItemCreateCoordinatorOutput,
    //    toPresent: Presentable?)
    
    //  func makeItemCreationCoordinatorBox(navController: UINavigationController?) ->
    //    (configurator: Coordinator & ItemCreateCoordinatorOutput,
    //    toPresent: Presentable?)
}
