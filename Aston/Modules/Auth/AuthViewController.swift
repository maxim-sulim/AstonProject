//
//  SplashViewController.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import UIKit
import SnapKit

protocol AuthViewProtocol: AnyObject {
    func setButtonTitle(with title: String)
}

class AuthViewController: UIViewController, AuthViewProtocol {
    
    var presenter: AuthPresenterProtocol!
    let configurator: AuthConfiguratorProtocol = AuthConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        setAuthView()
    }
    
//MARK: - protocol method

    func setButtonTitle(with title: String) {
        buttonSignIn.setTitle(title, for: .normal)
    }
    
    
//MARK: - private methods
    
    private func setAuthView() {
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
        
        button.addTarget(nil, action: #selector(actionButton), for: .touchUpInside)
        
        return button
    }()
    
    private func getTextField(delegate: UITextFieldDelegate) -> UITextField {
     
        let textField = UITextField()
        let font = UIFont.systemFont(ofSize: 14)
        textField.font = font
        textField.textColor = .darkGray
        textField.layer.cornerRadius = Resources.LayoutView.AuthView.corRadiusTextField
        textField.layer.backgroundColor = Resources.Color.infoLightGray.cgColor
        textField.delegate = delegate
        return textField
    }
    
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
            make.height.equalTo(Resources.LayoutView.AuthView.heightMainContainer)
            make.width.equalTo(Resources.LayoutView.AuthView.widhtMainContainer)
        }
        
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.alignment = .leading
        yStack.spacing = 10
        yStack.distribution = .fillEqually
        
        let loginTextField = getTextField(delegate: self)
        loginTextField.placeholder = Resources.TitleView.AuthView.placeholderLogin.rawValue
        
        let passwordTextField = getTextField(delegate: self)
        passwordTextField.placeholder = Resources.TitleView.AuthView.placeholderPassword.rawValue
        
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
        
    }
    
}

extension AuthViewController: UITextFieldDelegate {
    
}
