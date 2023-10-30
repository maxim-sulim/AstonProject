//
//  AuthEntity.swift
//  Aston
//
//  Created by Максим Сулим on 30.10.2023.
//

import Foundation

protocol UserProtocol {
    var login: String { get set }
    var password: String { get set }
}

struct User: UserProtocol {
    var login: String
    var password: String
}
