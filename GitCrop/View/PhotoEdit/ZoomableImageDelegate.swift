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
}
