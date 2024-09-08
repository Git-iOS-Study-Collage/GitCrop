//
//  GridCollageView.swift
//  GitCrop
//
//  Created by dev dfcc on 8/2/24.
//

import UIKit
import SnapKit

/// 창문형 콜라주 화면

class GridCollageView: CollageView {
    
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
        setupStackView()
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
        stackView.spacing = 1
        stackView.alignment = .center

        stackView.backgroundColor = .clear
    }
    
    func scrollViewAnchor() {
        scrollView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().inset(50)
        }
    }
    
    func backgroundImageViewAnchor() {
        backgroundImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width).multipliedBy(1)
        }
    }

    func stackViewAnchor() {
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.height.equalTo(frame.width)
        }
    }
    

    /// 창문형 배경 이미지 뷰 추가 작업
    func setupStackView() {
        for i in 0..<2 {
            let containerView = UIView()
            containerView.backgroundColor = .clear
            
            let horizontalStackView = UIStackView()
            horizontalStackView.axis = .horizontal
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.spacing = 1
            horizontalStackView.backgroundColor = .clear
            stackView.addArrangedSubview(horizontalStackView)

            for j in 0..<2 {
                let editableImageView = EditableImageView()
                editableImageView.setTappedEvent(target: self, action: #selector(imageViewTapped))
                
                if i == 0 {
                    editableImageView.tag = i
                } else {
                    editableImageView.tag = i+j+1
                }
                imageViewList.append(editableImageView)
                
                let container = UIView()
                container.backgroundColor = .clear
                container.addSubview(editableImageView)
                
                
                // container를 horizontalStackView에 추가
                horizontalStackView.addArrangedSubview(container)
                
                container.snp.makeConstraints {
                    $0.width.height.equalTo(snp.width).multipliedBy(0.5)
                }
                
                editableImageView.snp.makeConstraints {
                    $0.top.equalTo(10)
                    $0.leading.equalTo(10)
                    $0.trailing.equalTo(-10)
                    $0.bottom.equalTo(-10)
                }
            }
        }
        
    }
}
