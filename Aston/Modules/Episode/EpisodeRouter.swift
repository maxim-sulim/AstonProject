//
//  EpisodeRouter.swift
//  Aston
//
//  Created by Максим Сулим on 13.10.2023.
//

import Foundation

protocol EpisodeRouterProtocol: AnyObject {
    
}

final class EpisodeRouter {
    
    weak var viewController: EpisodeViewController!
    
    init(viewController: EpisodeViewController!) {
        self.viewController = viewController
    }
    
}

extension EpisodeRouter: EpisodeRouterProtocol {
    
    
}
