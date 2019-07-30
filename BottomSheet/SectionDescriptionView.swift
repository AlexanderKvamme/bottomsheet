//
//  SectionDescriptionView.swift
//  BottomSheet
//
//  Created by Amia Macone on 29/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit
import ScrollingStackContainer

extension SectionDescriptionViewController: StackContainable {
    func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
        return ScrollingStackController.ItemAppearance.view(height: 120)
    }
}

final class SectionDescriptionViewController: UIViewController {
    
    // MARK: - Properties
    
    let descriptionView: SectionDescriptionView
    
    // MARK: - Initializers
    
    init(descriptionView: SectionDescriptionView) {
        self.descriptionView = descriptionView
        
        super.init(nibName: nil, bundle: nil)

        view.addSubview(descriptionView)
        descriptionView.snp.makeConstraints { (make) in
            make.top.right.left.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


final class SectionDescriptionView: UIView {
    
    // MARK: - Properties
    
    private let headerLabel = UILabel()
    private let subheaderLabel = UITextView()
    private var coloredBadge: ColoredBadge?
    
    // MARK: - Initializers
    
    init(header: String, description: String) {
        self.headerLabel.text = header
        self.subheaderLabel.text = description
        
        super.init(frame: .zero)
        
        setup()
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        setupLabels()
    }
    
    private func addSubviewsAndConstraints() {
        [headerLabel, subheaderLabel].forEach({ addSubview($0) })

        let horizontalInset: CGFloat = 48
        headerLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().priority(750)
            make.left.equalToSuperview().offset(horizontalInset).priority(750)
        }
        
        subheaderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerLabel).offset(-4).priority(750)
            make.right.equalToSuperview().offset(-horizontalInset).priority(750)
            make.top.equalTo(headerLabel.snp.bottom)
            make.height.equalTo(60)
        }
    }
    
    private func setupLabels() {
        headerLabel.textColor = UIColor.solarstein.sapphire
        headerLabel.font = UIFont.kolibrix.subheader
        headerLabel.sizeToFit()
        
        subheaderLabel.textColor = UIColor.solarstein.sapphire
        subheaderLabel.alpha = 0.3
        subheaderLabel.font = UIFont.kolibrix.body
    }
    
    // MARK: Internal methods
    
    func setBadgeNumber(_ number: Int?) {
        guard let number = number else {
            coloredBadge?.removeFromSuperview()
            return
        }
        
        coloredBadge = ColoredBadge()
        coloredBadge!.setBadge(number: number)

        addSubview(coloredBadge!)
        coloredBadge!.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalTo(50)
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(headerLabel.snp.right).offset(8)
        }
    }
}

