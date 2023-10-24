//
//  AuthInteractor.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import Foundation

protocol AuthInteractorProtocol {
    func authSignIn(user: UserProtocol)
    var isLoaded: Bool { get }
}

final class AuthInteractor {
    
    weak var presenter: AuthPresenterProtocol!
    var storage: UserStorageProtocol = UserStorage()
    
    init(presenter: AuthPresenterProtocol) {
        self.presenter = presenter
    }
    
    private let serviceName = "AstonUser"
    
    private func authUser(login: String, password: String) throws {
        
        try KeychainPasswordItem(service: serviceName, account: login).savePassword(password)
        
        storage.addLoginAuth(login: login)
    }
    
}



extension AuthInteractor: AuthInteractorProtocol {
    
    func authSignIn(user: UserProtocol) {
        //проверка валидности пароля
        
        do {
            try authUser(login: user.login, password: user.password)
            presenter.closeAuth()
        } catch {
            print("Error \(error.localizedDescription)")
        }
        
    }
    
    var isLoaded: Bool {
        
        let login = storage.returnLastLogin()
        
        do {
            
            let password = try KeychainPasswordItem(service: serviceName, account: login).readPassword()
            return password.count > 0
            
        } catch {
            return false
        }
    }
    
}
