//
//  SplashViewController.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import UIKit
import SnapKit

protocol AuthViewProtocol: AnyObject {
    func getloginUser() -> String?
    func getPassswordUser() -> String?
}

final class AuthViewController: UIViewController, AuthViewProtocol {
    
    var presenter: AuthPresenterProtocol!
    let configurator: AuthConfiguratorProtocol = AuthConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        setAuthView()
    }
    
//MARK: - enum TextField
    
    private enum TextFieldTags: Int {
        case login
        case password
    }
    
//MARK: - protocol method

    func getloginUser() -> String? {
        self.loginTextField.text
    }
    
    func getPassswordUser() -> String? {
        self.passwordTextField.text
    }
    
    
//MARK: - private methods
    
    private func setAuthView() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        DispatchQueue.main.async {
            self.setupContainer()
        }
    }
    
    lazy private var mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Color.blackGrayBackGround
        view.layer.cornerRadius = Resources.LayoutView.AuthView.corRadiusMain
        return view
    }()
    
    private let buttonSignIn: UIButton = {
        
        let button = UIButton()
        
        button.backgroundColor = .clear
        button.tintColor = .white
        button.setTitle(Resources.TitleView.AuthView.titleButton.rawValue, for: .normal)
        button.addTarget(nil, action: #selector(actionButton), for: .touchUpInside)
        
        return button
    }()
    
    private func getTextField() -> UITextField {
     
        let textField = UITextField()
        let font = UIFont.systemFont(ofSize: 14)
        textField.font = font
        textField.textColor = .darkGray
        textField.layer.cornerRadius = Resources.LayoutView.AuthView.corRadiusTextField
        textField.layer.backgroundColor = Resources.Color.infoLightGray.cgColor
        return textField
    }
    
    lazy private var loginTextField: UITextField = {
        let textField = getTextField()
        textField.placeholder = Resources.TitleView.AuthView.placeholderLogin.rawValue
        textField.delegate = self
        textField.tag = TextFieldTags.login.rawValue
        return textField
    }()
    
    lazy private var passwordTextField: UITextField = {
        let textField = getTextField()
        textField.placeholder = Resources.TitleView.AuthView.placeholderPassword.rawValue
        textField.delegate = self
        textField.tag = TextFieldTags.password.rawValue
        return textField
    }()
    
    private func getLabel() -> UILabel {
        
        let label = UILabel()
        label.textColor = Resources.Color.poisonousGreen
        let font = UIFont.systemFont(ofSize: 18)
        label.font = font
        return label
    }
    
    
    private func setupContainer() {
        self.view.addSubview(mainContainer)
        
        mainContainer.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(Resources.LayoutView.AuthView.boundsMainContainer.height)
            make.width.equalTo(Resources.LayoutView.AuthView.boundsMainContainer.widht)
        }
        
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.alignment = .leading
        yStack.spacing = 10
        yStack.distribution = .fillEqually
        
        let loginLabel = getLabel()
        loginLabel.text = Resources.TitleView.AuthView.titleLabelLogin.rawValue
        
        let passwordLabel = getLabel()
        passwordLabel.text = Resources.TitleView.AuthView.titleLabelPassword.rawValue
        
        yStack.addArrangedSubview(loginLabel)
        yStack.addArrangedSubview(loginTextField)
        yStack.addArrangedSubview(passwordLabel)
        yStack.addArrangedSubview(passwordTextField)
        
        mainContainer.addSubview(yStack)
        mainContainer.addSubview(buttonSignIn)
        
        yStack.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(buttonSignIn.snp.top).inset(-8)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.width.equalTo(yStack.snp.width)
        }
        passwordTextField.snp.makeConstraints { make in
            make.width.equalTo(yStack.snp.width)
        }
        
        buttonSignIn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(Resources.LayoutView.AuthView.heightButtonSignIn)
        }
    }
    
    @objc private func actionButton() {
        view.endEditing(true)
        presenter.signIn()
    }
    
}

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text, text.count > 0 else {
            return false
        }
        
        switch textField.tag {
        case TextFieldTags.login.rawValue:
            return passwordTextField.becomeFirstResponder()
        case TextFieldTags.password.rawValue:
            presenter.signIn()
        default:
            return false
        }
        
        return true
    }
    
}
