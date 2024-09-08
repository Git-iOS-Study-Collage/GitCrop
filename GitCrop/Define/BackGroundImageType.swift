//
//  BackGroundImageType.swift
//  GitCrop
//
//  Created by ByungHoon Ann on 9/8/24.
//

import UIKit

/// 백그라운드 이미지 목록
enum BackGroundImageType: String, CaseIterable {
    case checkBackground = "CheckBackground"
    case lineBackground = "LineBackground"
    case heartRainbowBackground = "HeartRainbowBackground"
    case rabbitsBackground = "RabbitsBackground"
    case none = ""
    
    var image: UIImage? {
        return UIImage(named: rawValue)
    }
}
