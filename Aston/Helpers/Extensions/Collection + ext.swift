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
    func saveObject(at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
