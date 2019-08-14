import Foundation
import UIKit


final class TestInputBottomSheet: BSBottomSheet {
    
    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let inputField = UITextField()
    private let nextButton = UIButton()
    
    weak var rootSheet: BottomSheetViewController?
    
    // MARK: - Initializers
    
    init(rootSheet: BottomSheetViewController) {
        self.rootSheet = rootSheet
        
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = UIColor.solarstein.sapphire
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        headerLabel.textColor = .white
        headerLabel.font = UIFont.kolibrix.subheader
        headerLabel.textAlignment = .left
        headerLabel.text = "Trekk ut beløp:"
        
        nextButton.setImage(UIImage(named: "x-icon"), for: .normal)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        inputField.placeholder = "0 kr"
        inputField.font = UIFont.kolibrix.subheader
        inputField.textColor = .white
        inputField.tintColor = .white
        inputField.delegate = self
        inputField.keyboardType = .numberPad
        
        if let placeholder = inputField.placeholder {
            inputField.attributedPlaceholder = NSAttributedString(string:placeholder,
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2)])
        }
    }
    
    private func addSubviewsAndConstraints() {
        [headerLabel, inputField, nextButton].forEach({ view.addSubview($0) })

        addHorizontalDragIndicator()
        
        // Layout header
        headerLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(48)
            make.left.equalToSuperview().offset(48)
            make.right.equalToSuperview()
        }
        
        inputField.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom)
            make.left.equalTo(headerLabel).offset(8)
            make.right.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-48)
            make.top.equalTo(headerLabel)
            make.bottom.equalTo(inputField)
            make.width.equalTo(48)
        }

        // layout
        view.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(700).priority(1000)
        }
    }
    
    @objc private func didTapNextButton() {
        inputField.resignFirstResponder()
        
        let newController = CTPickerSheet("\(inputField.text!)", choices: ["you", "picked", "it"], delegate: rootSheet!)
        rootSheet?.push(newController)
    }
}

extension TestInputBottomSheet: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let notificationName = Notification.Name.sheetContainedTextFieldDidBecomeFirstResponder
        let userInfo: [AnyHashable : Any] = ["inputPosition" : textField.frame]
        let notification = Notification(name: notificationName, object: textField, userInfo: userInfo)
        NotificationCenter.default.post(notification)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

