//
//  TabBarController.swift
//  Aston
//
//  Created by Максим Сулим on 10.10.2023.
//

import UIKit

enum TabItem: Int {
    case chars = 0
    case logout
}

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
    }
    var rootCoordinator: RootCoordinatorProtocol
    
    init(rootCoordinator: RootCoordinatorProtocol) {
        self.rootCoordinator = rootCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupview() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        tabBar.backgroundColor = Resources.Color.blackGrayBackGround
        tabBar.tintColor = .white
        tabBar.barTintColor = Resources.Color.blackGrayBackGround.withAlphaComponent(0.5)
        tabBar.layer.masksToBounds = true
        
        
        let charsController = CharsViewController()
        let logoutController = LogoutViewController(rootCoordinator: rootCoordinator)
        
        let charsNavigation = UINavigationController(rootViewController: charsController)
        let logotNavigation = UINavigationController(rootViewController: logoutController)
        
        let imageChars = UIImage.init(systemName: "person.2.circle.fill")
        let imageOut = UIImage.init(systemName: "delete.left.fill")
        
        charsNavigation.tabBarItem = UITabBarItem(title: Resources.TitleView.TabBarItemTitle.chars.rawValue,
                                                  image: imageChars,
                                                  tag: TabItem.chars.rawValue)
        
        logotNavigation.tabBarItem = UITabBarItem(title: Resources.TitleView.TabBarItemTitle.logout.rawValue,
                                                   image: imageOut,
                                                   tag: TabItem.logout.rawValue)
        
        setViewControllers([
            charsNavigation,
            logotNavigation], animated: false)
        
    }
    

}
