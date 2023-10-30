//
//  LogoutPresenter.swift
//  Aston
//
//  Created by Максим Сулим on 19.10.2023.
//

import Foundation


protocol LogoutPresenterProtocol: AnyObject {
    func tapOut()
    ///Переход на начальную сцену авторизации
    func authScene()
}


final class LogoutPresenter {
    
    var router: LogoutRouterProtocol!
    var interactor: LogoutInteractorProtocol!
    weak var view: LogoutViewProtocol!
    
    
    init(view: LogoutViewProtocol) {
        self.view = view
    }
    
}

extension LogoutPresenter: LogoutPresenterProtocol {
    
    func tapOut() {
        interactor.deletelogin()
    }
    
    func authScene() {
        router.presentAuthScene()
    }
}
