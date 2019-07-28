//
//  SImagePreview.swift
//  BottomSheet
//
//  Created by Amia Macone on 19/07/2019.
//  Copyright © 2019 Simon Kågedal Reimer. All rights reserved.
//

import Foundation
import UIKit


/// Modified version
class SImagePreview: UIView {
    
    // MARK: - Properties
    
    private var image: UIImage
    private var imageView: UIImageView = UIImageView()
    private var scrollView: UIScrollView = UIScrollView()
    private var originalCellFrame: CGRect
    let coloredOverlay = UIView()
    
    private var isAnimating = false
    
    // MARK: - Initializers
    
    init(for image: UIImage, from cellOriginFrame: CGRect) {
        self.image = image
        self.originalCellFrame = cellOriginFrame
        
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setup() {
        backgroundColor = .clear
        setupScrollView()
        setupImageView()
        setupOverlay()
        
        addSubviewsAndConstraints()
    }
    
    private func setupImageView() {
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        imageView = UIImageView(frame: rect)
        imageView.backgroundColor = .clear
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        scrollView.addSubview(imageView)
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView(frame: .zero)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        scrollView.backgroundColor = .clear

        if Device.hasTopNotch {
            scrollView.contentInset = UIEdgeInsets(top: -50, left: 0, bottom: 0, right: 0)
        }
    }
    
    private func setupOverlay() {
        coloredOverlay.backgroundColor = UIColor.solarstein.sapphire
        coloredOverlay.alpha = 0.4
        coloredOverlay.isUserInteractionEnabled = false
    }
    
    private func addSubviewsAndConstraints() {
        [scrollView, coloredOverlay].forEach({ addSubview($0) })
        
        scrollView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        
        coloredOverlay.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func dismissView() {
        print("would dismiss SImagePreview")
    }
}

// MARK: - UIScrollViewDelegate conformence

extension SImagePreview: UIScrollViewDelegate {
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale < 0.65 {
            scrollView.isScrollEnabled = false
            dismissView()
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
