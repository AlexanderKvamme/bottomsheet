import Foundation
import UIKit


/// This is an example of a simple rootViewController. It sets an initial sheet and uses didTapNext to push subsequent screens
final class PickerExampleRootSheet: RootViewController {
    
    // MARK: - Initializers
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialSheet()
    }
    
    // MARK: - Methods
    
    private func setInitialSheet() {
        let sheet = PickerSheet("Please pick something!", choices: ["one", "two", "three"], delegate: self)
        navigationStack = [sheet]
        addSheetLayout(sheet)
    }
    
    override func didTapNext() {
        let choices = ["Its like", "this", "and a", "that", "and a dis and a", "its like this", "and like this", "and like", "THAT", "What it to", "Mic check", "One, two"]
        let pickerSheet = PickerSheet("Pick something", choices: choices, delegate: self)
        push(pickerSheet)
    }
    
    override func pop() {
        popSheet()
    }
}

