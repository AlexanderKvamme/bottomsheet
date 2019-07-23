//
//  ModulesDataSourceAndDelegate.swift
//  BottomSheet
//
//  Created by Amia Macone on 22/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class ModulesDataSourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    private var moduleModels: [ModuleModel]

    // MARK: - Initializers
    
    override init() {
        let dummytext = "Kort tekst om denne partikulære delen av appen kommer her."
        
        let detailedTestModel = ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Detailed Test", bodyText: dummytext)
        let settingsModel =     ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Settings Test", bodyText: dummytext)
        let module3 =           ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Third module", bodyText: dummytext)
        let module4 =           ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Fourth module", bodyText: dummytext)
        let module5 =           ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Fifth module", bodyText: dummytext)
        moduleModels = [detailedTestModel, settingsModel, module3, module4, module5]
    }
    
    // MARK: - Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ModuleCell()
        cell.update(withModel: moduleModels[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moduleModels.count
    }
}

