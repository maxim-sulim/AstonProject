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
    func alertErrorUserLife()
    func alertErrorNotPassword()
    func alertErrorInvalidePassword()
}

final class AuthViewController: UIViewController {
    
    var presenter: AuthPresenterProtocol!
    let configurator: AuthConfiguratorProtocol = AuthConfigurator()
    var rootCoordinator: RootCoordinatorProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        setAuthView()
    }
    
    init(rootCoordinator: RootCoordinatorProtocol) {
        self.rootCoordinator = rootCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - enum TextField
    
    private enum TextFieldTags: Int {
        case login
        case password
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
        
        if autOrRegSwich.isOn {
            
            view.backgroundColor = Resources.Color.grayButtonInoutBackGround
        } else {
            
            view.backgroundColor = Resources.Color.blackGrayBackGround
        }
        
        view.layer.cornerRadius = Resources.LayoutView.AuthView.corRadiusMain
        return view
    }()
    
    lazy private var buttonSignIn: UIButton = {
        
        let button = UIButton()
        
        button.backgroundColor = .clear
        button.tintColor = .white
        
        if autOrRegSwich.isOn {
            
            button.setTitle(Resources.TitleView.AuthView.titleButtonEnter.rawValue, for: .normal)
        } else {

            button.setTitle(Resources.TitleView.AuthView.titleButtonDef.rawValue, for: .normal)
        }
        
        button.addTarget(nil, action: #selector(actionButton), for: .touchUpInside)
        
        return button
    }()
    
    /// Если пользователь попадает на экран авторизации из mainFlow, свич будет активирован, тк у пользователя есть логин и пароль(Если он его не удалял).
    lazy private var autOrRegSwich: UISwitch = {
        let swith = UISwitch()
        
        if presenter.isAuth {
            
            swith.isOn = true
        } else {
            
            swith.isOn = false
        }
        
        swith.addTarget(nil, action: #selector(tapSwith), for: .touchUpInside)
        return swith
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
        textField.returnKeyType = .next
        textField.accessibilityIdentifier = "LoginTF"
        return textField
    }()
    
    lazy private var passwordTextField: UITextField = {
        let textField = getTextField()
        textField.placeholder = Resources.TitleView.AuthView.placeholderPassword.rawValue
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.tag = TextFieldTags.password.rawValue
        textField.returnKeyType = .done
        textField.accessibilityIdentifier = "PasswordTF"
        return textField
    }()
    
    private func getLabel() -> UILabel {
        
        let label = UILabel()
        label.textColor = Resources.Color.lightPoisonousGreen
        let font = UIFont.systemFont(ofSize: 18)
        label.font = font
        return label
    }
    
    lazy var titleLabel: UILabel = {
        let label = getLabel()
        label.textColor = Resources.Color.poisonousGreen
        
        if self.autOrRegSwich.isOn {
            label.text = "Authorization"
        } else {
            label.text = "Registration"
        }
        
        return label
    }()
    
    private func setupContainer() {
        self.view.addSubview(mainContainer)
        self.view.addSubview(titleLabel)
        
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
        
        let xStack = UIStackView()
        xStack.axis = .horizontal
        xStack.distribution = .equalSpacing
        xStack.spacing = 20
        xStack.addArrangedSubview(loginLabel)
        xStack.addArrangedSubview(autOrRegSwich)
        
        let passwordLabel = getLabel()
        passwordLabel.text = Resources.TitleView.AuthView.titleLabelPassword.rawValue
        
        yStack.addArrangedSubview(xStack)
        yStack.addArrangedSubview(loginTextField)
        yStack.addArrangedSubview(passwordLabel)
        yStack.addArrangedSubview(passwordTextField)
        
        mainContainer.addSubview(yStack)
        mainContainer.addSubview(buttonSignIn)
        
        xStack.snp.makeConstraints { make in
            make.leading.trailing.equalTo(mainContainer).inset(16)
        }
        
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
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(mainContainer.snp_topMargin).inset(-16)
        }
    }
    
    @objc private func actionButton() {
        
        if self.autOrRegSwich.isOn {
            
            presenter.enterUser()
            
        } else {
            view.endEditing(true)
            presenter.signIn()
        }
    }
    
    @objc private func tapSwith() {
        
        UIView.animate(withDuration: 0.1, delay: 0.1) {
            if self.autOrRegSwich.isOn {
                
                self.buttonSignIn.setTitle(Resources.TitleView.AuthView.titleButtonEnter.rawValue, for: .normal)
                self.mainContainer.backgroundColor = Resources.Color.grayButtonInoutBackGround
                self.titleLabel.text = Resources.TitleView.AuthView.titleAuthorization.rawValue
            } else {
                
                self.buttonSignIn.setTitle(Resources.TitleView.AuthView.titleButtonDef.rawValue, for: .normal)
                self.mainContainer.backgroundColor = Resources.Color.blackGrayBackGround
                self.titleLabel.text = Resources.TitleView.AuthView.titleRegistration.rawValue
            }
        }
    }
    
}

extension AuthViewController: AuthViewProtocol {
    
    //MARK: - protocol method
    
    func getloginUser() -> String? {
        self.loginTextField.text
    }
    
    func getPassswordUser() -> String? {
        self.passwordTextField.text
    }
    
    func alertErrorUserLife() {
        presentAlert(title: Resources.TitleView.AuthView.AlertError.alertUserLife.title,
                     message: Resources.TitleView.AuthView.AlertError.alertUserLife.message)
    }
    
    func alertErrorNotPassword() {
        presentAlert(title: Resources.TitleView.AuthView.AlertError.alertNotPassword.title,
                     message: Resources.TitleView.AuthView.AlertError.alertNotPassword.message)
    }
    
    func alertErrorInvalidePassword() {
        presentAlert(title: Resources.TitleView.AuthView.AlertError.alertInvalidPassword.title,
                     message: Resources.TitleView.AuthView.AlertError.alertInvalidPassword.title)
    }
    
    private func presentAlert(title: String, message: String) {
        
        let errorAlert = UIAlertController(title: title,
                                           message: message,
                                           preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        errorAlert.addAction(cancel)
        self.present(errorAlert,animated: true)
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
            self.actionButton()
        default:
            return false
        }
        
        return true
    }
    
}
