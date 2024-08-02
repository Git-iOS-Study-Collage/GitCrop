//
//  FrameSelectViewController.swift
//  GitCrop
//
//  Created by dev dfcc on 7/29/24.
//

import UIKit

class FrameSelectViewController: UIViewController {
    var photoShapes: [PhotoShape] = [FourVertical(), FourWindow()]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width/3 - 1, height: view.frame.width/3 - 1)
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        layout.scrollDirection = .vertical
        let cview = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        return cview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    func insertUI() {
        view.addSubview(collectionView)
    }
    
    func basicSetUI() {
        viewBasicSet()
        collectionViewBasicSet()
    }
    
    func anchorUI() {
        collectionViewAnchor()
    }
    
    func viewBasicSet() {
        view.backgroundColor = .white
        navigationItem.title = "프레임 선택"
    }
    
    func collectionViewBasicSet() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCell(PhotoShapeCollectionCell.self)
    }
    
    func collectionViewAnchor() {
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension FrameSelectViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = photoShapes[indexPath.item]
        let vc = PhotoEditViewController(photoShape: item)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FrameSelectViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoShapes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoShapeCollectionCell = collectionView.dequeueCell(indexPath: indexPath)
        cell.configureCell(photoShape: photoShapes[indexPath.item])
        return cell
    }
}

