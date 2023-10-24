//
//  CharsRouter.swift
//  Aston
//
//  Created by Максим Сулим on 12.10.2023.
//

import Foundation


protocol CharsRouterProtocol: AnyObject {
    func showEpisodeScene(episodes: [String])
}

final class CharsRouter {
    
    weak var viewController: CharsViewController!
    
    init(viewController: CharsViewController) {
        self.viewController = viewController
    }
    
}

extension CharsRouter: CharsRouterProtocol {
    
    func showEpisodeScene(episodes: [String]) {
        let vc: EpisodeViewProtocol = EpisodeViewController()
        viewController.dismiss(animated: true)
        viewController.navigationController?.pushViewController(vc as! EpisodeViewController, animated: true)
        vc.configureView(episodes: episodes)
    }
    
}
