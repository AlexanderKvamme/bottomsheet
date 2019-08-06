import Foundation
import UIKit


final class MatchfinderRootSheet: BottomSheetViewController {
    
    // MARK: - Initializers
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.solarstein.sapphire
        roundTopCorners()
        setInitialSheet()
    }
    
    // MARK: - Methods
    
    private func setInitialSheet() {
        let sheet = CTPickerConfirmationSheet(delegate: self)
        navigationStack = [sheet]
        addSheetLayout(sheet)
    }
    
    override func didTapNext() {
        let choices = ["Its like", "this", "and a", "that", "and a dis and a", "its like this", "and like this", "and like", "THAT", "What it to", "Mic check", "One, two"]
        let pickerSheet = CTPickerSheet("Pick something", choices: choices, delegate: self)
        push(pickerSheet)
    }
    
    override func pop() {
        popSheet()
    }
}
