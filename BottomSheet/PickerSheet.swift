//
//  PickerSheet.swift
//  Pods-BottomSheet
//
//  Created by Amia Macone on 13/06/2019.
//

import Foundation
import UIKit


final class PickerSheet: UIViewController, isSelfSizeable {
    
    // MARK: - Properties
    
    static let preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 500)
    
    private let headerLabel = UILabel()
    private let tableView = UITableView()
    private var choices: [String] = ["Its like", "this", "and a", "that", "and a dis and a"]
    
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
        tableView.backgroundColor = .blue
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        
        // layout
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(popButton)
        popButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(60)
        }
        
        view.snp.makeConstraints { (make) in
            make.height.equalTo(400)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
    }
    
    //    override func viewDidLayoutSubviews() {
    //        print("vdls tableView.frame.size", tableView.frame.size)
    //        print("vdls tableView.contentSize", tableView.contentSize)
    //
    ////        tableView.frame.size = tableView.contentSize
    //        tableView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 900)
    //    }
    
    // MARK: - Private methods
    
    @objc private func didTapPopButton() {
        print("pop")
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
        
        label.text = "test"
        label.sizeToFit()
        contentView.backgroundColor = .yellow
        
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func update(with data: String) {
        label.text = data
    }
}
