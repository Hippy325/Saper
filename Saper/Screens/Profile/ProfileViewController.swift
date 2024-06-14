//
//  ProfileViewController.swift
//  App
//
//  Created by Тигран Гарибян on 14.05.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        return imageView
    }()
    private lazy var fioLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private lazy var gmailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(fioLabel)
        stackView.addArrangedSubview(gmailLabel)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - private methods
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80),
        ])
    }
}
