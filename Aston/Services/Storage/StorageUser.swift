//
//  StorageUser.swift
//  Aston
//
//  Created by Максим Сулим on 18.10.2023.
//

import Foundation


protocol UserStorageProtocol {
    ///Проверяет, подключен ли автоматический вход для актуального логина
    func isAuthorizationLogin() -> Bool
    ///Проверяет, зарегестрирован ли актуальный логин пользователя, чтобы отображать на экране авторизации
    func isActualLogin() -> Bool
    ///Проверка наличия логина в хранилище
    func isLogin(login: String) -> Bool
    ///Добавляет логин пользователя в хранилище
    func addLoginAuth(login: String)
    ///Удаление авторизированного пользователя
    func deleteUserAuth()
    ///Выход из актуальной авторизации с сохранением вохможности входа по логину
    func exitGlobalAuth()
    /// удаляет хранилище
    func deleteFullLogins()
    ///Возвращает актуальный логин
    func getActualLogin() -> String?
}
///Хранилище хранит словарь с двумя доступными ключами:
final class UserStorage: UserStorageProtocol {
    
    //Публичный, для подмены на мок на время тестов
    var storage = UserDefaults.standard
    private let serviceName = Resources.ServiceName.serviceName.rawValue
    
    ///Ключ для хранилища логинов пользователей
    private let userKey = "userKey"
    
    ///Ключи для хранение логинов: в словаре существует максимум 1 актуальный логин для автоматической авторизации и остальные логины с регистрацией.
    private enum UserKey: String {
        case auth
        ///Подразумевается, что с данным ключом существует только один логин - актуальный
        case actualLogin
    }
    
    func isActualLogin() -> Bool {
        
        var isLoaded = false
        
        let userFromStorage = storage.object(forKey: userKey) as? [String:[String:Bool]] ?? [:]
        
        if let actualLogin = userFromStorage[UserKey.actualLogin.rawValue] {
            
            if let value = actualLogin.first?.value {
                isLoaded = value
            }
        }
        
        return isLoaded
    }
    
    func isAuthorizationLogin() -> Bool {
        
        var isLoaded = false
        
        let userFromStorage = storage.object(forKey: userKey) as? [String:[String:Bool]] ?? [:]
        
        if let actualLogin = getActualLogin() {
            
            if let auth = userFromStorage[actualLogin] {
                if let value = auth.first?.value {
                    isLoaded = value
                }
            }
        }
        
        return isLoaded
        
    }
    
    func addLoginAuth(login: String) {
        var userFromStorage = storage.object(forKey: userKey) as? [String:[String:Bool]] ?? [:]
        
        userFromStorage[login] = [UserKey.auth.rawValue: true]
        userFromStorage[UserKey.actualLogin.rawValue] = [login: true]
        storage.set(userFromStorage, forKey: userKey)
        
    }
    
    func deleteUserAuth() {
        
        var userFromStorage = storage.object(forKey: userKey) as? [String:[String:Bool]] ?? [:]
        
        //Создаем новое хранилище без удаленного логина
        
        if let actualLogin = userFromStorage[UserKey.actualLogin.rawValue] {
            userFromStorage[UserKey.actualLogin.rawValue] = nil
            
            if let login = actualLogin.first?.key {
                userFromStorage[login] = nil
                deletePassword(login: login)
            }
        }
        
        storage.removeObject(forKey: userKey)
        
        if !userFromStorage.isEmpty {
            storage.set(userFromStorage, forKey: userKey)
        }
    }
    
    func deleteFullLogins() {
        storage.removeObject(forKey: userKey)
    }
    
    func exitGlobalAuth() {
        
        var userFromStorage = storage.object(forKey: userKey) as? [String:[String:Bool]] ?? [:]
        
        if let _ = userFromStorage[UserKey.actualLogin.rawValue] {
            
            //Изменяем авторизацию у актуального логина
            if let login = userFromStorage[UserKey.actualLogin.rawValue]?.first?.key {
                userFromStorage[UserKey.actualLogin.rawValue] = [login: true]
                
                //Изменяем авторизацию в общем словаре логинов
                userFromStorage.forEach() {
                    if $0.key == login {
                        userFromStorage[$0.key] = [login: false]
                    }
                }
                
            }
        }
        
        storage.removeObject(forKey: userKey)
        storage.set(userFromStorage, forKey: userKey)
        
    }
    
    func getActualLogin() -> String? {
        
        var resultLogin: String?
        let userFromStorage = storage.object(forKey: userKey) as? [String:[String:Bool]] ?? [:]
        
        if let actualLogin = userFromStorage[UserKey.actualLogin.rawValue] {
            
            if let login = actualLogin.first?.key {
                resultLogin = login
            }
        }
        
        return resultLogin
    }
    
    func isLogin(login: String) -> Bool {
        var result = false
        let userFromStorage = storage.object(forKey: userKey) as? [String:[String:Bool]] ?? [:]
        
        userFromStorage.forEach() {
            if $0.key == login {
                result = true
            }
        }
        
        return result
    }
    
    private func deletePassword(login: String) {
        
        do {
            
            try KeychainPasswordItem(service: serviceName, account: login).deleteItem()
            
        } catch {
            return
        }
        
    }
}
