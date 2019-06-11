//
//  ViewControllerA.swift
//  BottomSheet
//
//  Created by Amia Macone on 11/06/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit

protocol isSelfSizeable: class {
    func setSize(_ value: CGFloat) -> Void
}

extension isSelfSizeable where Self: UIViewController {
    func setSize(_ value: CGFloat) {
        // self
        view.snp.makeConstraints { (make) in
            make.height.equalTo(value)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        view.frame = CGRect(x: 0, y: 0, width: 300, height: value) // Must possibly be set when laying out subviews
    }
}

final class LetterViewController: UIViewController, isSelfSizeable {
    
    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let bottomRightButton = UIButton()
    
    // MARK: - Initializers
    
    override func viewDidLoad() {

        view.backgroundColor = UIColor.solarstein.sapphire
        setSize(400)
        
        headerLabel.text = "A"
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 100)
        headerLabel.textAlignment = .center

        bottomRightButton.setTitle("next", for: .normal)
        bottomRightButton.backgroundColor = .green
        bottomRightButton.layer.cornerRadius = 20
        bottomRightButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        // Layout header
        view.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        // layout buttons
        view.addSubview(bottomRightButton)
        bottomRightButton.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().offset(-24)
            make.height.equalTo(40)
            make.width.equalTo(140)
        }
        
        
        
    }
    
    // MARK: - Life Cycle
    
    // MARK: - Methods
    
    @objc func didTapNextButton() {
        print("did tap next")
    }
}
