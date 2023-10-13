//
//  CharsRouter.swift
//  Aston
//
//  Created by Максим Сулим on 12.10.2023.
//

import Foundation


protocol CharsRouterProtocol: AnyObject {
    
}

final class CharsRouter: CharsRouterProtocol {
    
    weak var viewController: CharsViewController!
    
    init(viewController: CharsViewController) {
        self.viewController = viewController
    }
    
}
