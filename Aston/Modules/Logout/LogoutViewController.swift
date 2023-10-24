//
//  LogoutViewController.swift
//  Aston
//
//  Created by Максим Сулим on 19.10.2023.
//

import UIKit
import SnapKit

protocol LogoutViewProtocol: AnyObject {
    
}

final class LogoutViewController: UIViewController {

    
    var presentor: LogoutPresenterProtocol!
    let configurator: LogoutConfiguratorProtocol = LogoutConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        setupView()
    }
    
    private var logoutButton: UIButton = {
        let button = UIButton()
        button.tintColor = Resources.Color.poisonousGreen
        
        var configure = UIButton.Configuration.filled()
        configure.title = "OUT"
        configure.subtitle = "Delete my login"
        configure.background.backgroundColor = Resources.Color.blackGrayBackGround
        configure.buttonSize = .large
        configure.cornerStyle = .capsule
        
        button.configuration = configure
        button.addTarget(nil, action: #selector(tapOut), for: .touchUpInside)
        
        button.layer.shadowRadius = 20
        button.layer.shadowOpacity = 0.6
        button.layer.shadowOffset = CGSize(width: 1, height: 20)
        return button
    }()
    
    private func setupView() {
        view.addSubview(logoutButton)
        makeConstraint()
    }
    
    private func makeConstraint() {
        logoutButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc private func tapOut() {
        presentor.tapOut()
    }

}


extension LogoutViewController: LogoutViewProtocol {
    
}
