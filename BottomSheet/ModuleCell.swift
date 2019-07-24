//
//  ModuleCell.swift
//  BottomSheet
//
//  Created by Amia Macone on 23/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class ModuleCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MainMenuModuleCell"
    
    private let moduleCellView = ModuleCellView()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addSubviewsAndConstraints() {
        contentView.addSubview(moduleCellView)
        moduleCellView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(moduleCellView)
        }
    }
    
    // MARK: - Internal Methods
    
    func update(withModel model: ModuleModel) {
        moduleCellView.update(withModel: model)
    }
}

