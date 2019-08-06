//
//  BottomSheetContainerView.swift
//  BottomSheet
//
//  Created by Amia Macone on 18/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


class BottomSheetContainerView: UIView {
    
    private let mainView: UIView
    private let sheetView: UIView
    private let sheetBackground = BottomSheetBackgroundView()
    private var sheetBackgroundTopConstraint: Constraint? = nil
    
    init(mainView: UIView, sheetView: UIView) {
        self.mainView = mainView
        self.sheetView = sheetView
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    var topDistance: CGFloat = 0 {
        didSet {
            sheetBackgroundTopConstraint?.layoutConstraints[0].constant = topDistance
        }
    }
    
    private func setupViews() {
        // The main view fills the view completely
        addSubview(mainView)
        
        mainView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        // The sheet background
        addSubview(sheetBackground)
        sheetBackground.snp.makeConstraints { (make) in
            self.sheetBackgroundTopConstraint = make.top.equalTo(safeAreaLayoutGuide.snp.top).constraint
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        sheetBackground.backgroundColor = UIColor.solarstein.sapphire
        
        // The sheet table view goes all the way up to the status bar
        addSubview(sheetView)
        
        sheetView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - UIView overrides
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if sheetBackground.bounds.contains(sheetBackground.convert(point, from: self)) {
            return sheetView.hitTest(sheetView.convert(point, from: self), with: event)
        }
        return mainView.hitTest(mainView.convert(point, from: self), with: event)
    }
}