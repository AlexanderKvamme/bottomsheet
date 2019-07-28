//
//  ModuleModel.swift
//  BottomSheet
//
//  Created by Amia Macone on 22/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


struct ModuleModel {
    var icon: UIImage
    var headerText: String
    var bodyText: String
    
    var didTapCell: ( () -> () )?
    
    // MARK: - Initializers
    
//    init(type: ModuleType) {
//        switch type {
//        case .detailedTransaction:
//            icon = UIImage.init(named: "x-icon")!
//            headerText = "Korttransaksjoner"
//            bodyText = makeDummyText()
//            didTapCell = makeTapHandler(for: type)
//        default:
//            icon = UIImage.init(named: "x-icon")!
//            headerText = "tets"
//            bodyText = makeDummyText()
//            didTapCell = makeTapHandler(for: type)
//        }
//    }
    
    // MARK: - Methods
    
    private func makeDummyText() -> String {
        return "Kort tekst om denne partikulære delen av appen kommer her."
    }
    
    /*
     private lazy var detailedTestModel = ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Korttransaksjoner", bodyText: dummytext, moduleType: .DetailedTransaction, didTapCell: nil)
     private lazy var settingsModel =     ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Utlegg", bodyText: dummytext, didTapCell: nil)
     private lazy var module3 =           ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Lønnsslipper", bodyText: dummytext, didTapCell: nil)
     private lazy var module4 =           ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Timeregistrering", bodyText: dummytext, didTapCell: nil)
     private lazy var module5 =           ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Reiseregning", bodyText: dummytext, didTapCell: nil)
     */
}


//final class ModuleModelFactory {
//    
//    // MARK: - Properties
//    
//    // MARK: - Initializers
//    
//    // MARK: - Life Cycle
//    
//    // MARK: - Methods
//
//    func makeDetailedTransactionModuleModel() -> ModuleModel {
//        let model = ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Korttransaksjoner", bodyText: makeDummyText(), didTapCell: nil)
//        let detailedTapAction: ( () -> () ) = {
//            // Prøv å pushe en module
//            let coordinatorFactory = CoordinatorFactoryImp()
//            let detailedModule = coordinatorFactory.makeDetailedTransactionCoordinator(router: self.router)
//            // TODO: - Remove dependency on pop
//            self.baseCoordinator.addDependency(detailedModule)
//            detailedModule.start()
//        }
//        model.didTapCell = detailedTapAction
//        return model
//    }
//    func makeDummy() -> ModuleModel {
//        return ModuleModel(icon: UIImage.init(named: "x-icon")!, headerText: "Lønnsslipper", bodyText: makeDummyText(), didTapCell: nil)
//    }
//    
//    private func makeDummyText() -> String {
//        return "Kort tekst om denne partikulære delen av appen kommer her."
//    }
//}
