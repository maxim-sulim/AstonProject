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
        presenter.tapOut()
    }

}

extension LogoutViewController: LogoutViewProtocol {
    
}
