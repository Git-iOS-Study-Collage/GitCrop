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
    var imageview = UIImageView()
    let saveButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        interface()
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        imageview.contentMode = .scaleAspectFit
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
        view.addSubview(imageview)
        imageview.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
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
