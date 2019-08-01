//
//  SettingsTableController.swift
//  BottomSheet
//
//  Created by Amia Macone on 01/08/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit
import ScrollingStackContainer


extension SettingsTableController: StackContainable {
    func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
        return ScrollingStackController.ItemAppearance.scroll(tableView, insets: UIEdgeInsets.zero)
    }
}

/// TableView wrapped in a StackContainable UIViewController to be used in ScrollingStacks
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
