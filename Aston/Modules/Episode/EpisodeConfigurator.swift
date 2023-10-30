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
        let presenter = EpisodePresenter(view: viewController)
        let interactor = EpisodeInteractor(presenter: presenter)
        let router = EpisodeRouter(viewController: viewController)
        
        presenter.router = router
        presenter.interactor = interactor
        viewController.presenter = presenter
    }
    
}

