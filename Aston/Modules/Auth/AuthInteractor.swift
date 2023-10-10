//
//  AuthInteractor.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import Foundation

protocol AuthInteractorProtocol {
    func authSignIn()
}

class AuthInteractor: AuthInteractorProtocol {
    
    weak var presenter: AuthPresenterProtocol!
    
    init(presenter: AuthPresenterProtocol) {
        self.presenter = presenter
    }
    
    func authSignIn() {
        
    }
    
}
