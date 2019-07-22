//
//  ModuleCell.swift
//  Pods-BottomSheet
//
//  Created by Amia Macone on 22/07/2019.
//

import Foundation
import UIKit
import SnapKit


final class ModuleCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MainMenuModuleCell"
    
    let moduleCellView = ModuleCellView()
    
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
    }
    
    private func addSubviewsAndConstraints() {
        contentView.addSubview(moduleCellView)
        moduleCellView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(moduleCellView)
        }
    }
    
    // MARK: - Internal Methods
    
    func update(withModel model: ModuleModel) {
        moduleCellView.update(withModel: model)
    }
}

