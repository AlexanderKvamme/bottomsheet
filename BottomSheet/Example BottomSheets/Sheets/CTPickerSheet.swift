//
//  PickerSheet.swift
//  Pods-BottomSheet
//
//  Created by Amia Macone on 13/06/2019.
//

import Foundation
import UIKit


final class CTPickerSheet: BottomSheet {
    
    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let tableView = UITableView()
    private var choices: [String]
    
    weak var rootSheet: BottomSheetViewController!
    
    // MARK: - Initializers
    
    init(_ string: String, choices: [String], delegate: BottomSheetViewController) {
        headerLabel.text = string
        self.choices = choices
        rootSheet = delegate
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    
    override func viewDidLayoutSubviews() {
        let contentHeight = tableView.contentSize
        tableView.snp.updateConstraints { (make) in
            make.height.equalTo(contentHeight)
        }
    }
    
    // MARK: - Methods
    
    private func setup() {
        view.backgroundColor = UIColor.solarstein.sapphire
        
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 32)
        headerLabel.textAlignment = .center
        
        // setup tableview
        tableView.register(PickerCell.self, forCellReuseIdentifier: PickerCell.identifier)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.separatorStyle = .none
    }

    // MARK: - Private methods
    
    private func addSubviewsAndConstraints() {
        addHorizontalDragIndicator()
    
        // Layout header
        view.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        // layout
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom).offset(24)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-48)
            make.height.equalTo(777) // to make it updatable after contentView size is updated
        }
        
        view.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width)
        }

        tableView.reloadData()
        view.layoutIfNeeded()
    }
}

extension CTPickerSheet: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PickerCell()
        cell.update(with: choices[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newSheet = CTPickerBottomSheet(choices[indexPath.row], delegate: rootSheet)
        rootSheet?.push(newSheet)
    }
}

