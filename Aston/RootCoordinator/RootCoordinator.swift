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
    private var navController: UINavigationController?
    var storage: UserStorageProtocol = UserStorage()
    
   lazy var isSignIn: Bool = {
       
       let lastLogin = storage.returnLastLogin()
       return storage.isAuthLogin(login: lastLogin)
       
    }()
    
    init(scene: UIWindowScene) {
        
        self.navController = UINavigationController()
        
        let window = UIWindow(windowScene: scene)
        window.backgroundColor = Resources.Color.blackBackGround
        window.rootViewController = navController
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
        navController?.setViewControllers([splash], animated: false)
    }
    
    private func showVC() {
        
        if !isSignIn {
            
            let vc = AuthViewController()
            navController?.setViewControllers([vc], animated: true)
            self.authVc = vc
            
        } else {
            
            let vc = TabBarController()
            navController?.setViewControllers([vc], animated: true)
            self.tabBarVc = vc
            
        }
    }
    
}
