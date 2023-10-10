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

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    

    private func configure() {
        tabBar.backgroundColor = Resources.Color.blackGrayBackGround
        tabBar.tintColor = .white
        tabBar.barTintColor = .gray
        tabBar.layer.masksToBounds = true
        
        let charsController = CharsViewController()
        let logoutController = UIViewController()
        
        let charsNavigation = UINavigationController(rootViewController: charsController)
        let logotNavigation = UINavigationController(rootViewController: logoutController)
        
        let image = UIImage.init(systemName: "person.2.circle.fill")
        
        charsNavigation.tabBarItem = UITabBarItem(title: Resources.TitleView.TabBarItemTitle.chars.rawValue,
                                                  image: image,
                                                  tag: TabItem.chars.rawValue)
        
        logotNavigation.tabBarItem = UITabBarItem(title: Resources.TitleView.TabBarItemTitle.logout.rawValue,
                                                   image: image,
                                                   tag: TabItem.logout.rawValue)
        
        setViewControllers([
            charsNavigation,
            logotNavigation], animated: false)
        
    }
    

}
