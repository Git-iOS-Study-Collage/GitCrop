//
//  ViewController.swift
//  GitCrop
//
//  Created by dev dfcc on 7/29/24.
//

import UIKit

class ViewController: UIViewController {
    var imageListView = ImageViewListView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageListView)
        imageListView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

