//
//  UIViewController+Extension.swift
//  GitCrop
//
//  Created by cha on 8/13/24.
//

import UIKit

extension UIViewController {    
    
    func showAlert(title: String? = nil, message: String, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alertController.addAction(action)
        }
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlert(title: String? = nil, message: String) {
        showAlert(title: title, message: message, actions: [UIAlertAction.okAction])
    }
    
}

extension UIAlertAction {
    class var okAction: UIAlertAction {
        UIAlertAction(title: "확인", style: .default)
    }
    class var cancelAction: UIAlertAction {
        UIAlertAction(title: "취소", style: .cancel)
    }
}
