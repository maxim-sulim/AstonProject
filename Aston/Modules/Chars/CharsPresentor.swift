//
//  CharsPresentor.swift
//  Aston
//
//  Created by Максим Сулим on 12.10.2023.
//

import Foundation

protocol CharsPresentorProtocol: AnyObject {
    func configureViewCell(indexCell: Int) -> ModelChar
    func configureView()
    func loadTable()
    func reloadTableRow(indexCell: Int)
    func showEpisodeScene(indexCell: Int)
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
    
    func configureViewCell(indexCell: Int) -> ModelChar {

//устанавливаем дефолт значения
        var model = ModelChar(name: Resources.TitleView.CharsView.noneDataChar,
                              status: Resources.TitleView.CharsView.noneDataChar,
                              gender: Resources.TitleView.CharsView.noneDataChar,
                              imageUrl: "",
                              image: Resources.TitleView.CharsView.nonDataImage)

//если есть данные от сервера, устанавливаем их
        if let name = interactor.charsFromApi.saveObject(at: indexCell)?.name,
           let status = interactor.charsFromApi.saveObject(at: indexCell)?.status,
           let imageUrl = interactor.charsFromApi.saveObject(at: indexCell)?.image,
           let gender = interactor.charsFromApi.saveObject(at: indexCell)?.gender {
            
            if let data = interactor.cachedDataImageChar.object(forKey: indexCell as AnyObject) {
                
                model.image = data as Data
                
            } else {
                
                DispatchQueue.global().async {
                    self.interactor.loadImageChar(charUrl: model.imageUrl, indexCell: indexCell)
                }
                
            }
            
            model.imageUrl = imageUrl
            model.name = name
            model.status = status
            model.gender = gender
            
            if let imageData = interactor.imageChars[indexCell] {
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
    }
    
    func reloadTableRow(indexCell: Int) {
        view.reloadTableRow(indexCell: indexCell)
    }
    
    func showEpisodeScene(indexCell: Int) {
        let episodeUrl = interactor.charsFromApi[indexCell].episode
        router.showEpisodeScene(episodes: episodeUrl)
    }
    
}
