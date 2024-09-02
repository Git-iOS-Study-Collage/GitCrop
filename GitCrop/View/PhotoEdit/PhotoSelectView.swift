//
//  PhotoSelectView.swift
//  GitCrop
//
//  Created by dev dfcc on 8/2/24.
//

import UIKit

/// 콜라주 화면 스크롤 Container 화면

final class PhotoSelectView: UIView {
    private lazy var imageView = UIImageView()
    private lazy var scrollView = UIScrollView()
    
    init() {
        super.init(frame: .zero)
        insertUI()
        basicSetUI()
        anchorUI()
        bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func insertUI() {
        [
            scrollView
        ]
            .forEach {
                addSubview($0)
            }
        scrollView.addSubview(imageView)
    }
    
    func basicSetUI() {
        viewBasicSet()
        scrollViewBasicSet()
        imageViewBasicSet()
    }
    
    func anchorUI() {
        scrollViewAnchor()
        imageViewBasicSet()
    }
    
    func bindUI() {
        
    }
    
    
    func viewBasicSet() {
        
    }

    func imageViewBasicSet() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .blue
    }
    
    func scrollViewBasicSet() {
        scrollView.backgroundColor = .black
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
    }
    
    func imageViewAnchor() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func scrollViewAnchor() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension PhotoSelectView: UIScrollViewDelegate {
    
}





