//
//  CardTransactionsViewController.swift
//  BottomSheet
//
//  Created by Amia Macone on 29/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class CardTransactionsViewController: UIViewController, CardTransactionsView, hasXButton, hasNavigationHeader {

    // MARK: - Properties

    lazy var xButton = makeXButton()
    lazy var navigationHeaderLabel = makeNavigationHeaderLabel()
    var onFinish: (() -> ())?
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)

        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        view.backgroundColor = UIColor.solarstein.seashell
        xButton.addTarget(self, action: #selector(finish), for: .touchUpInside)
        
        navigationHeaderLabel.text = "Juli"
    }
    
    private func addSubviewsAndConstraints() {
        applyXButtonConstraints()
        applyNavigationHeaderConstraints()
    }
    
    @objc private func finish() {
        onFinish?()
    }
}
