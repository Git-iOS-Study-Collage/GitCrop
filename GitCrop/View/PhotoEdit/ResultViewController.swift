//
//  ResultViewController.swift
//  GitCrop
//
//  Created by gkang on 9/2/24.
//

import UIKit
import SnapKit

class ResultViewController: UIViewController {
    init(resultImage: UIImage) {
        self.resultImage = resultImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var resultImage: UIImage
    var scrollView = UIScrollView()
    var imageview = UIImageView()
    let saveButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        interface()
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.backgroundColor = .clear
        scrollView.isScrollEnabled = true
        
        imageview.contentMode = .scaleAspectFill
        imageview.image = resultImage
        
        setupNavigationUI()
    }
    
   private func setupNavigationUI() {
       saveButton.title = "저장"
       saveButton.style = .plain
       saveButton.target = self
       saveButton.action = #selector(saveButtonPressed)
       saveButton.isEnabled = true

        navigationItem.rightBarButtonItem = saveButton
    }
    
    
    private func interface() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.contentSize = scrollView.bounds.size
        
        scrollView.addSubview(imageview)
        imageview.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(scrollView.frame.height)
        }
    }
}

extension ResultViewController {
    @objc
    func saveButtonPressed() {
        saveImageToPhotos(image: resultImage)
    }
    
    func saveImageToPhotos(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc 
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // 저장 실패 시 처리
            showAlert(title: "오류", message: error.localizedDescription)
        } else {
            // 저장 성공 시 처리
            showAlert(message: "저장되었습니다.")
        }
    }
}
