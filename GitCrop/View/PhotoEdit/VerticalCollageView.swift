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
        insertUI()
        basicSetUI()
        anchorUI()
        setupStackView()
        
        maxCount = 4
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
       
    }
 
    func insertUI() {
        addSubview(scrollView)
        scrollView.addSubview(backgroundImageView)
        scrollView.addSubview(stackView)
    }
    
    func basicSetUI() {
        viewBasicSet()
        scrollViewBasicSet()
        backgroundImageViewBasicSet()
        stackViewBasicSet()
    }
    
    func anchorUI() {
        scrollViewAnchor()
        backgroundImageViewAnchor()
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
    
    func backgroundImageViewBasicSet() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.backgroundColor = .blue
        backgroundImageView.clipsToBounds = true
        backgroundImageView.image = BackGroundImageType.checkBackground.image
    }
    
    func stackViewBasicSet() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 1
        stackView.backgroundColor = .clear
    }
    
    func scrollViewAnchor() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func backgroundImageViewAnchor() {
        backgroundImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width).multipliedBy(0.5)
        }
    }

    func stackViewAnchor() {
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width).multipliedBy(0.5)
        }
    }
        
    /// 백그라운드 이미지 표시를 위한 추가 작업
    func setupStackView() {
        for i in 0..<4 {
            let containerView = UIView()
            containerView.backgroundColor = .clear
            
            let editableImageView = EditableImageView()
            editableImageView.setTappedEvent(target: self, action: #selector(imageViewTapped))
            editableImageView.tag = i
            
            containerView.addSubview(editableImageView)
            stackView.addArrangedSubview(containerView)
            
            imageViewList.append(editableImageView)
            
            containerView.snp.makeConstraints {
                $0.width.height.equalTo(snp.width).multipliedBy(0.5)
            }
            
            editableImageView.snp.makeConstraints {
                
                $0.top.equalTo(10)
                $0.leading.equalTo(15)
                $0.trailing.equalTo(-15)
                $0.bottom.equalTo(-10)
                //$0.width.height.equalTo(self.snp.width).multipliedBy(0.45)
            }
        }
    }
}
