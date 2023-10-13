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
        
        let presentor = CharsPresentor(view: viewController)
        let interactor = CharsInteractor(presentor: presentor)
        let router = CharsRouter(viewController: viewController)
        
        presentor.interactor = interactor
        presentor.router = router
        viewController.presentor = presentor
    }
    
}
