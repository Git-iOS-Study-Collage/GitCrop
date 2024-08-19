//
//  EditableImageView.swift
//  GitCrop
//
//  Created by cha on 8/19/24.
//

import UIKit
import SnapKit

class EditableImageView: UIView {
    
    private var zoomDelegate: ZoomableImageDelegate!
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 5.0
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.backgroundColor = .brown
        return scrollView
    }()
    
    public var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray // Placeholder color
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        print("셋업!!!")
        self.backgroundColor = .black
        
        self.isUserInteractionEnabled = true
        
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        zoomDelegate = ZoomableImageDelegate(imageView: imageView)
        scrollView.delegate = zoomDelegate
    }
    
    public func setImage(_ image: UIImage?) {
        print("이미지 사이즈 \(image?.size)")
        imageView.image = image
    }
    
    public func setTappedEvent(target: Any?, action: Selector?) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tapGesture)
    }
}
