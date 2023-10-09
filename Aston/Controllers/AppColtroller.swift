//
//  AppColtroller.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import UIKit


class AppController {
    
    static let shared = AppController()
    
    var window: UIWindow!
    
    var rootViewController: UIViewController! {
        didSet {
            if let vc = rootViewController {
                window.rootViewController = vc
            }
        }
    }
    
    func show(in window: UIWindow?) {
        
        guard let window = window else {
            fatalError("nil window.")
        }
        
        window.backgroundColor = Resources.Color.blackBackGround
        self.window = window
        
    }
    
}
