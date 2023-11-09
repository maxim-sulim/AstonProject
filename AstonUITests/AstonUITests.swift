//
//  AstonUITests.swift
//  AstonUITests
//
//  Created by Максим Сулим on 08.11.2023.
//

import XCTest
@testable import Aston

final class AstonUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        
        app = XCUIApplication()
        
        continueAfterFailure = false

        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        
        app.terminate()
        
    }
    
    func testRegistrationAndEditPasswordAndOutDeleteLOgin() throws {
        
        let loginTField = app.textFields["LoginTF"]
        let passwordTField = app.secureTextFields["PasswordTF"]
        
        //DontValid signIn
        loginTField.tap()
        loginTField.typeText("MockLoginDontValid")
        app.buttons["Next:"].tap()
        passwordTField.typeText("1")
        app.buttons["Done"].tap()
        
        XCTAssert(app.staticTexts["Invalid password"].waitForExistence(timeout: 1.5))
        
        app.buttons["Cancel"].tap()
        
        //Valid
        loginTField.tap()
        loginTField.typeText("MockLoginValid")
        app.buttons["Next:"].tap()
        passwordTField.typeText("12")
        app.buttons["Done"].tap()
        
        XCTAssert(app.staticTexts["Characters"].waitForExistence(timeout: 1.5))
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["TabLogout"].tap()
        
        //Edit Pssword
        app.buttons["EditBut"].tap()
        XCTAssert(app.staticTexts["Edit"].waitForExistence(timeout: 1.5))
        
        app.secureTextFields["EditPasswordTF"].typeText("1234")
        app.buttons["Enter"].tap()
        
        //ExitDomtSaveLogin
        app.buttons["ExitBut"].tap()
        
        XCTAssert(app.staticTexts["Leave authorization"].waitForExistence(timeout: 1.5))
        
        app.buttons["Delete login"].tap()
        
        XCTAssert(app.staticTexts["Registration"].waitForExistence(timeout: 3.0))
        
    }

}
