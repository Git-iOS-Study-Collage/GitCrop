//
//  PhotoPickViewController.swift
//  GitCrop
//
//  Created by gkang on 8/28/24.
//

import UIKit
import SnapKit

protocol PhotoPickDelegate {
    func didSelectPhoto()
}


class PhotoPickViewController: UIViewController {
    let saveButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("완료", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.setTitleColor(.blue, for: .highlighted)
        return btn
    }()
    
    var imageListView = ImageViewListView()
    private let imageProcessingQueue = DispatchQueue(label: "com.Git.GitCrop.imageProcessingQueue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        interface()
    }
    
    private func setup() {
        view.backgroundColor = .white
        imageListView.delegate = self
        saveButton.isEnabled = true
    }
    
    private func interface() {
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}

extension PhotoPickViewController: ImageViewListViewDelegate {
    func didSeletedPhoto(phImage: PHImage) {
//        imageProcessingQueue.async {
//            PHAssetManager.shared.getImage(asset: phImage.asset) { image in
//                <#code#>
//            }
//        }
    }
}
