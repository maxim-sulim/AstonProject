//
//  LogoutInteractor.swift
//  Aston
//
//  Created by Максим Сулим on 19.10.2023.
//

import Foundation

protocol LogoutInteractorProtocol: AnyObject {
    ///Удаление авторизованного логина
    func deletelogin()
}

final class LogoutInteractor {
    
    var presenter: LogoutPresenterProtocol!
    var storage: UserStorageProtocol = UserStorage()
    
    init(presenter: LogoutPresenterProtocol!) {
        self.presenter = presenter
    }
    
    
    
}

extension LogoutInteractor: LogoutInteractorProtocol {
 
    func deletelogin() {
        let login = storage.returnLastLogin()
        storage.outLoginAuth(login: login)
        
        presenter.authScene()
    }
    
}
