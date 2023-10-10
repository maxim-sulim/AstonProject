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

class AuthConfigurator: AuthConfiguratorProtocol {
    
    
    func configure(with viewController: AuthViewController) {
        
        let presentor = AuthPresenter(view: viewController)
        let interactor = AuthInteractor(presenter: presentor)
        let router = AuthRouter(viewController: viewController)
        
        viewController.presenter = presentor
        presentor.interactor = interactor
        presentor.router = router
    }
    
    
}
