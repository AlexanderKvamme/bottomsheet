import Foundation
import UIKit


/// This is an example of a simple rootViewController. It sets an initial sheet and uses didTapNext to push subsequent screens
final class PickerExampleRootSheet: BottomSheetViewController {
    
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
        
        push(CTPickerSheet("Please pick something!", choices: ["one", "two", "three"], delegate: self))
    }
    
    // MARK: - Methods
    
    override func didTapNext() {
        let inputSheet = TestInputBottomSheet(rootSheet: self)
        push(inputSheet)
    }
}

