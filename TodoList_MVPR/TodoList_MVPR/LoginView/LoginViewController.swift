//
//  ViewController.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-05-15.
//

import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    var presenter: LoginViewPresenterProtocol? { get set }
}

// MARK: - UIViewController and Protocol -
final class LoginViewController: UIViewController, LoginViewControllerProtocol  {
    
    var presenter: LoginViewPresenterProtocol?
    
    //MARK: - SETUP VIEWS -
    
    // IMAGEVIEW
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logoimage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // STACKVIEW
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            usernameTextField, passwordTextField, loginButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    // USERNAME TEXTFIELD
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField(size: CGSize())
        textField.placeholder = "Enter Username"
        return textField
    }()
    
    // PASSWORD TEXTFIELD
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField(size: CGSize())
        textField.placeholder = "Enter Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    // LOGIN BUTTON
    lazy var loginButton: UIButton = {
        let button = UIButton(size: CGSize())
        let attributedString = NSMutableAttributedString(
            attributedString: NSAttributedString(
                string: "Login",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                             .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - ACTIONS  -
    @objc func loginButtonPressed() {
        if passwordTextField.text == "password" && ((usernameTextField.text?.isEmpty) != nil) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.passwordTextField.text = nil
                self.presenter?.didTapLogin()
            }
        } else {
            let alertWrongPassword = UIAlertController(title: "Incorrect Password", message: "Please Try Again", preferredStyle: .actionSheet)
            alertWrongPassword.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertWrongPassword, animated: true, completion: nil)
        }
    }
    
    //MARK: - VIEWDIDLOAD -
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardGesture()
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        setupConstraints()
    }
    
    
}

// MARK: - CONSTRAINTS -
extension LoginViewController {
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: view.readableContentGuide.heightAnchor, multiplier: 1/6),
            stackView.widthAnchor.constraint(equalTo: view.readableContentGuide.widthAnchor),
            
            usernameTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 3/5),
            //            usernameTextField.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/5),
            
            passwordTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 3/5),
            //            passwordTextField.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/5),
            
            loginButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 2/5),
            //            loginButton.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/5),
            
        ])
    }
    
}
