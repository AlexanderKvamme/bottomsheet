//
//  File.swift
//  BottomSheet
//
//  Created by Amia Macone on 24/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


/// This shadow adds a shadow just below the view. This way the ShadowView can be positioned
/// with the same layout as the view its providing shadow for
final class ShadowView: UIView {

    // MARK: - Properties
    
    private let opacity: Float
    
    // MARK: - Initializers
    
    init(opacity: Float = 0.03) {
        self.opacity = opacity
        super.init(frame: .zero)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addShadowSameSizeAsView()
    }
    
    // MARK: - Methods
    
    private func addShadowSameSizeAsView() {
        let contactRect = CGRect(x: 0, y: 50, width: frame.width, height: frame.height)
        layer.shadowPath = UIBezierPath(rect: contactRect).cgPath
        layer.shadowColor = UIColor.solarstein.sapphire.cgColor
        layer.shadowRadius = 30
        layer.shadowOpacity = opacity
    }
}

