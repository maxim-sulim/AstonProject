//
//  CharsPresentor.swift
//  Aston
//
//  Created by Максим Сулим on 12.10.2023.
//

import Foundation

protocol CharsPresenterProtocol: AnyObject {
    func getModelViewCell(indexCell: Int) -> ModelChar
    func configureView()
    func showEpisodeScene(indexCell: Int)
    func reloadTable()
}

final class CharsPresenter {
    
    var router: CharsRouterProtocol!
    var interactor: CharsInteractorProtocol!
    
    weak var view: CharsViewProtocol!
    
    init(view: CharsViewProtocol) {
        self.view = view
    }

}

extension CharsPresenter: CharsPresenterProtocol {
    
    func getModelViewCell(indexCell: Int) -> ModelChar {

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
            
            model.imageUrl = imageUrl
            model.name = name
            model.status = status
            model.gender = gender
            
//проверяем кеш интероктора
            if let data = interactor.cachedDataImageChar.object(forKey: indexCell as AnyObject) {
                
                model.image = data as Data
                
            } else {
                
                DispatchQueue.global().async {
                    
                    self.interactor.loadImageChar(charUrl: model.imageUrl, indexCell: indexCell)
                }
                
            }
            
            if let imageData = interactor.imageChars[indexCell] {
                model.image = imageData
            }
        }
        
        return model
    }
    
    func configureView() {
        view.configureNavigationBar(title: Resources.TitleView.TabBarItemTitle.chars.rawValue)
        interactor.loadChars(countChars: view.countChars!)
    }
    
    func showEpisodeScene(indexCell: Int) {
        let episodeUrl = interactor.charsFromApi[indexCell].episode
        router.showEpisodeScene(episodes: episodeUrl)
    }
    
    func reloadTable() {
        view.reloadTable()
    }
    
}
