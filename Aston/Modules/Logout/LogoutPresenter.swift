//
//  LogoutPresenter.swift
//  Aston
//
//  Created by Максим Сулим on 19.10.2023.
//

import Foundation


protocol LogoutPresenterProtocol: AnyObject {
    ///Выход на сцену авторизации без сохранения пароля
    func exitMainFlowDeleteLogin()
    ///Выход на сцену авторизации c сохранением пароля
    func exitMainFlowSaveLogin()
    ///Изменение пароля авторизированного логина
    func tapEditbutton()
    ///Сохраняет новый пароль
    func enterNewPassword(password: String)
}


final class LogoutPresenter {
    
    var router: LogoutRouterProtocol!
    var interactor: LogoutInteractorProtocol!
    weak var view: LogoutViewProtocol!
    
    
    init(view: LogoutViewProtocol) {
        self.view = view
    }
    
}

extension LogoutPresenter: LogoutPresenterProtocol {
    
    func enterNewPassword(password: String) {
        
        guard password.count > 0  else { return }
        
        interactor.setNewPassword(password: password)
    }
    
    func tapEditbutton() {
        view.alertEditPassword()
    }
    
    func exitMainFlowSaveLogin() {
        interactor.closeAutoOpen()
        router.presentAuthScene()
    }
    
    func exitMainFlowDeleteLogin(){
        interactor.deleteLogin()
        router.presentAuthScene()
    }
}
