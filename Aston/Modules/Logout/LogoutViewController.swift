//
//  LogoutViewController.swift
//  Aston
//
//  Created by Максим Сулим on 19.10.2023.
//

import UIKit
import SnapKit

protocol LogoutViewProtocol: AnyObject {
    func alertEditPassword()
}

final class LogoutViewController: UIViewController {

    var presenter: LogoutPresenterProtocol!
    let configurator: LogoutConfiguratorProtocol = LogoutConfigurator()
    var rootCoordinator: RootCoordinatorProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        setupView()
    }
    
    init(rootCoordinator: RootCoordinatorProtocol) {
        self.rootCoordinator = rootCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var logoutButton: UIButton = {
        let button = getButtonCapsule()
        
        button.addTarget(nil, action: #selector(tapOut), for: .touchUpInside)
        button.configuration?.title = Resources.TitleView.LogoutView.outButton.title
        button.configuration?.subtitle = Resources.TitleView.LogoutView.outButton.subtitle
        return button
    }()
    
    lazy private var editPasswordButton: UIButton = {
        let button = getButtonCapsule()
        
        button.addTarget(nil, action: #selector(editPassword), for: .touchUpInside)
        button.configuration?.title = Resources.TitleView.LogoutView.editButton.title
        button.configuration?.subtitle = Resources.TitleView.LogoutView.editButton.subtitle
        return button
    }()
    
    private func getButtonCapsule() -> UIButton {
        let button = UIButton()
        button.tintColor = Resources.Color.poisonousGreen
        
        var configure = UIButton.Configuration.filled()
        configure.background.backgroundColor = Resources.Color.blackGrayBackGround
        configure.buttonSize = .large
        configure.cornerStyle = .capsule
        
        button.configuration = configure
        
        button.layer.shadowRadius = 20
        button.layer.shadowOpacity = 0.6
        button.layer.shadowOffset = CGSize(width: 1, height: 20)
        return button
    }
   
    
    private func setupView() {
        makeConstraint()
    }
    
    private func makeConstraint() {
        
        let yStack = UIStackView()
        yStack.axis = .horizontal
        yStack.spacing = 20
        yStack.distribution = .fillEqually
        yStack.addArrangedSubview(logoutButton)
        yStack.addArrangedSubview(editPasswordButton)
        
        view.addSubview(yStack)
        
        yStack.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(20)
            make.center.equalToSuperview()
        }
    }
    
    @objc private func tapOut() {
       alertLogin()
    }
    
    @objc private func editPassword() {
        presenter.tapEditbutton()
    }

}

extension LogoutViewController: LogoutViewProtocol {
    
    func alertEditPassword() {
        presentAlertPassword()
    }
    
    private func presentAlertPassword() {
        
        let editPassword = UIAlertController(title: Resources.TitleView.LogoutView.alertEditPassword.title,
                                             message: Resources.TitleView.LogoutView.alertEditPassword.message,
                                             preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let enter = UIAlertAction(title: "Enter", style: .default) { [self] enter in
            presenter.enterNewPassword(password: (editPassword.textFields?.saveObject(at: 0)?.text) ?? "")
        }
        
        editPassword.addTextField() { password in
            password.placeholder = Resources.TitleView.LogoutView.alertEditPassword.placeholderTextField
            password.isSecureTextEntry = true
        }
        
        editPassword.addAction(cancel)
        editPassword.addAction(enter)
        
        
        self.present(editPassword, animated: true)
    }
    
    private func alertLogin() {
        
        let login = UIAlertController(title: "Exit",
                                             message: "Exit and save login?",
                                             preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let saveLogin = UIAlertAction(title: "Save", style: .default) { [self] enter in
            self.presenter.exitMainFlowSaveLogin()
        }
        
        let deleteLogin = UIAlertAction(title: "Delete login", style: .destructive) { [self] enter in
            self.presenter.exitMainFlowDeleteLogin()
        }
        
        login.addAction(cancel)
        login.addAction(saveLogin)
        login.addAction(deleteLogin)
        
        self.present(login, animated: true)
    }
    
}
