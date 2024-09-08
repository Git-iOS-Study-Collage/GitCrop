//
//  BackgroundSelectCollectionViewCell.swift
//  GitCrop
//
//  Created by ByungHoon Ann on 9/8/24.
//

import UIKit

/// 백그라운드 이미지 표시용 ColectionViewCell
class BackgroundSelectCollectionViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(type: BackGroundImageType) {
        imageView.image = type.image
    }
    
    func insertUI() {
        contentView.addSubview(imageView)
    }
    
    func basicSetUI() {
        imageViewBasicSet()
        viewBasicSet()
    }
    
    func anchorUI() {
        imageViewAnchor()
    }
    
    func viewBasicSet() {
        contentView.backgroundColor = .clear
    }
    
    func imageViewBasicSet() {
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
    }
    
    func imageViewAnchor() {
        imageView.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.left.equalTo(10)
            $0.trailing.equalTo(-10)
            $0.bottom.equalTo(-1)
            
        }
    }
}
