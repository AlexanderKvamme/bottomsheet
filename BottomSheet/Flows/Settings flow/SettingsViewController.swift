//
//  'Settings'ViewController.swift
//  BottomSheet
//
//  Created by Amia Macone on 23/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit
import ScrollingStackContainer


final class SettingsViewController: ScrollingStackController, SettingsView {
    
    // MARK: - Properties

    var onFinish: (() -> ())?
    
    var coordinator: Coordinator!
    
    private let customNav = SKTopNavigationController(backButtonStyle: .cross, faded: true)
    private let headerController = SKScreenHeaderController()
    private let tableController = SettingsTableController()
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.solarstein.seashell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        setup()
        addSubviewsAndConstraints()
        
        viewControllers = [customNav, headerController, tableController] as [StackContainable]
    }
    
    // MARK: - Methods
    
    private func setup() {
        setupScrollView()
        
        customNav.topLeftNavigationButton.addTarget(self, action: #selector(finish), for: .touchUpInside)
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView(frame: .zero)
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.backgroundColor = .white
    }
    
    private func addSubviewsAndConstraints() {
        guard let scrollView = scrollView else { fatalError() }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func finish() {
        onFinish?()
    }
}

