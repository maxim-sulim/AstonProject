//
//  LogoutPresenter.swift
//  Aston
//
//  Created by Максим Сулим on 19.10.2023.
//

import Foundation


protocol LogoutPresenterProtocol: AnyObject {
    ///Выход на сцену авторизации
    func exitMainFlow()
    ///Изменение пароля авторизированного логина
    func tapEditbutton()
    ///Показывает окно ввода нового пароля
    func alertNewPassword()
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
    
    func alertNewPassword() {
        view.alertEditPassword()
    }
    
    func tapEditbutton() {
        interactor.deleteActualPassword()
    }
    
    func exitMainFlow() {
        interactor.closeAutoOpen()
        router.presentAuthScene()
    }
}
