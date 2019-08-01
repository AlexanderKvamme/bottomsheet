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


extension SKScreenHeaderController: StackContainable {
    func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
        return ScrollingStackController.ItemAppearance.view(height: 120 )
    }
}

final class SKScreenHeaderController: UIViewController {

    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let subheaderLabel = UILabel()
    
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
        headerLabel.text = "Innstillinger"
        headerLabel.textColor = UIColor.solarstein.sapphire
        headerLabel.font = UIFont.kolibrix.header
        
        subheaderLabel.text = "Her kan du justere dine preferanser"
        subheaderLabel.textColor = UIColor.solarstein.sapphire
        subheaderLabel.alpha = 0.3
        subheaderLabel.font = UIFont.kolibrix.body
    }
    
    private func addSubviewsAndConstraints() {
        [headerLabel, subheaderLabel].forEach({ view.addSubview($0) })
        
        headerLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(40).priority(750)
            make.right.equalToSuperview()
        }
        
        subheaderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerLabel)
            make.top.equalTo(headerLabel.snp.bottom)
            make.right.equalToSuperview()
        }
    }
}


extension SettingsTableController: StackContainable {
    func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
        return ScrollingStackController.ItemAppearance.scroll(tableView, insets: UIEdgeInsets.zero)
    }
}

final class SettingsTableController: UIViewController {

    // MARK: - Properties
    
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private var dataSourceAndDelegate = SettingsDataSourceAndDelegate()
    private let tableViewShadow = ShadowView()
    
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
        setupTableView()
    }
    
    private func addSubviewsAndConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
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
}

final class SettingsViewController: ScrollingStackController, SettingsView {
    
    // MARK: - Properties

    var onFinish: (() -> ())?
    
    var coordinator: Coordinator!
    
    private let customNav = SKTopNavigationController()
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

