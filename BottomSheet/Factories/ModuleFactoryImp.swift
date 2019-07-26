import UIKit

class DetailedTransactionViewController: BottomSheetContainerViewController, DetailedTransactionView, hasXButton {

    // MARK: - Properties
    
    lazy var xButton = makeXButton()
    
    var onFinish: (() -> ())?
    
    override init(mainViewController: SheetScrollResponder, sheetViewController: BottomSheetViewController) {
        super.init(mainViewController: mainViewController, sheetViewController: sheetViewController)

        print(" bam did init")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        applyXButtonConstraints()
        xButton.addTarget(self, action: #selector(performFinish), for: .touchUpInside)
    }
    
    // MARK: - Methods
    
    @objc private func performFinish() {
        print("bam would perform onFinish")
        onFinish?()
    }
}

final class ModuleFactoryImp:
    AuthModuleFactory,
    OnboardingModuleFactory,
    ItemModuleFactory,
    //  ItemCreateModuleFactory,
    SettingsModuleFactory,
    DetailedTransactionFactory
{
    func makeDetailedTransactionModule() -> DetailedTransactionView {
        return makeDetailedViewController()
    }
    
    private func makeDetailedViewController() -> DetailedTransactionView {
        let zoomableReceiptViewController = ZoomableReceiptViewController()
        let rootSheet = MatchfinderRootSheet(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        let bottomSheetContainer = ScrollableBottomSheetContainer(rootSheet)
        let container = DetailedTransactionViewController(mainViewController: zoomableReceiptViewController, sheetViewController: bottomSheetContainer)
        return container
    }
    
    func makeLoginOutput() -> LoginView {
        return LoginViewController()
    }
    
    func makeSignUpHandler() -> SignUpView {
        // FIME: - Delete the controllerFromStoryboard implementations
        //    return SignUpController.controllerFromStoryboard(.auth)
        return SignupViewController()
    }
    
    func makeOnboardingModule() -> OnboardingView {
        //    return OnboardingController.controllerFromStoryboard(.onboarding)
        return OnboardingViewController()
    }
    
    func makeTermsOutput() -> TermsView {
        //    return TermsController.controllerFromStoryboard(.auth)
        return TermsViewController()
    }
    
    func makeItemsOutput() -> ItemsListView {
        //    return ItemsListController.controllerFromStoryboard(.items)
        return ItemsListController()
    }
    
    func makeItemDetailOutput(item: ItemList) -> ItemDetailView {
        
        //    let controller = ItemDetailController.controllerFromStoryboard(.items)
        let controller = ItemDetailController()
        controller.itemList = item
        return controller
    }
    
    //  func makeItemAddOutput() -> ItemCreateView {
    //    return ItemCreateController.controllerFromStoryboard(.create)
    //  }
    
    func makeSettingsModule() -> SettingsView {
        //    return SettingsController.controllerFromStoryboard(.settings)
        return SettingsViewController()
    }
}





final class LoginViewController: UIViewController, LoginView {
    
    // MARK: - Properties
    
    var onCompleteAuth: (() -> Void)?
    var onSignUpButtonTap: (() -> Void)?
    
    // MARK: - Initializers
    
    // MARK: - Life Cycle
    
    // MARK: - Methods
}


final class OnboardingViewController: UIViewController, OnboardingView {
    
    // MARK: - Properties
    
    var onFinish: (() -> Void)? = nil
    
    // MARK: - Initializers
    
    // MARK: - Life Cycle
    
    // MARK: - Methods
}


final class TermsViewController: UIViewController, TermsView {
    
    // MARK: - Properties
    
    lazy var confirmed: Bool = {
        return isConfirmed()
    }()
    var onConfirmChanged: ((Bool) -> ())?
    
    // MARK: - Initializers
    
    // MARK: - Life Cycle
    
    // MARK: - Methods
    
    private func isConfirmed() -> Bool {
        return false
    }
}


final class ItemsListViewController: UIViewController, ItemsListView {
    
    // MARK: - Properties
    
    var onItemSelect: ((ItemList) -> ())? = nil
    var onCreateItem: (() -> Void)? = nil
    
    // MARK: - Initializers
    
    // MARK: - Life Cycle
    
    // MARK: - Methods
}


final class ItemDetailController: UIViewController, ItemDetailView {
    
    // MARK: - Properties
    
    var itemList: ItemList?
    
    // MARK: - Initializers
    
    // MARK: - Life Cycle
    
    // MARK: - Methods
}


final class SignupViewController: UIViewController, SignUpView {
    
    // MARK: - Properties
    
    //controller handler
    
    var onSignUpComplete: (() -> Void)?
    var onTermsButtonTap: (() -> Void)?
    
    private let termsLabel = UILabel()
    private let signUpButton = UIButton()
    
    var confirmed = false {
        didSet {
            termsLabel.isHidden = !confirmed
            signUpButton.isEnabled = confirmed
        }
    }
    
    func signUpClicked(_ sender: AnyObject) {
        if confirmed {
            onSignUpComplete?()
        }
    }
    
    func termsButtonClicked(_ sender: AnyObject) {
        onTermsButtonTap?()
    }
    
    func conformTermsAgreement(_ agree: Bool) {
        confirmed = agree
    }
    
    // MARK: - Initializers
    
    // MARK: - Life Cycle
    
    // MARK: - Methods
}
