//
//  ModulesDataSourceAndDelegate.swift
//  BottomSheet
//
//  Created by Amia Macone on 22/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


class DetailedTransactionCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    
    private var router: Router
    private var factory: DetailedTransactionFactory
    
    // MARK: - Initializers
    
    init(router: Router, factory: DetailedTransactionFactory) {
        self.router = router
        self.factory = factory
    }
    
    // MARK: - Methods
    
    override func start() {
        let detailedTransactionModule = factory.makeDetailedTransactionModule()
        detailedTransactionModule.onFinish = { [weak self] in
            self?.router.popModule()
        }
        
        router.push(detailedTransactionModule.toPresent())
    }
}


final class ModulesDataSourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    let dummytext = "Kort tekst om denne partikulære delen av appen kommer her."
    private lazy var detailedTransactionModel = ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Korttransaksjoner", bodyText: dummytext, didTapCell: nil)
    private lazy var settingsModel =     ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Utlegg", bodyText: dummytext, didTapCell: nil)
    private lazy var module3 =           ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Lønnsslipper", bodyText: dummytext, didTapCell: nil)
    private lazy var module4 =           ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Timeregistrering", bodyText: dummytext, didTapCell: nil)
    private lazy var module5 =           ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Reiseregning", bodyText: dummytext, didTapCell: nil)
    private lazy var moduleModels = [detailedTransactionModel, settingsModel, module3, module4, module5]
    private var router: Router
    private var baseCoordinator =  BaseCoordinator()

    // MARK: - Initializers
    
    init(router: Router) {
        self.router = router
        super.init()
        addTapTargets()
    }
    
    func addTapTargets() {
        detailedTransactionModel.didTapCell = {
            let coordinatorFactory = CoordinatorFactoryImp()
            let detailedModule = coordinatorFactory.makeDetailedTransactionCoordinator(router: self.router)
            // TODO: - Remove dependency on pop
            self.baseCoordinator.addDependency(detailedModule)
            detailedModule.start()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moduleModels[indexPath.row].didTapCell?()
    }
}

