//
//  VerticalCollageView.swift
//  GitCrop
//
//  Created by dev dfcc on 8/2/24.
//

import UIKit
import SnapKit

/// 인생네컷 화면 

class VerticalCollageView: CollageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        inserrUI()
        basicSetUI()
        anchorUI()
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
       
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
            $0.centerX.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width).multipliedBy(0.5)
        }
    }
        
    func setupStackView() {
        for i in 0..<4 {
            let editableImageView = EditableImageView()
            editableImageView.setTappedEvent(target: self, action: #selector(imageViewTapped))
            editableImageView.tag = i
            stackView.addArrangedSubview(editableImageView)
            imageViewList.append(editableImageView)
            editableImageView.snp.makeConstraints {
                $0.width.height.equalTo(self.snp.width).multipliedBy(0.5)
            }
        }
    }
}
