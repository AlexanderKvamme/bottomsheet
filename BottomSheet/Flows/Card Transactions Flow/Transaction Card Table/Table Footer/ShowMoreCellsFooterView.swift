//
//  ShowMoreCellsFooterView.swift
//  BottomSheet
//
//  Created by Amia Macone on 31/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit

final class ShowMoreCellsFooterView: UIView {
    
    // MARK: - Properties
    
    static let estimatedSize = CGSize(width: UIScreen.main.bounds.width, height: 40)
    
    private let showMoreView = ShowMoreBadge()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func addSubviewsAndConstraints() {
        addSubview(showMoreView)
        showMoreView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-32)
            make.centerY.equalToSuperview()
            make.size.equalTo(ShowMoreBadge.estimatedSize)
        }
    }
}
