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
    private var xButton = SShadowButton()
    
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
        setupXButton()
        
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
    }
    
    private func setupXButton() {
        xButton.setImage(UIImage(named: "x-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        xButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        xButton.tintColor = .white
    }
    
    private func addSubviewsAndConstraints() {
        [scrollView, xButton].forEach({ addSubview($0) })
        
        scrollView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        
        xButton.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(16)
            make.left.equalTo(safeAreaLayoutGuide.snp.leftMargin).offset(32+Device.additionalInsetsIfNotched)
            make.height.width.equalTo(48)
        }
    }
    
    @objc private func dismissView() {
        print("would dismiss")
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
