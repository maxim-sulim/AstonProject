//
//  LogoutConfigurator.swift
//  Aston
//
//  Created by Максим Сулим on 19.10.2023.
//

import Foundation

protocol LogoutConfiguratorProtocol {
    func configure(with viewController: LogoutViewController)
}

final class LogoutConfigurator: LogoutConfiguratorProtocol {
    
    func configure(with viewController: LogoutViewController) {
        
        let presenter = LogoutPresenter(view: viewController)
        let interactor = LogoutInteractor(presenter: presenter)
        let router = LogoutRouter(viewController: viewController)
        
        presenter.interactor = interactor
        presenter.router = router
        viewController.presenter = presenter
    }
    
}

