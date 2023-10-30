//
//  Collection + ext.swift
//  Aston
//
//  Created by Максим Сулим on 12.10.2023.
//

import Foundation


extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return saveObject(at: index)
    }
    
    ///Безопасно извлекаем элемент по индексу
    func saveObject(at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
