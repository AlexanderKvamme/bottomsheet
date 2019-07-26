protocol SettingsModuleFactory {
  func makeSettingsModule() -> SettingsView
}

protocol DetailedTransactionFactory {
    func makeDetailedTransactionModule() -> DetailedTransactionView
}
