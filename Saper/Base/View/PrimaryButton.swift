//
//  PrimaryButton.swift
//  App
//
//  Created by Тигран Гарибян on 14.05.2024.
//

import UIKit

class PrimaryButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        applyStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyStyle()
    }
    
    override var isEnabled: Bool {
        didSet {
            applyStyle()
        }
    }
}

// MARK: Extension for styling

extension PrimaryButton {
    
    func applyStyle() {
        layer.cornerRadius = 16
        setTitleColor( isEnabled ? .white : .black)
        titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
    }
}
