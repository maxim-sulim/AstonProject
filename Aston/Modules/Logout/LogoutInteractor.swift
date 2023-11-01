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
    
    func deleteLogin()
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
 
    func deleteLogin() {
        storage.deleteUserAuth()
        storage.deleteFullLogins()
    }
    
    func closeAutoOpen() {
        storage.exitGlobalAuth()
    }
    
    func setNewPassword(password: String) {
        
        if let login = storage.getActualLogin() {
            
            do {
                deleteActualPassword(login: login)
                
                try savePassword(login: login, password: password)
                
            } catch {
                //alert
            }
        }
        
    }
    
    private func deleteActualPassword(login: String) {
        
        do {
            
            try KeychainPasswordItem(service: serviceName, account: login).deleteItem()
            
        } catch {
            //alert ошибка удаления пароля
        }
    }
    
    private func savePassword(login: String, password: String) throws {
        
        try KeychainPasswordItem(service: serviceName, account: login).savePassword(password)
    }
    
}
