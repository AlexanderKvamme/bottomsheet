//
//  RounterImp.swift
//  BottomSheet
//
//  Created by Amia Macone on 24/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


final class RouterImp: NSObject, Router {
    
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    
    // MARK: Initializers
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }
    
    // MARK: Presentation
    
    func present(_ module: UIViewController?) {
        present(module, animated: true)
    }
    
    func present(_ module: UIViewController?, animated: Bool) {
        guard let controller = module else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    // MARK: Dismissal
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    // MARK:  Push
    
    // FIXME: Kan forenkles
    
    func push(_ module: UIViewController?)  {
        push(module, animated: true)
    }
    
    func push(_ module: UIViewController?, animated: Bool)  {
        push(module, animated: animated, completion: nil)
    }
    
    func push(_ module: UIViewController?, hideBottomBar: Bool)  {
        push(module, animated: true, hideBottomBar: hideBottomBar, completion: nil)
    }
    
    func push(_ module: UIViewController?, animated: Bool, completion: (() -> Void)?) {
        push(module, animated: animated, hideBottomBar: false, completion: completion)
    }
    
    func push(_ module: UIViewController?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?) {
        guard
            let controller = module,
            (controller is UINavigationController == false)
            else { assertionFailure("Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            completions[controller] = completion
        }
        controller.hidesBottomBarWhenPushed = hideBottomBar
        rootController?.pushViewController(controller, animated: animated)
    }
    
    // MARK: Pop
    
    func popModule()  {
        popModule(animated: true)
    }
    
    func popModule(animated: Bool)  {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    // MARK: Setters
    
    func setRootModule(_ module: UIViewController?) {
        setRootModule(module, hideBar: false)
    }
    
    func setRootModule(_ module: UIViewController?, hideBar: Bool) {
        guard let controller = module else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    // MARK: Pop to root
    
    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}
