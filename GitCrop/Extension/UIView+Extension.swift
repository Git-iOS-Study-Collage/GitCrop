//
//  UIView+Extension.swift
//  GitCrop
//
//  Created by cha on 8/13/24.
//

import UIKit

extension UIView {
    
    func toImage() -> UIImage {
        print("이미지 프레임 \(self.frame)")
        print("이미지 바운드 \(self.bounds)")
        let renderer = UIGraphicsImageRenderer(bounds: self.bounds, format: .init(for: .init(displayScale: 1)))
        return renderer.image { rendererContext in
            self.layer.render(in: rendererContext.cgContext)
        }
    }
    
    func asImage(targetWidth: CGFloat) -> UIImage {
        print("이미지 프레임 \(self.frame)")
        print("이미지 바운드 \(self.bounds)")
        // 1. 원본 뷰의 비율 계산
        let aspectRatio = self.bounds.size.height / self.bounds.size.width
        
        // 2. 새로운 크기 계산
        let newSize = CGSize(width: targetWidth, height: targetWidth * aspectRatio)
        
        // 3. UIGraphicsImageRenderer를 사용하여 이미지 생성
        let renderer = UIGraphicsImageRenderer(size: newSize, format: .init(for: .init(displayScale: 1)))
        
        let image = renderer.image { context in
            // 4. 컨텍스트 저장
            context.cgContext.saveGState()
            
            // 5. 스케일 변환 적용
            context.cgContext.scaleBy(x: newSize.width / self.bounds.width,
                                      y: newSize.height / self.bounds.height)
            
            // 6. 뷰 그리기
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
            
            // 7. 컨텍스트 복원
            context.cgContext.restoreGState()
        }
        
        return image
    }
}
