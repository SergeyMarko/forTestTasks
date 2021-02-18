//
//  UIViewController+Alert.swift
//  QulixSystemsTestTask
//
//  Created by 1 on 2/16/21.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(_ title: String = L10n("alert.title"), message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: L10n("alert.cancel"), style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
