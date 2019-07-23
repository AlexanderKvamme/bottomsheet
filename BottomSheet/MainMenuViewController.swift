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
    private var userGuideCard: UserGuideCard?
    
    // MARK: - Initializers
    
    var coordinator: Coordinator!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = UIColor.solarstein.seashell
        
        let userGuideModel = UserGuideModel(badgeValue: 6)
        userGuideCard = UserGuideCard(userGuideModel: userGuideModel)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(shakeUserGuide))
        userGuideCard?.addGestureRecognizer(tapRecognizer)
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let coordinator = SettingsCoordinator(navigationController: navigationController!)
        coordinator.start()
    }
    
    // MARK: - Methods
    
    private func setup() {
        tableView.dataSource = dataSourceAndDelegate
        tableView.delegate = dataSourceAndDelegate
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        
        cameraIcon.image = UIImage(named: "icon-camera")
        
        // Settings button
        settingsIcon.image = UIImage(named: "icon-settings")
        let tapRec = UITapGestureRecognizer(target: self, action: #selector(showSettingsController))
        settingsIcon.addGestureRecognizer(tapRec)
        settingsIcon.isUserInteractionEnabled = true
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
        
        // FIXME: Find better solution
        
        if let card = userGuideCard {
            view.addSubview(card)
            card.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.width.equalTo(360)
                make.height.equalTo(100)
                make.top.equalToSuperview().offset(120)
            }
        }
    }
    
    @objc private func shakeUserGuide() {
        userGuideCard?.shakeByX()
    }
    
    @objc private func showSettingsController() {
        print("would show settings")

        let settingsCoordinator = SettingsCoordinator(navigationController: navigationController!)
        settingsCoordinator.start()
    }
}

