//
//  PhotoEditViewController.swift
//  GitCrop
//
//  Created by dev dfcc on 8/2/24.
//

import UIKit

/// 사진편집 Controller

class PhotoEditViewController: UIViewController {
    let photoShape: PhotoShape
    var collageView: CollageView!
    var imageListView = ImageViewListView()
    var count = 0
    
    init(photoShape: PhotoShape) {
        self.photoShape = photoShape
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collageViewSetup()
        insertUI()
        basicSetUI()
        anchorUI()
        setupNavigationUI()
    }
    
    /// 선택한 콜라주 설정
    func collageViewSetup() {
        let size =  CGSize(width: view.frame.width, height: view.frame.width)
        switch photoShape.shapeType {
        case .vertical:
            collageView = VerticalCollageView(frame: CGRect(origin: .zero, size: size))
        case .square:
            collageView = GridCollageView(frame: CGRect(origin: .zero, size: size))
        case .horizontal:
            collageView = VerticalCollageView(frame: CGRect(origin: .zero, size: size))
        }
    }
    
    func insertUI() {
        view.addSubview(collageView)
        view.addSubview(imageListView)
    }
    
    func basicSetUI() {
        viewBasicSet()
        imageListViewBasicSet()
    }
    
    func anchorUI() {
        collageViewAnchor()
        imageListViewAnchor()
    }
    
    func viewBasicSet() {
        view.backgroundColor = .white
    }
    
    func imageListViewBasicSet() {
        imageListView.delegate = self
    }
    
    func collageViewAnchor() {
        collageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            if photoShape.shapeType == .vertical {
                $0.width.height.equalTo(view.frame.width+(view.frame.width/2))
            } else {

                $0.width.height.equalTo(view.frame.width)
            }
        }
    }
    
    func imageListViewAnchor() {
        imageListView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(collageView.snp.bottom)
        }
    }
    
    func setupNavigationUI() {
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem = saveButton
    }
}

extension PhotoEditViewController: ImageViewListViewDelegate {
    /// 라이브러리 사진 선택 후 콜라주 뷰에 넣기
    func didSeletedPhoto(phImage: PHImage) {
        if count > 3 {
            count = 0
        }
        
        collageView.setImage(phImage.image, for: count)
        count += 1
    }
}

extension PhotoEditViewController {
    
    @objc func saveButtonPressed() {
//        saveImageToPhotos(image: collageView.stackView.toImage())
        saveImageToPhotos(image: collageView.stackView.asImage(targetWidth: 1920))
    }
    
    func saveImageToPhotos(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // 저장 실패 시 처리
            showAlert(title: "오류", message: error.localizedDescription)
        } else {
            // 저장 성공 시 처리
            showAlert(message: "저장되었습니다.")
        }
    }
}
