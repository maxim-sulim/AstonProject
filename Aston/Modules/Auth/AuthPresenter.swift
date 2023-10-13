//
//  AuthPresenter.swift
//  Aston
//
//  Created by Максим Сулим on 09.10.2023.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
    var router: AuthRouterProtocol! { get set }
    func signIn()
    func configureView()
}

final class AuthPresenter: AuthPresenterProtocol {
    
    var router: AuthRouterProtocol!
    var interactor: AuthInteractorProtocol!
    weak var view: AuthViewProtocol!

    func signIn() {
        
    }
    
    init(view: AuthViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        let title = Resources.TitleView.AuthView.titleButton.rawValue
        view.setButtonTitle(with: title)
    }
    
}
