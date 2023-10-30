//
//  SplashViewController.swift
//  Aston
//
//  Created by Максим Сулим on 24.10.2023.
//

import UIKit
import SnapKit

///Дефолтный контроллер RootViewController, решает последовательность UserFlow
final class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    let activityIndicator = UIActivityIndicatorView()
    weak var rootDelegate: RootCoordinatorProtocol?
    
    init(rootDelegate: RootCoordinatorProtocol) {
        self.rootDelegate = rootDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {

        makeSrvises()
        makeView()
    }
    
    private func makeView() {
        
        activityIndicator.style = .large
        activityIndicator.backgroundColor = Resources.Color.blackBackGround
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.color = Resources.Color.poisonousGreen
        
    }
    
    private func makeSrvises() {
        
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            
            self.activityIndicator.stopAnimating()
            
            guard let isSign = self.rootDelegate?.rootViewCoordinator?.isAuthLogin() else {
                //Alert
                return
            }
            
            if isSign {
                
                self.rootDelegate?.rootViewCoordinator?.swithToMainScreen()
                
            } else {
                
                self.rootDelegate?.rootViewCoordinator?.showAuthScreen()
            }
            
        }
        
    }

}
