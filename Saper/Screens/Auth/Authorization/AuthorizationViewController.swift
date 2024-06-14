//
//  AuthorizationViewController.swift
//  App
//
//  Created by Тигран Гарибян on 14.05.2024.
//

import UIKit

class AuthorizationViewController: UIViewController {

    private lazy var gmailTextField: TextField = {
        let textField = TextField()
        textField.titleLabel.text = "Введите email"
        return textField
    }()
    private lazy var paswordTextField: TextField = {
        let textField = TextField()
        textField.titleLabel.text = "Введите пароль"
        return textField
    }()
    private lazy var signInButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle("Войти")
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(tapOnSignIn), for: .touchUpInside)
        return button
    }()
    private lazy var signUpButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle("Зарегистрироваться")
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(tapOnSignUp), for: .touchUpInside)
        return button
    }()
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(gmailTextField)
        stackView.addArrangedSubview(paswordTextField)
        return stackView
    }()
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(signInButton)
        stackView.addArrangedSubview(signUpButton)
        return stackView
    }()
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(textFieldsStackView)
        stackView.addArrangedSubview(buttonsStackView)
        return stackView
    }()
    
    private let presenter: IAuthorizationPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardCloseButton()
        setupUI()
    }
    
    // MARK: - Init
    
    init(presenter: IAuthorizationPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private methods
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            signInButton.widthAnchor.constraint(equalTo: signUpButton.widthAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 32),
            signUpButton.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    // MARK: - Action
    
    @objc private func tapOnSignIn() {
        presenter.signIn()
    }
    
    @objc private func tapOnSignUp() {
        presenter.signUp()
    }
}
