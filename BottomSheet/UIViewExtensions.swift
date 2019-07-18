//
//  UIViewExtensions.swift
//  BottomSheet
//
//  Created by Amia Macone on 11/06/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit

private var defaultBottomSheetCornerRadios: CGFloat = 40 // iphone X corner radius

extension UIView {
    enum Corner:Int {
        case bottomRight = 0,
        topRight,
        bottomLeft,
        topLeft
    }
    
    private func parseCorner(corner: Corner) -> CACornerMask.Element {
        let corners: [CACornerMask.Element] = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        return corners[corner.rawValue]
    }
    
    private func createMask(corners: [Corner]) -> UInt {
        return corners.reduce(0, { (a, b) -> UInt in
            return a + parseCorner(corner: b).rawValue
        })
    }
    
    func roundCorners(corners: [Corner], amount: CGFloat = defaultBottomSheetCornerRadios) {
        layer.cornerRadius = amount
        let maskedCorners: CACornerMask = CACornerMask(rawValue: createMask(corners: corners))
        layer.maskedCorners = maskedCorners
    }
    
    // MARK: - Subtle shake animation
    
    @objc func shakeByX() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        let animation = CABasicAnimation(keyPath: "position")
        let distance: CGFloat = 3
        animation.duration = 0.04
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - distance, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + distance, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}
