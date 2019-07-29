//
//  'Settings'ViewController.swift
//  BottomSheet
//
//  Created by Amia Macone on 23/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class SettingsViewController: UIViewController, SettingsView {
    
    // MARK: - Properties

    var onFinish: (() -> ())?
    
    var coordinator: Coordinator!
    
    private let xButton = UIButton()
    private let headerLabel = UILabel()
    private let subheaderLabel = UILabel()
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private var dataSourceAndDelegate = SettingsDataSourceAndDelegate()
    private let tableViewShadow = ShadowView()
    
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
    }
    
    // MARK: - Methods

    private func setup() {
        setupXButton()
        setupLabels()
        setupTableView()
    }
    
    private func setupXButton() {
        xButton.setImage(UIImage(named: "x-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        xButton.addTarget(self, action: #selector(finish), for: .touchUpInside)
        xButton.tintColor = UIColor.solarstein.sapphire
        xButton.alpha = 0.1
    }
    
    private func setupLabels() {
        headerLabel.text = "Innstillinger"
        headerLabel.textColor = UIColor.solarstein.sapphire
        headerLabel.font = UIFont.kolibrix.header
        
        subheaderLabel.text = "Her kan du justere dine preferanser"
        subheaderLabel.textColor = UIColor.solarstein.sapphire
        subheaderLabel.alpha = 0.3
        subheaderLabel.font = UIFont.kolibrix.body
    }
    
    private func setupTableView() {
        tableView.dataSource = dataSourceAndDelegate
        tableView.delegate = dataSourceAndDelegate
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.separatorColor = UIColor.solarstein.sapphire
        tableView.clipsToBounds = true
    }
    
    private func addSubviewsAndConstraints() {
        [tableViewShadow, headerLabel, subheaderLabel, tableView, xButton, tableView].forEach({ view.addSubview($0) })
        
        tableViewShadow.backgroundColor = .clear
        
        tableViewShadow.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(xButton.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview()
        }
        
        subheaderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerLabel)
            make.top.equalTo(headerLabel.snp.bottom)
            make.right.equalToSuperview()
        }
        
        xButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.leftMargin).offset(32+Device.additionalInsetsIfNotched)
            make.height.width.equalTo(48)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(subheaderLabel.snp.bottom).offset(40)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    @objc private func finish() {
        onFinish?()
    }
}

