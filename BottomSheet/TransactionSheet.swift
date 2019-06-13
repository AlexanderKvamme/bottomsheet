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
    func updateSize(_ value: CGFloat) -> Void
}

extension isSelfSizeable where Self: UIViewController {
    func setSize(_ value: CGFloat) {
        print("gonna set size to ", value)
        view.snp.makeConstraints{ (make) in
            make.height.equalTo(value)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
    }
    
    func updateSize(_ value: CGFloat) {
        print("gonna update size to ", value)
        view.snp.updateConstraints{ (make) in
            make.height.equalTo(value)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
    }
}


typealias RootSheetController = UIPageViewController & RootSheet
    
final class TransactionSheet: UIViewController, isSelfSizeable {
    
    // MARK: - Properties
    
    static let preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 500)
    
    private let headerLabel = UILabel()
    private let bottomRightButton = KRoundButton()
    private let bottomLeftButton = KRoundButton()
    
    weak var sheetPageController: RootSheetController?
    
    // MARK: - Initializers
    
    init(_ string: String, delegate: RootSheetController) {
        headerLabel.text = string
        sheetPageController = delegate
        
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.solarstein.sapphire
        
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 32)
        headerLabel.textAlignment = .center

        bottomLeftButton.setTitle("Mer", for: .normal)
        bottomLeftButton.setup(with: UIColor.solarstein.mariner.withAlphaComponent(0.05))
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
        view.addSubview(bottomRightButton)
        
        let sideSpacing: CGFloat = 24
        let interButtonSpacing: CGFloat = 24
        let avaiableButtonSpace = UIScreen.main.bounds.width - 2 * sideSpacing - interButtonSpacing
        let rightButtonSize = avaiableButtonSpace*0.7
        let leftButtonSize = avaiableButtonSpace-rightButtonSize
        
        bottomLeftButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-sideSpacing)
            make.left.equalToSuperview().offset(sideSpacing)
            make.height.equalTo(40)
            make.width.equalTo(leftButtonSize)
        }
        
        bottomRightButton.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().offset(-24)
            make.height.equalTo(40)
            make.width.equalTo(rightButtonSize)
        }
        
        view.snp.makeConstraints { (make) in
            make.height.equalTo(501)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
    }
    
    // MARK: - Methods
    
    @objc func didTapNextButton() {
        sheetPageController?.didTapNext()
    }
    
    @objc func didTapMoreButton() {
        let menuSheet = TransactionMenuSheet("Menu", delegate: sheetPageController!)
        sheetPageController!.push(menuSheet)
    }
}


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
