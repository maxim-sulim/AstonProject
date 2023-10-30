//
//  AuthPresenter.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
    var router: AuthRouterProtocol! { get set }
    func signIn()
    func closeAuth()
}

final class AuthPresenter {
    
    var router: AuthRouterProtocol!
    var interactor: AuthInteractorProtocol!
    weak var view: AuthViewProtocol!
    
    init(view: AuthViewProtocol) {
        self.view = view
    }
    
}

extension AuthPresenter: AuthPresenterProtocol {
    
    func closeAuth() {
        
        if interactor.isLoaded {
            router.openNextViewController()
        }
// else alert error
    }
    
    func signIn() {
        
        guard let login = view.getloginUser(), login.count > 0 else {
            return
        }
        
        guard let paswword = view.getPassswordUser(), paswword.count > 0 else {
            return
        }
        
        let user: UserProtocol = User(login: login, password: paswword)
        
        interactor.authSignIn(user: user)
    }
    
    
}

