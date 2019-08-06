import Foundation

// MARK: Protocols

protocol isSheetViewController: class {
    var mainViewController: SheetScrollResponder { get set }
    var sheetViewController: BottomSheet { get set }
    var bottomSheetContainerView: BottomSheetContainerView { get set }
}
