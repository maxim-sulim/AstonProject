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
        
        let presentor = LogoutPresenter(view: viewController)
        let interactor = LogoutInteractor(presentor: presentor)
        let router = LogoutRouter(viewController: viewController)
        
        presentor.interactor = interactor
        presentor.router = router
        viewController.presentor = presentor
    }
    
}

