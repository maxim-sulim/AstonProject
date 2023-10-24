//
//  StorageUser.swift
//  Aston
//
//  Created by Максим Сулим on 18.10.2023.
//

import Foundation


protocol UserStorageProtocol {
    func isAuthLogin(login: String) -> Bool
    func addLoginAuth(login: String)
    func outLoginAuth(login: String)
    func returnLastLogin() -> String
}

final class UserStorage: UserStorageProtocol {
    
     var storage = UserDefaults.standard
    
    private let storageKey = "user"
    
    private enum UserKey: String {
        case login
    }

    func isAuthLogin(login: String) -> Bool {
        
        let userFromStorage = storage.object(forKey: storageKey) as? [String:String] ?? [:]
        var isLoaded = false
        
        userFromStorage.forEach({
            if $0.key == UserKey.login.rawValue {
                
                if $0.value == login {
                    isLoaded = true
                }
            }
        })
        
        return isLoaded
    }
    
    func addLoginAuth(login: String) {
        var user = [String:String]()
        user[UserKey.login.rawValue] = login
        storage.set(user, forKey: storageKey)
    }
    
    func outLoginAuth(login: String) {
        
        storage.removeObject(forKey: storageKey)
        
    }
    
    func returnLastLogin() -> String {
        
        var login = ""
        let userFromStorage = storage.object(forKey: storageKey) as? [String:String] ?? [:]
        
        userFromStorage.forEach({
            if $0.key == UserKey.login.rawValue {
                login = $0.value
            }
        })
        
        return login
    }
    
    
}
