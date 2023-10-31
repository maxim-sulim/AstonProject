//
//  LogoutInteractor.swift
//  Aston
//
//  Created by Максим Сулим on 19.10.2023.
//

import Foundation

protocol LogoutInteractorProtocol: AnyObject {
    ///Актуальный пользователь переходит на экран авторизаци, но сохраняет возможность автоматического входа
    func closeAutoOpen()
    ///Удаление актуального пароля
    func deleteActualPassword()
    ///Установка нового пароля
    func setNewPassword(password: String)
}

final class LogoutInteractor {
    
    private let serviceName = Resources.ServiceName.serviceName.rawValue
    var presenter: LogoutPresenterProtocol!
    var storage: UserStorageProtocol = UserStorage()
    
    init(presenter: LogoutPresenterProtocol!) {
        self.presenter = presenter
    }
    
}

extension LogoutInteractor: LogoutInteractorProtocol {
 
    func closeAutoOpen() {
        storage.isActualAuth = false
    }
    
    func setNewPassword(password: String) {
        let login = storage.returnLastLogin()
        
        do {
            try savePassword(login: login, password: password)
            
        } catch {
            //alert
        }
    }
    
    func deleteActualPassword() {
        
        let login = storage.returnLastLogin()
        
        do {
            
            try KeychainPasswordItem(service: serviceName, account: login).deleteItem()
            
            presenter.alertNewPassword()
            
        } catch {
            //alert ошибка удаления пароля
        }
        
    }
    
    private func savePassword(login: String, password: String) throws {
        
        try KeychainPasswordItem(service: serviceName, account: login).savePassword(password)
    }
    
}
