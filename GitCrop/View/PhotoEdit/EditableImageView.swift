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
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 5.0
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.backgroundColor = .lightGray
        return scrollView
    }()
    
    public var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .brown // Placeholder color
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
        print("셋업!!! \nframe = \(self.frame) \nbounds = \(self.bounds)")
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    private func insertUI() {
        addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
    
    private func basicSetUI() {
        viewBasicSet()
        scrollViewBasicSet()
    }
    
    private func anchorUI() {
        scrollViewAnchor()
    }
    
    private func viewBasicSet() {
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.setDoubleTapEvent()
    }
    
    private func scrollViewBasicSet() {
        zoomDelegate = ZoomableImageDelegate(imageView: imageView)
        scrollView.delegate = zoomDelegate
    }
    
    private func scrollViewAnchor() {
        // ImageView의 크기는 UIImage크기에 따라 동적으로 처리할 것이므로 ScrollView 제약조건만 설정함
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // ImageView 크기를 스크롤뷰의 가로 or 세로 크기에 맞춰
    // 세로스크롤 or 가로스크롤 상태로 만들고 사진 중앙으로 스크롤
    public func setImage(_ image: UIImage?) {
        print("이미지 사이즈 \(String(describing: image?.size))")
        
        guard let image = image else {
            imageView.image = image
            return
        }
        
        // 가로세로 비율 계산
        let imageAspectRatio = image.aspectRatio
        
        if imageAspectRatio >= 1 {
            // 가로가 더 길 경우
            let scaleFactor = scrollView.bounds.height / image.size.height
            let scaledWidth = image.size.width * scaleFactor
            imageView.frame = CGRect(x: 0, y: 0, width: scaledWidth, height: scrollView.bounds.height)
        } else {
            // 세로가 더 길 경우
            let scaleFactor = scrollView.bounds.width / image.size.width
            let scaledHeight = image.size.height * scaleFactor
            imageView.frame = CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: scaledHeight)
        }
        
        scrollView.contentSize = imageView.bounds.size
        imageView.image = image
        
        // 동적으로 minimumZoomScale을 설정
        // 가로세로 중 큰 부분은 스크롤뷰의 크기보다 작아지지 않도록 minimum 설정
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageView.bounds.width
        let heightScale = scrollViewSize.height / imageView.bounds.height
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        
        scrollView.scrollToCenter(animated: false)
    }
    
    public func setTappedEvent(target: Any?, action: Selector?) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tapGesture)
    }
    
    // 더블탭 시 이미지 크기를 스크롤뷰에 딱 맞게 꽉 차도록 설정(이미지 선택 초기상태와 동일)
    private func setDoubleTapEvent() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTapGesture)
    }
    
    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        scrollView.zoomScale = 1
    }
}

extension UIImage {
    var aspectRatio: Double {
        self.size.width / self.size.height
    }
    
    var isHorizontal: Bool {
        self.aspectRatio >= 1
    }
}

extension UIScrollView {
    func scrollToCenter(animated: Bool = true) {
        let contentSize = self.contentSize
        let scrollViewSize = self.bounds.size
        
        let centerOffsetX = (contentSize.width - scrollViewSize.width) / 2
        let centerOffsetY = (contentSize.height - scrollViewSize.height) / 2
        
        // offset 값을 넘어서 스크롤 되지 않도록 처리
        let maxOffsetX = contentSize.width - scrollViewSize.width
        let maxOffsetY = contentSize.height - scrollViewSize.height
        
        let offsetX = max(0, min(centerOffsetX, maxOffsetX))
        let offsetY = max(0, min(centerOffsetY, maxOffsetY))
        
        let newOffset = CGPoint(x: offsetX, y: offsetY)
        self.setContentOffset(newOffset, animated: animated)
    }
}
