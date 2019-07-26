//
//  TransactionMenuSheet.swift
//
//
//  Created by Amia Macone on 13/06/2019.
//

import Foundation
import UIKit


final class TransactionMenuSheet: UIViewController, HasHorizontalSheetIndicator {
    
    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let firstButton = KRoundButton()
    private let secondButton = KRoundButton()
    private let backButton = KRoundButton()
    
    weak var rootSheetController: RootSheetController?
    
    // MARK: - Initializers
    
    init(_ string: String, delegate: RootSheetController) {
        headerLabel.text = string
        rootSheetController = delegate
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
        
        addHorizontalDragIndicator()
    }
    
    private func setup() {
        // setup header
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 32)
        headerLabel.textAlignment = .center
        
        // setup buttons
        backButton.setTitle("Back", for: .normal)
        backButton.setup(with: UIColor.solarstein.mariner.withAlphaComponent(0.05))
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        UIView.performWithoutAnimation {
            addSubviewsAndConstraints()
            view.layoutIfNeeded()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func addSubviewsAndConstraints() {
        // layout header
        view.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        // layout buttons
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(KRoundButton.size.height)
        }
        
        view.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(600)
        }
    }
    
    @objc func didTapBackButton() {
        print("bam did tap back button in TransactionMenuSheet")
        rootSheetController?.pop()
    }   
}
