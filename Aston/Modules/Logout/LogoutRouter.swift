//
//  LogoutRouter.swift
//  Aston
//
//  Created by Максим Сулим on 19.10.2023.
//

import Foundation


protocol LogoutRouterProtocol: AnyObject {
    func presentAuthScene()
}

final class LogoutRouter {
    
    weak var viewController: LogoutViewController!
    
    init(viewController: LogoutViewController!) {
        self.viewController = viewController
    }
    
}

extension LogoutRouter: LogoutRouterProtocol {
    
    func presentAuthScene() {
    
    }
    
}
