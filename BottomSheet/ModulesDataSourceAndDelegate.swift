//
//  ModulesDataSourceAndDelegate.swift
//  BottomSheet
//
//  Created by Amia Macone on 22/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


class DetailedTransactionCoordinator: Coordinator {
    
    // MARK: - Properties
    
    // MARK: - Initializers
    
    // MARK: - Life Cycle
    
    // MARK: - Methods
    
    func start() {
        print("would start DetailedTransactionCoordinator")
    }
}


final class ModulesDataSourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    private var moduleModels: [ModuleModel]
    private var router: Router

    // MARK: - Initializers
    
    init(router: Router) {
        self.router = router
        
        let dummytext = "Kort tekst om denne partikulære delen av appen kommer her."
        
        let detailedTapAction: ( () -> () ) = {
            print("did tap the cell")
            
            // Prøv å pushe en module
            let coordinatorFactory = CoordinatorFactoryImp()
            let detailedModule = coordinatorFactory.makeDetailedTransactionCoordinator()
            router.push(detailedModule.toPresent)
            detailedModule.coordinator.start()
            
            
            // FIXME: May have to use router?
//            let coordinator = 
            
            // Slik ble det gjort i appDelegate sist gang jeg brukte shhet
            
            //        let zoomableReceiptViewController = ZoomableReceiptViewController()
            //        let rootSheet = MatchfinderRootSheet(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            //        let bottomSheetContainer = ScrollableBottomSheetContainer(rootSheet)
            //        window.rootViewController = BottomSheetContainerViewController(mainViewController: zoomableReceiptViewController, sheetViewController: bottomSheetContainer)
        }
        
        let detailedTestModel = ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Korttransaksjoner", bodyText: dummytext, didTapCell: detailedTapAction)
        let settingsModel =     ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Utlegg", bodyText: dummytext, didTapCell: nil)
        let module3 =           ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Lønnsslipper", bodyText: dummytext, didTapCell: nil)
        let module4 =           ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Timeregistrering", bodyText: dummytext, didTapCell: nil)
        let module5 =           ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Reiseregning", bodyText: dummytext, didTapCell: nil)
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("bam selected: ", indexPath)
        moduleModels[indexPath.row].didTapCell?()
    }
}

