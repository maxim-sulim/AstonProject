//
//  AppColtroller.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import UIKit


protocol RootCoordinatorProtocol: AnyObject {
    var rootViewCoordinator: RootViewControllerProtocol? { get }
}

final class RootCoordinator: RootCoordinatorProtocol {
    
    var window: UIWindow!
    var rootViewCoordinator: RootViewControllerProtocol?
    private var rotVc: RootViewController?
    
    init(scene: UIWindowScene) {
        
        let window = UIWindow(windowScene: scene)
        window.backgroundColor = Resources.Color.blackBackGround
        self.window = window
    }
    
    func configure() {
        
        let vc = RootViewController(rootDelegate: self)
        self.rotVc = vc
        self.rootViewCoordinator = rotVc
        self.window.rootViewController = rotVc
        self.window.makeKeyAndVisible()
        
    }
    
}

