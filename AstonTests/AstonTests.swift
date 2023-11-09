//
//  AstonTests.swift
//  AstonTests
//
//  Created by Максим Сулим on 07.11.2023.
//

import XCTest
@testable import Aston

final class AstonTests: XCTestCase {

    var storageDelegate: UserStorageProtocol?
    private var mockStorage: UserDefaults?
    private var userKey = "userKey"
    
    private enum UserKey: String {
        case auth
        case actualLogin
    }
    
    override func setUpWithError() throws {
        storageDelegate = UserStorage()
        mockStorage = MockUserDefaults.standard
        (storageDelegate as! UserStorage).storage = mockStorage!
    }

    override func tearDownWithError() throws {
        storageDelegate = nil
        mockStorage?.removeObject(forKey: userKey)
        mockStorage = nil
    }

    ///Проверка автоматического вхвода
    func testFalseAutoInput() throws {
        
        //Given
        let login = "mockLogin"
        let expectedResult = false
        var actualLogin: [String:[String:Bool]] = [:]
        // Пользоватлеь зарегистрирован
        actualLogin[UserKey.actualLogin.rawValue] = [login: true]
        // У пользовтеля не подключен автоматический вход
        actualLogin[login] = [UserKey.auth.rawValue: false]
        mockStorage?.set(actualLogin, forKey: userKey)
        
        //When
        let actualResult = storageDelegate?.isAuthorizationLogin()
        
        //Then
        XCTAssertEqual(expectedResult, actualResult)
    }

    ///Проверка автоматического входа
    func testTrueAutoInput() throws {
        
        //Given
        let login = "mockLogin"
        let expectedResult = true
        var actualUser: [String:[String:Bool]] = [:]
        // Пользоватлеь зарегистрирован
        actualUser[UserKey.actualLogin.rawValue] = [login: true]
        // У пользовтеля не подключен автоматический вход
        actualUser[login] = [UserKey.auth.rawValue: true]
        mockStorage?.set(actualUser, forKey: userKey)
        
        //When
        let actualResult = storageDelegate?.isAuthorizationLogin()
        
        //Then
        XCTAssertEqual(expectedResult, actualResult)
    }
    
    func testTrueRegistrationLogin() throws {
        
        //Given
        let expectedResult = true
        let login = "mockLogin"
        var actualUser: [String: [String: Bool]] = [:]
        actualUser[UserKey.actualLogin.rawValue] = [login: true]
        mockStorage?.set(actualUser, forKey: userKey)
        
        //When
        let actualResult = storageDelegate?.isActualLogin()
        
        //Then
        XCTAssertEqual(expectedResult, actualResult)
    }
    
    func testFalseRegistrationLogin() throws {
        
        //Given
        let expectedResult = false
        let login = "mockLogin"
        var actualUser: [String: [String: Bool]] = [:]
        actualUser[UserKey.actualLogin.rawValue] = [login: false]
        mockStorage?.set(actualUser, forKey: userKey)
        
        //When
        let actualResult = storageDelegate?.isActualLogin()
        
        //Then
        XCTAssertEqual(expectedResult, actualResult)
    }
    
    func testFalseRegistrationLoginNotUser() throws {
        
        //Given
        let expectedResult = false
        
        let actualUser: [String: [String: Bool]] = [:]
        mockStorage?.set(actualUser, forKey: userKey)
        
        //When
        let actualResult = storageDelegate?.isActualLogin()
        
        //Then
        XCTAssertEqual(expectedResult, actualResult)
    }
    
    func testReturnActualUserLogin() throws {
        
        //Given
        let expectedLogin: String? = "mockLogin"
        let actualUser: [String:[String: Bool]] = [UserKey.actualLogin.rawValue:[expectedLogin!:true]]
        mockStorage?.set(actualUser, forKey: userKey)
        
        //When
        let actualResult = storageDelegate?.getActualLogin()
        
        //Then
        XCTAssertEqual(expectedLogin, actualResult)
    }
    
    func testReturnActualUserLoginNoneUser() throws {
        
        //Given
        let expectedLogin: String? = nil
        
        //When
        let actualLogin = storageDelegate?.getActualLogin()
        
        //Then
        XCTAssertEqual(expectedLogin, actualLogin)
        
    }
    
    func testCheckUserLoginFromStorage() throws {
        
        let expectedresult = true
        let login = "mockLogin"
        let user: [String: [String: Bool]] = [login: [UserKey.auth.rawValue: true]]
        mockStorage?.set(user, forKey: userKey)
        
        let actualResult = storageDelegate?.isLogin(login: login)
        
        XCTAssertEqual(expectedresult, actualResult)
        
    }
    
    func testCheckUserLoginFromStorageNoneUser() throws {
        
        let expectedresult = false
        let login = "mockLogin"
        
        let actualResult = storageDelegate?.isLogin(login: login)
        
        XCTAssertEqual(expectedresult, actualResult)
        
    }

}

private class MockUserDefaults: UserDefaults {
    
    convenience init() {
        self.init(suiteName: "MockUserDefaults")!
    }
    
    override init?(suiteName suitename: String?) {
        UserDefaults().removePersistentDomain(forName: suitename!)
        super.init(suiteName: suitename)
    }
    
}
