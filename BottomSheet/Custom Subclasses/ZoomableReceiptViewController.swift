//
//  DummyReceiptViewController.swift
//  BottomSheet
//
//  Created by Amia Macone on 18/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


class ZoomableReceiptViewController: UIViewController {
    
    // MARK: - Properties
    
    let imagePreview = SImagePreview(for: UIImage.init(named: "receiptExample")!, from: CGRect.zero)
    
    weak var delegate: hasBackgroundTapHandler?
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(imagePreview)
        imagePreview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMainView))
        imagePreview.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    @objc private func didTapMainView() {
        delegate?.backgroundSheetWasTapped()
    }
}

// MARK: - SheetScrollResponder Conformance

extension ZoomableReceiptViewController: SheetScrollResponder {
    func bottomsheetDidScrollTo(_ value: CGPoint) {
        let percentage = (value.y * -1)/768
        imagePreview.coloredOverlay.alpha = 1-percentage
    }
}

