//
//  SceneDelegate.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var rootCoordinator: RootCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        rootCoordinator = RootCoordinator(scene: scene)
        rootCoordinator?.configure()
        window = rootCoordinator?.window
        
    }

}

