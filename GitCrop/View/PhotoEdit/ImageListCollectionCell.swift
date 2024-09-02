//
//  ImageListCollectionCell.swift
//  GitCrop
//
//  Created by dev dfcc on 7/30/24.
//

import UIKit

final class ImageListCollectionCell: UICollectionViewCell {
    private var imageView = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    func configureCell(phImage: PHImage) {
        loadImage(asset: phImage)
    }
    
    func loadImage(asset: PHImage) {
        Task {
            imageView.image = await PHAssetManager.shared.getMiniImage(asset: asset.asset)
        }
    }
}

extension ImageListCollectionCell {
    func insertUI() {
        contentView.addSubview(imageView)
    }
    
    func basicSetUI() {
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    func anchorUI() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
