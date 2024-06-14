//
//  UIViewController+Extension.swift
//  App
//
//  Created by Тигран Гарибян on 14.05.2024.
//

import UIKit

extension UIViewController {
    func addKeyboardCloseButton() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
