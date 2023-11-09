//
//  AuthPresenter.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
    var router: AuthRouterProtocol! { get set }
    ///Регистрирует пользователя по логину
    func signIn()
    ///Завершиет авторизацию и переходит на основной userFlow
    func closeAuth()
    ///Проверяет наличие регистрации пользователя и переходит на основной UserFlow
    func enterUser()
    
    var isAuth: Bool { get set }
    
    func errorUserLife()
}

final class AuthPresenter {
    
    var router: AuthRouterProtocol!
    var interactor: AuthInteractorProtocol!
    weak var view: AuthViewProtocol!
    
    init(view: AuthViewProtocol) {
        self.view = view
    }
    
    lazy var isAuth: Bool = {
        return interactor.isAuthLog()
    }()
    
}

extension AuthPresenter: AuthPresenterProtocol {
    
    func errorUserLife() {
        view.alertErrorUserLife()
    }
    
    func enterUser() {
        
        guard let login = view.getloginUser(), login.count > 0 else {
            return
        }
        
        guard let paswword = view.getPassswordUser(), paswword.count > 0 else {
            return
        }
        
        let user: UserProtocol = User(login: login, password: paswword)
        
        if interactor.isLoaded(user: user) {
            
            router.openNextViewController()
            
        } else {
            
            view.alertErrorNotPassword()
        }
    }
    
    func closeAuth() {
        
        router.openNextViewController()
    }
    
    func signIn() {
        
        guard let login = view.getloginUser(), login.count > 0 else {
            return
        }
        
        guard let paswword = view.getPassswordUser(), paswword.count > 1 else {
            view.alertErrorInvalidePassword()
            return
        }
        
        let user: UserProtocol = User(login: login, password: paswword)
        
        interactor.authSignIn(user: user)
    }
    
}

