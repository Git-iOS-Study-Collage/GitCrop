//
//  ImageListView.swift
//  GitCrop
//
//  Created by dev dfcc on 7/30/24.
//

import UIKit
import SnapKit
import Photos


/// 라이브러리의 사진 목록 화면

protocol ImageViewListViewDelegate: AnyObject {
    func didSeletedPhoto(phImage: PHImage)
}

final class ImageViewListView: UIView {
    
    weak var delegate: ImageViewListViewDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        let cView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cView
    }()
        
    var assetList = [PHImage]()
    var itemSelected: PHImage?
    var showFirstItem: PHImage?

    init() {
        super.init(frame: .zero)
        insertUI()
        basicSetUI()
        anchorUI()
        bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageViewListView {
    func bindUI() {
        let assetList = PHAssetManager.shared.getPHAssets(with: .image)
        Task {
            let imageList = await PHAssetManager.shared.getImageList(assetList: assetList)
            self.assetList = imageList
            collectionView.reloadData()
        }
    }
}

extension ImageViewListView {
    func insertUI() {
        addSubview(collectionView)
    }
    
    func basicSetUI() {
        collectionViewBasicSet()
    }
    
    func anchorUI() {
        collectionViewAnchor()
    }
    
    func collectionViewAnchor() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func collectionViewBasicSet() {
        collectionView.registerCell(ImageListCollectionCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ImageViewListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = assetList[indexPath.item]
        delegate?.didSeletedPhoto(phImage: item)
    }
}

extension ImageViewListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assetList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageListCollectionCell = collectionView.dequeueCell(indexPath: indexPath)
        cell.configureCell(phImage: assetList[indexPath.item])
        return cell
    }
    
    
}

extension ImageViewListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width/3 - 1, height: width/3 - 1)
    }
}
