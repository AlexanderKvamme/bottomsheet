protocol SettingsView: BaseView {
    var onFinish: (() -> ())? { get set }
}

protocol DetailedTransactionView: BaseView {
    var onFinish: (() -> ())? { get set }
}

protocol CardTransactionsView: BaseView {
    var onFinish: (() -> ())? { get set }
}
