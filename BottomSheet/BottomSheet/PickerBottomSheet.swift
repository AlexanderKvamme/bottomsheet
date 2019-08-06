import Foundation
import UIKit


typealias RootSheetController = UIPageViewController & RootSheet

final class PickerBottomSheet: BottomSheet {
    
    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let bottomRightButton = KRoundButton()
    private let bottomLeftButton = KRoundButton()
    
    weak var sheetPageController: RootSheetController?
    
    // MARK: - Initializers
    
    init(_ string: String, delegate: RootSheetController) {
        headerLabel.text = string
        sheetPageController = delegate
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: - Methods
    
    private func setup() {
        view.backgroundColor = UIColor.solarstein.sapphire
        
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 32)
        headerLabel.textAlignment = .center
        
        bottomLeftButton.setTitle("Mer", for: .normal)
        bottomLeftButton.setup(with: UIColor.solarstein.mariner.withAlphaComponent(0.05))
        bottomLeftButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        
        bottomRightButton.setTitle("next", for: .normal)
        bottomRightButton.setup(with: UIColor.solarstein.mediumSeaGreen)
        bottomRightButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    private func addSubviewsAndConstraints() {
        addHorizontalDragIndicator()
        
        // Layout header
        view.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        // layout buttons
        view.addSubview(bottomLeftButton)
        view.addSubview(bottomRightButton)
        
        let sideSpacing: CGFloat = 24
        let interButtonSpacing: CGFloat = 24
        let avaiableButtonSpace = UIScreen.main.bounds.width - 2 * sideSpacing - interButtonSpacing
        let rightButtonSize = avaiableButtonSpace*0.7
        let leftButtonSize = avaiableButtonSpace-rightButtonSize
        
        bottomLeftButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-sideSpacing)
            make.left.equalToSuperview().offset(sideSpacing)
            make.height.equalTo(40)
            make.width.equalTo(leftButtonSize)
        }
        
        bottomRightButton.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().offset(-24)
            make.height.equalTo(40)
            make.width.equalTo(rightButtonSize)
        }
        
        view.snp.makeConstraints { (make) in
            make.height.equalTo(500)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        view.layoutIfNeeded()
    }
    
    @objc func didTapNextButton() {
        sheetPageController?.didTapNext()
    }
    
    @objc func didTapMoreButton() {
        let menuSheet = CTBottomSheetMenu("Menu", delegate: sheetPageController!)
        sheetPageController!.push(menuSheet)
    }
}

