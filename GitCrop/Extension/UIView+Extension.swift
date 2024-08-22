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


extension UIView {
    // 호출 카운트를 관리할 프로퍼티를 전역 변수로 선언
    private static var indicatorCount = [String: Int]()
    
    // UIActivityIndicatorView를 뷰의 정중앙에 추가하는 함수
    func showIndicator() {
        // 인디케이터 카운트 증가
        let viewID = "\(Unmanaged.passUnretained(self).toOpaque())"
        UIView.indicatorCount[viewID, default: 0] += 1
        
        // 기존에 존재하는 Activity Indicator가 있는지 확인하고, 있으면 제거
        if let existingIndicator = self.viewWithTag(9999) as? UIActivityIndicatorView {
            existingIndicator.startAnimating()
            return
        }
        
        // 새로운 Activity Indicator 생성
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .red
        activityIndicator.tag = 9999 // 태그를 사용하여 나중에 쉽게 찾을 수 있게 설정
        
        // Activity Indicator의 크기와 위치를 설정
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        
        // 중앙 정렬을 위한 제약조건 설정
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        // Activity Indicator 시작
        activityIndicator.startAnimating()
    }
    
    // UIActivityIndicatorView를 제거하는 함수
    func hideIndicator() {
        // 인디케이터 카운트 감소
        let viewID = "\(Unmanaged.passUnretained(self).toOpaque())"
        if let count = UIView.indicatorCount[viewID] {
            if count > 1 {
                UIView.indicatorCount[viewID] = count - 1
                return
            } else {
                UIView.indicatorCount[viewID] = nil
            }
        }
        
        // 태그로 Activity Indicator를 찾음
        if let activityIndicator = self.viewWithTag(9999) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
