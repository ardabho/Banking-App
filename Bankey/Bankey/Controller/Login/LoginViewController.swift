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
        label.alpha = 0
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 0
        label.text = L10n.loginDescription
        label.alpha = 0
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
    
    //For animations:
    private let leadingEdgeOnScreen: CGFloat = 0
    private let leadingEdgeOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var descriptionLeadingAnchor: NSLayoutConstraint?
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
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
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        
        
        //Description label constraints:
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            descriptionLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
        descriptionLeadingAnchor = descriptionLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: leadingEdgeOffScreen)
        descriptionLeadingAnchor?.isActive = true
        
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
        shakeButton()
    }
    
    //MARK: Animations
    private func animate() {
        let titleAnimation = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        let descriptionAnimation = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
            self.descriptionLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        let alphaAnimation = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
            self.titleLabel.alpha = 1
            self.descriptionLabel.alpha = 1
        }
    
        titleAnimation.startAnimation()
        descriptionAnimation.startAnimation(afterDelay: 0.3)
        alphaAnimation.startAnimation(afterDelay: 0.3)
        
    }
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 1
        animation.duration = 0.4
        
        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
    }
}
