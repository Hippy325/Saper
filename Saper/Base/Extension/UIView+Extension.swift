//
//  UIView+Extension.swift
//  App
//
//  Created by Тигран Гарибян on 14.05.2024.
//

import UIKit

extension UIView {
    
    func equalToSuper(top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
        guard let superview = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: bottom),
            self.leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor, constant: right)
        ])
    }
}
