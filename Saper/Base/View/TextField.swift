//
//  TextField.swift
//  App
//
//  Created by Тигран Гарибян on 14.05.2024.
//

import UIKit

class TextField: UIView {
    
    var textField = IndentedTextField()
    var titleLabel = UILabel()
    var errorLabel = UILabel()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(errorLabel)
        return stackView
    }()
    
    // MARK: Public properties
    
    var rightTextFieldTaped: (() -> Void)?
    
    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    var returnKeyType: UIReturnKeyType = .default {
        didSet {
            textField.returnKeyType = returnKeyType
        }
    }
    var placeholder: String? {
        didSet {
            textField.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor : UIColor.gray, .font : UIFont.systemFont(ofSize: 16, weight: .regular)])
        }
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: Public methods
    
    func showErrorMessage(_ message: String?) {
        textField.layer.borderColor = UIColor.red.cgColor
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func hideErrorMessage() {
        textField.layer.borderColor = textField.isEditing ? UIColor.blue.cgColor : UIColor.lightGray.cgColor
        errorLabel.text = " "
        errorLabel.isHidden = true
    }
    
    func setupRightImageView(withImageName name: String) {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24.0, height: 24.0))
        button.setImage(UIImage(named: name))
        button.addTarget(self, action: #selector(rightViewTapped), for: .touchUpInside)
        button.backgroundColor = .white
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24.0, height: 24.0))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: name)
        textField.right = 42
        textField.rightView = button
        textField.rightViewMode = .always
    }
    
    // MARK: Private methods
    
    private func commonInit() {
        addSubview(stackView)
        stackView.equalToSuper()
        applyStyle()
        initializeSetup()
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    private func initializeSetup() {
        textField.autocorrectionType = .no
        let gestureRecornizer = UITapGestureRecognizer(target: self, action: #selector(rightViewTapped))
        textField.rightView?.addGestureRecognizer(gestureRecornizer)
    }
    
    @objc private func rightViewTapped() {
        rightTextFieldTaped?()
    }
    
    @objc private func doneBtnFromKeyboardClicked (sender: Any) {
      endEditing(true)
    }
}

// MARK: Extension for styling

extension TextField {
    @objc func applyStyle() {
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        textField.layer.cornerRadius = 4.0
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        errorLabel.textColor = .red
        errorLabel.font = .systemFont(ofSize: 13, weight: .regular)
        errorLabel.isHidden = true
        textField.tintColor = .black
        if !isUserInteractionEnabled {
            textField.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.38)
        }
    }
}
