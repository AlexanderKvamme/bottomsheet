//
//  PickerSheet.swift
//  Pods-BottomSheet
//
//  Created by Amia Macone on 13/06/2019.
//

import Foundation
import UIKit


final class PickerSheet: UIViewController {
    
    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let tableView = UITableView()
    private var choices: [String] = ["Its like", "this", "and a", "that", "and a dis and a", "its like this", "and like this", "and like", "THAT"]
    private var popButton = KRoundButton()
    
    weak var rootSheet: RootSheetController?
    
    // MARK: - Initializers
    
    init(_ string: String, delegate: RootSheetController) {
        headerLabel.text = string
        rootSheet = delegate
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        view.backgroundColor = UIColor.solarstein.sapphire
        
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 32)
        headerLabel.textAlignment = .center
        headerLabel.text = "Pick something"
        
        popButton.setTitle("pop", for: .normal)
        popButton.setup(with: .red)
        popButton.addTarget(self, action: #selector(didTapPopButton), for: .touchUpInside)
        
        // Layout header
        view.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        // setup tableview
        tableView.register(PickerCell.self, forCellReuseIdentifier: PickerCell.identifier)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.separatorStyle = .none

        // layout
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom).offset(24)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-24)
            make.height.equalTo(777) // to make it updatable after contentView size is updated
        }
        
        view.addSubview(popButton)
        popButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(60)
        }
        
        view.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.greaterThanOrEqualTo(400)
        }
    }
    
    override func viewDidLayoutSubviews() {
        let contentHeight = tableView.contentSize
        tableView.snp.updateConstraints { (make) in
            make.height.equalTo(contentHeight)
        }
    }
    
    // MARK: - Private methods
    
    @objc private func didTapPopButton() {
        rootSheet?.pop()
    }
}

extension PickerSheet: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PickerCell()
        cell.update(with: choices[indexPath.row])
        return cell
    }
}

final class PickerCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "Picker cell to repreesnt a choice"
    
    let label = UILabel()
    
    // MARK: - Initializers
    
    init() {
        super.init(style: .default, reuseIdentifier: PickerCell.identifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        label.text = "test"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.sizeToFit()
        
        backgroundColor = .clear
        
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(100)
            make.top.right.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func update(with data: String) {
        label.text = data
    }
}
