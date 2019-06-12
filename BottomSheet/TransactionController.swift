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
        view.snp.makeConstraints { (make) in
            make.height.equalTo(value)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        view.frame = CGRect(x: 0, y: 0, width: 300, height: value) // Must possibly be set when laying out subviews
    }
}


typealias MainSheetController = UIPageViewController & SheetPageController
    
final class TransactionController: UIViewController, isSelfSizeable {
    
    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let bottomRightButton = KRoundButton()
    private let bottomLeftButton = KRoundButton()
    
    weak var sheetPageController: MainSheetController?
    
    // MARK: - Initializers
    
    init(_ string: String, delegate: MainSheetController) {
        headerLabel.text = string
        sheetPageController = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.solarstein.mariner
        setSize(400)
        
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 100)
        headerLabel.textAlignment = .center

        bottomLeftButton.setTitle("Mer", for: .normal)
        bottomLeftButton.setup(with: UIColor.solarstein.sapphire)
        bottomLeftButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        
        bottomRightButton.setTitle("next", for: .normal)
        bottomRightButton.setup(with: UIColor.solarstein.mediumSeaGreen)
        bottomRightButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        // Layout header
        view.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        // layout buttons
        view.addSubview(bottomLeftButton)
        bottomLeftButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-24)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        view.addSubview(bottomRightButton)
        bottomRightButton.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().offset(-24)
            make.height.equalTo(40)
            make.width.equalTo(140)
        }
    }
    
    // MARK: - Methods
    
    @objc func didTapNextButton() {
        sheetPageController?.didTapNext()
    }
    
    @objc func didTapMoreButton() {
        print("did tap more")
        let menuSheet = TransactionMenu("MENU", delegate: sheetPageController!)
        sheetPageController!.setViewControllers([menuSheet], direction: .forward, animated: true, completion: nil)
    }
}

// FIXME: make smaller
final class TransactionMenu: UIViewController, isSelfSizeable {
  
    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let firstButton = KRoundButton()
    private let secondButton = KRoundButton()
    private let backButton = KRoundButton()
    
    weak var sheetPageController: MainSheetController?
    
    // MARK: - Initializers
    
    init(_ string: String, delegate: MainSheetController) {
        headerLabel.text = string
        sheetPageController = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // setup header
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 100)
        headerLabel.textAlignment = .center
        
        // setup buttons
        
        backButton.setTitle("Back", for: .normal)
        backButton.setup(with: UIColor.red)
        
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
        
        // set sheet size
        // FIXME: Make dynamic
        
        setSize(300)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    // MARK: - Methods
    
}
