//
//  LogoutInteractor.swift
//  Aston
//
//  Created by Максим Сулим on 19.10.2023.
//

import Foundation

protocol LogoutInteractorProtocol: AnyObject {
    func deletelogin()
}

final class LogoutInteractor {
    
    var presentor: LogoutPresenterProtocol!
    var storage: UserStorageProtocol = UserStorage()
    
    init(presentor: LogoutPresenterProtocol!) {
        self.presentor = presentor
    }
    
    
    
}

extension LogoutInteractor: LogoutInteractorProtocol {
 
    func deletelogin() {
        let login = storage.returnLastLogin()
        storage.outLoginAuth(login: login)
        
        presentor.authScene()
    }
    
}
