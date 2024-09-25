//
//  PhotoPickViewController.swift
//  GitCrop
//
//  Created by gkang on 8/28/24.
//

import UIKit
import SnapKit

protocol PhotoPickDelegate {
    func didSelectPhoto(image: UIImage, tag: Int)
}


class PhotoPickViewController: UIViewController {
    init(tag: Int) {
        self.tag = tag
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delegate: PhotoPickDelegate?
    var tag: Int
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
    }
    
    private func buttonSetup() {
        saveButton.setTitle("완료", for: .normal)
        saveButton.setTitleColor(.systemGray, for: .disabled)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.isEnabled = false
        saveButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
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
    
    @objc
    private func buttonAction() {
        guard let image = selectedImageView.imageView.image else { return }
        delegate?.didSelectPhoto(image: image, tag: tag)
        self.dismiss(animated: true)
    }
}

extension PhotoPickViewController: ImageViewListViewDelegate {
    func didSelectedPhoto(phImage: PHImage) {
        imageProcessingQueue.async {
            PHAssetManager.shared.getImage(asset: phImage.asset) { image in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    selectedImageView.setImage(image)
                    saveButton.isEnabled = true
                }
            }
        }
    }
}
