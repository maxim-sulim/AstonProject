//
//  AppColtroller.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import UIKit


final class RootCoordinator {
    
    var window: UIWindow!
    private weak var authVc: AuthViewController?
    private weak var tabBarVc: TabBarController?
    private let navigationController: UINavigationController
    
    var isSignIn: Bool = {
        let isSign = true
        return isSign
    }()
    
    init(scene: UIWindowScene) {
        navigationController = UINavigationController()
        
        let window = UIWindow(windowScene: scene)
        window.backgroundColor = Resources.Color.blackBackGround
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }
    
    func start() {
        setup()
        showVC()
    }
    
    private func setup() {
        let splash = UIStoryboard(name: "LaunchScreen", bundle: nil)
            .instantiateViewController(withIdentifier: "LaunchScreen")
        navigationController.setViewControllers([splash], animated: false)
    }
    
    private func showVC() {
        
        if !isSignIn {
            
            let vc = AuthViewController()
            navigationController.setViewControllers([vc], animated: true)
            self.authVc = vc
            
        } else {
            
            let vc = TabBarController()
            navigationController.setViewControllers([vc], animated: true)
            self.tabBarVc = vc
            
        }
    }
    
}
