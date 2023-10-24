//
//  EpisodeConfigurator.swift
//  Aston
//
//  Created by Максим Сулим on 13.10.2023.
//

import Foundation


protocol EpisodeConfiguratorProtocol: AnyObject {
    func configureView(with viewController: EpisodeViewController)
}

final class EpisodeConfigurator: EpisodeConfiguratorProtocol {
    
    func configureView(with viewController: EpisodeViewController) {
        let presentor = EpisodePresentor(view: viewController)
        let interactor = EpisodeInteractor(presentor: presentor)
        let router = EpisodeRouter(viewController: viewController)
        
        presentor.router = router
        presentor.interactor = interactor
        viewController.presentor = presentor
    }
    
}

