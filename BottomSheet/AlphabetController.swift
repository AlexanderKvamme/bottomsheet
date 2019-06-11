//
//  TestViewController.swift
//  BottomSheet
//
//  Created by Amia Macone on 11/06/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


protocol SheetPageController: class {
    func didTapNext()
}

protocol hasRoundedTopCorners {
    func roundTopCorners()
}

extension hasRoundedTopCorners where Self: UIViewController {
    func roundTopCorners() {
        view.roundCorners(corners: [.topLeft, .topRight])
    }
}


final class AlphabetController: UIPageViewController, SheetPageController, isSelfSizeable, hasRoundedTopCorners {
    
    // MARK: - Properties
    
    var currentNumber = 0
    
    // MARK: - Initializers
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.solarstein.sapphire
        roundTopCorners()
        setSize(2000)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // add first letter
        let lvca = LetterViewController(String(currentNumber), delegate: self)
        setViewControllers([lvca], direction: .forward, animated: false, completion: nil)
    }
    
    // MARK: - Methods
    
    func didTapNext() {
        print("did tap button")
        currentNumber += 1
        let lvca = LetterViewController(String(currentNumber), delegate: self)
        setViewControllers([lvca], direction: .forward, animated: true, completion: nil)
    }
}

//extension AlphabetController: UIPageViewControllerDataSource {
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        return nil
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        return nil
//    }
//}
