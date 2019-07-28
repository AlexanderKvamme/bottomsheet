//
//  Router.swift
//  BottomSheet
//
//  Created by Amia Macone on 24/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation


protocol Router: Presentable {
    
    // present methods
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    
    // Push methods
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, hideBottomBar: Bool)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)
    func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?)
    
    // Pop methods
    func popModule()
    func popModule(animated: Bool)
    
    // Dismiss methods
    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    
    // Root Module methods
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    
    func popToRootModule(animated: Bool)
}
