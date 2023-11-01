//
//  RootViewController.swift
//  Aston
//
//  Created by Максим Сулим on 24.10.2023.
//

import UIKit


protocol RootViewControllerProtocol: AnyObject {
    func isAuthLogin() -> Bool
    func showAuthScreen()
    func swithToMainScreen()
    func swithToAuth()
}

///Стартовый, самый старший котнроллер окна
final class RootViewController: UIViewController {

    var storage: UserStorageProtocol = UserStorage()
    var rootCoordinator: RootCoordinatorProtocol
    var currentVc: UIViewController
    
    lazy var isSignIn: Bool = {
        
        return storage.isAuthorizationLogin()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    init(rootDelegate: RootCoordinatorProtocol) {
        
        self.rootCoordinator = rootDelegate
        self.currentVc = SplashViewController(rootDelegate: rootCoordinator)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addChild(currentVc)
        currentVc.view.frame = view.bounds
        view.addSubview(currentVc.view)
        currentVc.didMove(toParent: self)
    }
    
    private func animatedDismissTransition(to new: UIViewController, complition: (() -> Void)? = nil) {
        
        currentVc.willMove(toParent: nil)
        addChild(new)
        addChild(currentVc)
        
        transition(from: currentVc, to: new, duration: 0.3, animations: {
            
            new.view.frame = self.view.bounds
            
        }) { completed in
            
            self.currentVc.removeFromParent()
            new.didMove(toParent: self)
            self.currentVc = new
            complition?()
        }
        
    }
    
    private func animateFadeTransition(to new: UIViewController, complition: (() -> Void)? = nil) {
        
        currentVc.willMove(toParent: nil)
        addChild(new)
        
        transition(from: currentVc, to: new, duration: 0.3, animations: {
            
        }) { completed in
            self.currentVc.removeFromParent()
            new.didMove(toParent: self)
            self.currentVc = new
            complition?()
        }
    }

}

extension RootViewController: RootViewControllerProtocol {
    
    func showAuthScreen() {
        
        let new = UINavigationController(rootViewController:
                                            AuthViewController(rootCoordinator: rootCoordinator))
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        currentVc.willMove(toParent: nil)
        currentVc.view.removeFromSuperview()
        currentVc.removeFromParent()
        currentVc = new
    }
    
    func swithToMainScreen() {
        let mainViewController = TabBarController(rootCoordinator: rootCoordinator)
        animateFadeTransition(to: mainViewController)
    }
    
    //не использую, переключение на экран удаление логина
    func swithToAuth() {
        let loginViewController = LogoutViewController(rootCoordinator: rootCoordinator)
        let logoutScreen = UINavigationController(rootViewController: loginViewController)
        animatedDismissTransition(to: logoutScreen)
    }
    
    
    func isAuthLogin() -> Bool {
        return isSignIn
    }
    
}
