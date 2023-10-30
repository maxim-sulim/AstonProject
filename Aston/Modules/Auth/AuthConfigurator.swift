//
//  AuthConfigurator.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import Foundation

protocol AuthConfiguratorProtocol: AnyObject {
    func configure(with viewController: AuthViewController)
}

final class AuthConfigurator: AuthConfiguratorProtocol {
    
    
    func configure(with viewController: AuthViewController) {
        
        let presenter = AuthPresenter(view: viewController)
        let interactor = AuthInteractor(presenter: presenter)
        let router = AuthRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
    
}
