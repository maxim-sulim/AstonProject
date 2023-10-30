//
//  CharsConfigurator.swift
//  Aston
//
//  Created by Максим Сулим on 12.10.2023.
//

import Foundation


protocol CharsConfiguratorProtocol: AnyObject {
    func configureController(with viewController: CharsViewController)
}

final class CharsConfigurator: CharsConfiguratorProtocol {
    
    func configureController(with viewController: CharsViewController) {
        
        let presenter = CharsPresenter(view: viewController)
        let interactor = CharsInteractor(presenter: presenter)
        let router = CharsRouter(viewController: viewController)
        
        presenter.interactor = interactor
        presenter.router = router
        viewController.presenter = presenter
    }
    
}
