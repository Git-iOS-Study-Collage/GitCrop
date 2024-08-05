//
//  PhotoShapeCollectionCell.swift
//  GitCrop
//
//  Created by dev dfcc on 8/2/24.
//

import UIKit

class PhotoShapeCollectionCell: UICollectionViewCell {
    var titleLabel = UILabel()
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
    
    func insertUI() {
        [titleLabel, imageView]
            .forEach {
                contentView.addSubview($0)
            }
    }
    
    func configureCell(photoShape: PhotoShape) {
        titleLabel.text = photoShape.title
        imageView.image = UIImage(named: photoShape.imageName)
    }
    
    func basicSetUI() {
        viewBasicSet()
        titleLabelBasicSet()
        imageViewBasicSet()
    }
    
    func anchorUI() {
        titleLabelAnchor()
        imageViewAnchor()
    }
    
    func viewBasicSet() {
        contentView.backgroundColor = .clear
    }
    
    
    func titleLabelBasicSet() {
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 15)
    }
    
    func imageViewBasicSet() {
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 5
    }
    
    
    func titleLabelAnchor() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(3)
            
        }
    }
    
    func imageViewAnchor() {
        imageView.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.bottom.equalTo(-5)
            
        }
    }
    
}
