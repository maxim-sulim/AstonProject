//
//  StorageUser.swift
//  Aston
//
//  Created by Максим Сулим on 18.10.2023.
//

import Foundation


protocol UserStorageProtocol {
    ///Проверяет авторизацию пользователя по логину
    func isAuthLogin(login: String) -> Bool
    ///Добавляет логин пользователя в хранилище
    func addLoginAuth(login: String)
    ///Удаление логина из хранилища
    func outLoginAuth(login: String)
    ///Возвращает последний добавленый логин в хранилище
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
        
        let userFromStorage = storage.object(forKey: storageKey) as? [String:String] ?? [:]
        var logins = [String:String]()
        
        //Создаем новое хранилище без удаленного логина
        userFromStorage.forEach({
            if $0.key == UserKey.login.rawValue {
                
                if $0.value != login {
                    logins[$0.key] = $0.value
                }
            }
        })
        
        storage.removeObject(forKey: storageKey)
        
        if !logins.isEmpty {
            storage.set(logins, forKey: storageKey)
        }
        
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
