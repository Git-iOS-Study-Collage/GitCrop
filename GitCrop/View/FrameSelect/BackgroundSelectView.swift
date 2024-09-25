//
//  BackgroundSelectView.swift
//  GitCrop
//
//  Created by ByungHoon Ann on 9/8/24.
//

import UIKit


/// 백그라운드 선택 리스트 뷰

protocol BackgroundSelectViewDelegate: AnyObject {
    func didSelectedBackgroundType(backgroundType: BackGroundImageType)
}

class BackgroundSelectView: UIView {
    weak var delegate: BackgroundSelectViewDelegate?
    
    var backgroundTypes = BackGroundImageType.allCases
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize(width: frame.width/4 - 1, height: frame.width/4 - 1)
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        layout.scrollDirection = .horizontal
        let cview = UICollectionView(frame: frame, collectionViewLayout: layout)
        return cview
    }()
    
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
        addSubview(collectionView)
    }
    
    func basicSetUI() {
        viewBasicSet()
        collectionViewBasicSet()
    }
    
    func anchorUI() {
        collectionViewAnchor()
    }
    
    func viewBasicSet() {
        backgroundColor = .white
        
    }
    
    func collectionViewBasicSet() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerCell(BackgroundSelectCollectionViewCell.self)
    }
    
    func collectionViewAnchor() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension BackgroundSelectView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectedBackgroundType(backgroundType: backgroundTypes[indexPath.item])
    }
}

extension BackgroundSelectView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return backgroundTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BackgroundSelectCollectionViewCell = collectionView.dequeueCell(indexPath: indexPath)
        cell.configureCell(type: backgroundTypes[indexPath.item])
        return cell
    }
}

extension BackgroundSelectView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
}
