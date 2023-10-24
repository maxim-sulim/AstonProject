//
//  AuthRouter.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import Foundation


protocol AuthRouterProtocol: AnyObject {
    func closeCurrentViewController()
    func openNextViewController()
}

final class AuthRouter: AuthRouterProtocol {
    
    weak var viewController: AuthViewController!
    
    init(viewController: AuthViewController) {
        self.viewController = viewController
    }
    
    func openNextViewController() {
        viewController.dismiss(animated: true)
        viewController.navigationController?.pushViewController(TabBarController(), animated: true)
    }
    
    func closeCurrentViewController() {
        
    }
    
    
}
