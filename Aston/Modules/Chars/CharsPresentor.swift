//
//  CharsPresentor.swift
//  Aston
//
//  Created by Максим Сулим on 12.10.2023.
//

import Foundation

protocol CharsPresentorProtocol: AnyObject {
    func configureViewCell(indexPath: IndexPath) -> ModelChar
    func configureView()
    func loadTable()
    func reloadTableRow(indexPath: IndexPath)
}

final class CharsPresentor {
    
    var router: CharsRouterProtocol!
    var interactor: CharsInteractorProtocol!
    
    
    weak var view: CharsViewProtocol!
    
    init(view: CharsViewProtocol) {
        self.view = view
    }

}

extension CharsPresentor: CharsPresentorProtocol {
    
    func configureViewCell(indexPath: IndexPath) -> ModelChar {

        var model = ModelChar(name: Resources.TitleView.CharsView.noneDataChar,
                              status: Resources.TitleView.CharsView.noneDataChar,
                              imageUrl: "",
                              image: Resources.TitleView.CharsView.nonDataImage)
        
        if let name = interactor.charsFromApi.saveObject(at: indexPath.row)?.name,
           let status = interactor.charsFromApi.saveObject(at: indexPath.row)?.status,
           let imageUrl = interactor.charsFromApi.saveObject(at: indexPath.row)?.image {
            
            if let data = interactor.cachedDataImageChar.object(forKey: indexPath.row as AnyObject) {
                
                model.image = data as Data
                
            } else {
                
                DispatchQueue.global().async {
                    self.interactor.loadImageChar(charUrl: model.imageUrl, indexPath: indexPath)
                }
                
            }
            
            model.imageUrl = imageUrl
            model.name = name
            model.status = status
            
            if let imageData = interactor.imageChars[indexPath.row] {
                model.image = imageData
            }
        }
        
        return model
    }
    
    func configureView() {
        view.configureNavigationBar(title: Resources.TitleView.TabBarItemTitle.chars.rawValue)
        interactor.loadChars()
        view.countChars = interactor.charsFromApi.count
    }
    
    func loadTable() {
        view.countChars = interactor.charsFromApi.count
        view.reloadTable()
    }
    
    func reloadTableRow(indexPath: IndexPath) {
        view.reloadTableRow(indexPath: indexPath)
        
    }
    
}
