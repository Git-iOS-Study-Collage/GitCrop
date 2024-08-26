//
//  ZoomableImageDelegate.swift
//  GitCrop
//
//  Created by cha on 8/19/24.
//

import UIKit

class ZoomableImageDelegate: NSObject, UIScrollViewDelegate {
    weak var imageView: UIImageView?
    
    init(imageView: UIImageView) {
        self.imageView = imageView
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // 스크롤뷰보다 더 작게 축소할 경우 이미지가 스크롤뷰의 중앙으로 오게 함
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        guard let imageView = imageView else { return }
        
        let scrollViewSize = scrollView.bounds.size
        let imageSize = imageView.frame.size
        
        // 가로와 세로 각각 중심점을 맞추기 위해 contentInset 조정
        let verticalInset = max(0, (scrollViewSize.height - imageSize.height) / 2)
        let horizontalInset = max(0, (scrollViewSize.width - imageSize.width) / 2)
        
        scrollView.contentInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }
}
