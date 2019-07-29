//
//  CardTransactionsViewController.swift
//  BottomSheet
//
//  Created by Amia Macone on 29/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class CardTransactionsViewController: UIViewController, CardTransactionsView, hasXButton {

    // MARK: - Properties

    lazy var xButton = makeXButton()
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
        view.backgroundColor = .green
        xButton.addTarget(self, action: #selector(finish), for: .touchUpInside)
    }
    
    private func addSubviewsAndConstraints() {
        applyXButtonConstraints()
    }
    
    @objc private func finish() {
        onFinish?()
    }
}
