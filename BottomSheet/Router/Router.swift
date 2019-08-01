//
//  Router.swift
//  BottomSheet
//
//  Created by Amia Macone on 24/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


protocol Router: NSObject {
    
    // present methods
    func present(_ module: UIViewController?)
    func present(_ module: UIViewController?, animated: Bool)
    
    // Push methods
    func push(_ module: UIViewController?)
    func push(_ module: UIViewController?, hideBottomBar: Bool)
    func push(_ module: UIViewController?, animated: Bool)
    func push(_ module: UIViewController?, animated: Bool, completion: (() -> Void)?)
    func push(_ module: UIViewController?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?)
    
    // Pop methods
    func popModule()
    func popModule(animated: Bool)
    
    // Dismiss methods
    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    
    // Root Module methods
    func setRootModule(_ module: UIViewController?)
    func setRootModule(_ module: UIViewController?, hideBar: Bool)
    
    func popToRootModule(animated: Bool)
}
