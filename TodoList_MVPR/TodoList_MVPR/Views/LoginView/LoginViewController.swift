//
//  ViewController.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-15.
//

import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    var presenter: LoginViewPresenterProtocol? { get set }
    func presentAlert(_ alert: UIAlertController)
}

final class LoginViewController: UIViewController, LoginViewControllerProtocol {
    var presenter: LoginViewPresenterProtocol?
    
    //MARK: - VIEWDIDLOAD -
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .clear
        configImageView()
        configUI()
    }
    // PRESENT ALERT FUNCTION
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    // MARK: - LOGIN BUTTON ACTION -
    @objc private func loginButtonPressed() {
        presenter?.didTapLoginButton(passwordTextField: passwordTextField, usernameTextField: usernameTextField)
    }
    //MARK: - SETUP UI -
    // IMAGEVIEW
    private lazy var logoImageView = UIImageView()
    // STACKVIEW
    private lazy var stackView = UIStackView(arrangedSubviews: [
        usernameTextField,
        passwordTextField,
        loginButton
    ])
    // USERNAME TEXTFIELD
    private lazy var usernameTextField = UITextField(size: CGSize())
    // PASSWORD TEXTFIELD
    private lazy var passwordTextField = UITextField(size: CGSize())
    // LOGIN BUTTON
    private lazy var loginButton = UIButton(size: CGSize())
    
    // MARK: - CONFIG UI -
    private func configUI() {
        configStackView()
        configUsernameTF()
        configPasswordTF()
        configLoginButton()
        dismissKeyboardGesture()
        setupConstraints()
    }
    // CONFIGURE LOGO IMAGE VIEW
    private func configImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logoimage")
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
    }
    // STACKVIEW
    private func configStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        view.addSubview(stackView)
    }
    // USERNAME TEXTFIELD
    private func configUsernameTF() {
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Enter Username"
        usernameTextField.enablesReturnKeyAutomatically = true
    }
    // PASSWORD TEXTFIELD
    private func configPasswordTF() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.enablesReturnKeyAutomatically = true
    }
    // LOGIN BUTTON
    private func configLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString(
            attributedString: NSAttributedString(
                string: "Login",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                             .foregroundColor: UIColor.white]))
        loginButton.setAttributedTitle(attributedString, for: .normal)
        loginButton.backgroundColor = .clear
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
}
// MARK: - CONSTRAINTS -
extension LoginViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // LOGO IMAGEVIEW CONSTRAINTS
            logoImageView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // STACKVIEW CONSTRAINTS
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: view.readableContentGuide.heightAnchor, multiplier: 1/6),
            stackView.widthAnchor.constraint(equalTo: view.readableContentGuide.widthAnchor),
            // USERNAME TEXTFIELD CONSTRAINTS
            usernameTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 3/5),
            // PASSWORD TEXTFIELD CONSTRAINTS
            passwordTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 3/5),
            // LOGIN BUTTON CONSTRAINTS
            loginButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 2/5),
        ])
    }
}
