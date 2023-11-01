//
//  AuthInteractor.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import Foundation

protocol AuthInteractorProtocol {
    func isAuthLog() -> Bool
    func authSignIn(user: UserProtocol)
    func isLoaded(user: UserProtocol) -> Bool
}

final class AuthInteractor {
    
    weak var presenter: AuthPresenterProtocol!
    var storage: UserStorageProtocol = UserStorage()
    
    init(presenter: AuthPresenterProtocol) {
        self.presenter = presenter
    }
    
    private let serviceName = Resources.ServiceName.serviceName.rawValue
    
    private func authUser(login: String, password: String) throws {
        
        try KeychainPasswordItem(service: serviceName, account: login).savePassword(password)
        
        storage.addLoginAuth(login: login)
    }
    
}

extension AuthInteractor: AuthInteractorProtocol {
    
    func isAuthLog() -> Bool {
        return storage.isActualLogin()
    }
    
    func authSignIn(user: UserProtocol) {
        
        //проверка на существующего юзера
        guard !storage.isLogin(login: user.login) else {
            presenter.errorUserLife()
            return
        }
        
        do {
            try authUser(login: user.login, password: user.password)
            
            presenter.closeAuth()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func isLoaded(user: UserProtocol) -> Bool {
        
        let login = user.login
        
        do {
            
            let password = try KeychainPasswordItem(service: serviceName, account: login).readPassword()
            
            return password == user.password ? true : false
            
        } catch {
            return false
        }
    }
    
}
