//
//  LoginViewController.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 13.11.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    weak var delegate: LoginViewControllerDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.text = L10n.loginTitle
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 0
        label.text = L10n.loginDescription
        return label
    }()
    private let loginView = LoginView()
    private let signInButton: UIButton = {
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.imagePadding = 8
        buttonConfig.title = L10n.loginButtonTitle
        buttonConfig.cornerStyle = .medium
        buttonConfig.buttonSize = .medium
        
        let button = UIButton(configuration: buttonConfig)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    private let errorMessageLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .systemRed
        label.isHidden = true //Hidden by default
        label.text = ""
        return label
    }()
    
    var username: String? {
        return loginView.userNameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
        loginView.userNameTextField.text = ""
        loginView.passwordTextField.text = ""
    }
}

//MARK: Functions
extension LoginViewController {
    private func style () {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        //Title Label Constraints
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
        //Description label constraints:
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            descriptionLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
        //LoginView Constraints
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: descriptionLabel.bottomAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        //SignInButton Constraints
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        //error message constraints
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
    }
    
    @objc private func signInTapped() {
        errorMessageLabel.isHidden = true
        guard let username,
              let password else {
            assertionFailure("Username / Password should never be nil")
            return
        }
        
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty || !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            configureView(withMessage: L10n.emptyUsernameAndPasswordError)
            return
        }
        
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty else {
            configureView(withMessage: L10n.emptyUsernameError)
            return
        }
        
        guard !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            configureView(withMessage: L10n.emptyPasswordError)
            return
        }
        
        if username == "Asd" && password == "asd" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin(self)
            return
        } else {
            configureView(withMessage: L10n.incorrectUsernameOrPassword)
            return
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}
