//
//  MainMenuViewController.swift
//  BottomSheet
//
//  Created by Amia Macone on 22/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class MainMenuViewController: UIViewController {
    
    // MARK: - Properties
    
    private var tableView = ModulesTableView()
    private var settingsIcon = UIImageView()
    private var cameraIcon = UIImageView()
    private var dataSourceAndDelegate = ModulesDataSourceAndDelegate()
    
    // MARK: - Initializers
    
    var coordinator: Coordinator!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = UIColor.solarstein.seashell
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Methods
    
    private func setup() {
        tableView.dataSource = dataSourceAndDelegate
        tableView.delegate = dataSourceAndDelegate
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        
        settingsIcon.image = UIImage(named: "icon-settings")
        cameraIcon.image = UIImage(named: "icon-camera")
    }
    
    private func addSubviewsAndConstraints() {
        [cameraIcon, settingsIcon, tableView].forEach({ view.addSubview($0) })
        
        settingsIcon.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.rightMargin).offset(-32+Device.additionalInsetsIfNotched)
            make.height.width.equalTo(32)
        }
        
        cameraIcon.snp.makeConstraints { (make) in
            make.height.equalTo(28.8)
            make.width.equalTo(32)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-32)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(200)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
        }
    }
}

