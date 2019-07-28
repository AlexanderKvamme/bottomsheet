//
//  MainMenuTableView.swift
//  BottomSheet
//
//  Created by Amia Macone on 22/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class ModulesTableView: UITableView {
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero, style: .grouped)
        
        separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


