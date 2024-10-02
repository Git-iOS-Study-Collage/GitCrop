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
    var backgroundSelectView = BackgroundSelectView()
    var minimapImageView = UIImageView()
    var count = 0
    
    let nextButton = UIBarButtonItem()
    let backGroundSelectButton = UIBarButtonItem()
    
    private let imageProcessingQueue = DispatchQueue(label: "com.Git.GitCrop.imageProcessingQueue")
    
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
        setup()
    }
    
    /// 선택한 콜라주 설정
    func collageViewSetup() {
        let size =  view.frame.size
    
        navigationItem.title = photoShape.title
        
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
        view.addSubview(backgroundSelectView)
    }
    
    func basicSetUI() {
        viewBasicSet()
        backgroundSelectViewBasicSet()
    }
    
    func anchorUI() {
        collageViewAnchor()
        backgroundSelectViewAnchor()
    }
    
    func viewBasicSet() {
        view.backgroundColor = .white
    }
    
    func imageListViewBasicSet() {
        imageListView.delegate = self
    }
    
    func backgroundSelectViewBasicSet() {
        backgroundSelectView.delegate = self
    }
    
    func collageViewAnchor() {
        collageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            if photoShape.shapeType == .vertical {
                $0.width.height.equalTo(view.frame.width+(view.frame.width/2))
            } else {
                $0.width.height.equalTo(view.frame.width)
            }
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func backgroundSelectViewAnchor() {
        backgroundSelectView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
    }
    
    func imageListViewAnchor() {
        imageListView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(collageView.snp.bottom)
        }
    }
    
    func setupNavigationUI() {
        nextButton.title = "다음"
        nextButton.style = .plain
        nextButton.target = self
        nextButton.action = #selector(nextButtonPressed)
        nextButton.isEnabled = false
        navigationItem.rightBarButtonItem = nextButton
        
        backGroundSelectButton.title = "배경"
        backGroundSelectButton.style = .plain
        backGroundSelectButton.target = self
        backGroundSelectButton.action = #selector(backgroundButtonPressed)
        
        navigationItem.rightBarButtonItems = [nextButton, backGroundSelectButton]
    }
    
    func setup() {
        collageView.delegate = self
    }
}

extension PhotoEditViewController: BackgroundSelectViewDelegate {
    func didSelectedBackgroundType(backgroundType: BackGroundImageType) {
        collageView.setBackgroundImage(type: backgroundType)
    }
}

extension PhotoEditViewController: ImageViewListViewDelegate {
    
    
    /// 라이브러리 사진 선택 후 콜라주 뷰에 넣기
    /// 사진 로딩이 오래 걸릴경우 현재 main 스레드가 블럭되는 현상이 잇음
    /// ex: 아이클라우드 백업으로 처리된 오래된 사진을 불러올 때
    func didSelectedPhoto(phImage: PHImage) {
        
        if count > collageView.maxCount {
            count = 0
        }
        
        let finalCount = count
        
        count += 1
        
        collageView.imageViewList[finalCount].showIndicator()
        
        imageProcessingQueue.async {
            PHAssetManager.shared.getImage(asset: phImage.asset) { image in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    collageView.setImage(image, for: finalCount)
                    collageView.imageViewList[finalCount].hideIndicator()
                }
            }
        }
    }
}

extension PhotoEditViewController {
    @objc
    func nextButtonPressed() {
        let image = collageView.contentView.asImage(targetWidth: 1920)
        let vc = ResultViewController(resultImage: image)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc 
    func backgroundButtonPressed() {
        backgroundSelectView.isHidden = !backgroundSelectView.isHidden
    }
}


extension PhotoEditViewController: ImageSelectDelegate {
    func imageTapped() {
        let vc = PhotoPickViewController(tag: count)
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension PhotoEditViewController: PhotoPickDelegate {
    func didSelectPhoto(image: UIImage, tag: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
        
            collageView.setImage(image, for: tag)
            nextButton.isEnabled = true
        }
    }
}
