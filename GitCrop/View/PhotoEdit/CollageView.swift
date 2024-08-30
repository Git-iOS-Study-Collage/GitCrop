//
//  CollageView.swift
//  GitCrop
//
//  Created by ByungHoon Ann on 8/4/24.
//

import UIKit

/// 콜라주할 이미지 출력 화면
protocol ImageSelectDelegate {
    func imageTapped()
}

class CollageView: UIView {
    var scrollView = UIScrollView()
    var stackView = UIStackView()
    var imageViewList: [EditableImageView] = []
    var selectMode = false
    var selectCount = 0
    
    var delegate: ImageSelectDelegate?
    
    /// 이미지 뷰 선택 시 활성화 TapGesture
    @objc func imageViewTapped(_ gesture: UITapGestureRecognizer) {
        guard let imageView = gesture.view else { return }
        
        selectMode = true
        selectCount = imageView.tag
        imageViewList.forEach {
            $0.layer.borderWidth = 0
        }
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.red.cgColor
        
        delegate?.imageTapped()
    }
    
    func clear() {
        selectCount = 0
        selectMode = false
        imageViewList.forEach {
            $0.layer.borderWidth = 0
        }
    }
    
    /// 사진 넣기
    func setImage(_ image: UIImage?, for number: Int) {
        if selectMode == true {
            imageViewList[selectCount].setImage(image)
            clear()
        } else {
            imageViewList[number].setImage(image)
        }
    }
    
    /// 이미지 뷰 만들기
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray // Placeholder color
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }
}
