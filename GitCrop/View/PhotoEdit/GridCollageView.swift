//
//  GridCollageView.swift
//  GitCrop
//
//  Created by dev dfcc on 8/2/24.
//

import UIKit

/// 창문형 콜라주 화면

class GridCollageView: CollageView {
    
    private let mainStackView = UIStackView()
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        inserrUI()
        basicSetUI()
        anchorUI()
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }
    
    func inserrUI() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    func basicSetUI() {
        viewBasicSet()
        scrollViewBasicSet()
        stackViewBasicSet()
    }
    
    func anchorUI() {
        scrollViewAnchor()
        stackViewAnchor()
    }
    
    func viewBasicSet() {
        backgroundColor = .clear
    }
    
    func scrollViewBasicSet() {
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.backgroundColor = .clear
        scrollView.isScrollEnabled = true
    }
    
    func stackViewBasicSet() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.backgroundColor = .clear
    }
    
    func scrollViewAnchor() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func stackViewAnchor() {
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.height.equalTo(frame.width)
        }
    }
    
    func setupStackView() {
        for i in 0..<2 {
            let horizontalStackView = UIStackView()
            horizontalStackView.axis = .horizontal
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.spacing = 1
            
            for j in 0..<2 {
                let imageView = makeImageView()
                
                if i == 0 {
                    imageView.tag = i
                } else {
                    imageView.tag = i+j+1
                }
                imageViewList.append(imageView)
                horizontalStackView.addArrangedSubview(imageView)
            }
            stackView.addArrangedSubview(horizontalStackView)
        }
        
    }
}
