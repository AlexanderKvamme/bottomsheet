import UIKit


protocol SettingsView: UIViewController {
    var onFinish: (() -> ())? { get set }
}

protocol DetailedTransactionView: UIViewController {
    var onFinish: (() -> ())? { get set }
}

protocol CardTransactionsView: UIViewController {
    var onFinish: (() -> ())? { get set }
}
