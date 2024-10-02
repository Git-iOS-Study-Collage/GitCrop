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
    var contentView = UIView()
    var backgroundImageView = UIImageView()
    var stackView = UIStackView()
    
    var imageViewList: [EditableImageView] = []
    var selectMode = false
    var selectCount = 0
    var maxCount = 0 // 사진 최대갯수 설정
    var delegate: ImageSelectDelegate?
    
    var backgroundImage: UIImage? {
        return backgroundImageView.image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        insertUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        insertUI()
    }
    
    func insertUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(stackView)
    }
    
    /// 이미지 뷰 선택 시 활성화 TapGesture
    @objc func imageViewTapped(_ gesture: UITapGestureRecognizer) {
        guard let imageView = gesture.view else { return }
        
        selectMode = true
        selectCount = imageView.tag
        imageViewList.forEach {
            $0.layer.borderWidth = 0
        }
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.black.cgColor
        
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
        imageView.backgroundColor = .cyan // Placeholder color
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }
    
    func setBackgroundImage(type: BackGroundImageType) {
        backgroundImageView.image = type.image
    }
}
