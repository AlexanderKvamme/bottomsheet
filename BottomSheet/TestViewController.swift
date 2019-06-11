//
//  TestViewController.swift
//  BottomSheet
//
//  Created by Amia Macone on 11/06/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class TestViewController: UIViewController {
    
    // MARK: - Properties
    
    let topLeftButton = UIButton()
    let bottomRightButton = UIButton()
    
    // MARK: - Initializers
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        topLeftButton.setTitle("Top left", for: .normal)
        bottomRightButton.setTitle("Bottom right", for: .normal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        view.backgroundColor = .green
        
        // self
        view.snp.makeConstraints { (make) in
            make.height.equalTo(2000)
            make.width.equalTo(UIScreen.main.bounds.width)
        }

        view.frame = CGRect(x: 0, y: 0, width: 300, height: 2000) // Must possibly be set when laying out subviews

        // components
        let buttons = [topLeftButton, bottomRightButton]
        
        buttons.forEach({ view.addSubview($0) })
        buttons.forEach({ $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)})
        
        topLeftButton.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(30)
        }
        
        bottomRightButton.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().offset(-30)
        }
        
        let purpleView = UIView()
        purpleView.backgroundColor = .purple
        
        view.addSubview(purpleView)
        
        purpleView.snp.makeConstraints { (make) in
            make.height.equalTo(1000)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    @objc func didTapButton() {
        print("did tap button")
    }
    
}
