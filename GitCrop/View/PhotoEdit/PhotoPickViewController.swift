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
    var saveButton = UIButton()
    var selectedImageView = EditableImageView()
    
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
        buttonSetup()
        selectedImageViewSetup()
    }
    
    private func buttonSetup() {
        saveButton.setTitle("완료", for: .normal)
        saveButton.setTitleColor(.gray, for: .disabled)
        saveButton.setTitleColor(.blue, for: .normal)
        saveButton.isEnabled = false
    }
    
    private func selectedImageViewSetup() {
//        selectedImageView.backgroundColor = .green
    }
    
    private func interface() {
        addInterface()
        anchorInterface()
    }
    
    private func addInterface() {
        view.addSubview(saveButton)
        view.addSubview(selectedImageView)
        view.addSubview(imageListView)
    }
    
    private func anchorInterface() {
        buttonAnchor()
        selectedImageViewAnchor()
        imageListViewAnchor()
    }
    
    private func buttonAnchor() {
        saveButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func selectedImageViewAnchor() {
        selectedImageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            $0.height.equalTo(selectedImageView.snp.width)
            
        }
    }
    
    private func imageListViewAnchor() {
        imageListView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view).multipliedBy(0.3)
        }
    }    
}

extension PhotoPickViewController: ImageViewListViewDelegate {
    func didSeletedPhoto(phImage: PHImage) {
        imageProcessingQueue.async {
            PHAssetManager.shared.getImage(asset: phImage.asset) { image in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    selectedImageView.setImage(image)
                }
            }
        }
    }
}
