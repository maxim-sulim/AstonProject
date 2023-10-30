//
//  EpisodePresentor.swift
//  Aston
//
//  Created by Максим Сулим on 13.10.2023.
//

import Foundation

protocol EpisodePresenterProtocol: AnyObject {
    func loadCollection()
    func loadEpisode(episodes: [String])
    func configureViewCell(indexCell: Int) -> EpisodeCellModel
}

final class EpisodePresenter {
    
    weak var view: EpisodeViewProtocol!
    var router: EpisodeRouterProtocol!
    var interactor: EpisodeInteractorProtocol!
    
    init(view: EpisodeViewProtocol!) {
        self.view = view
    }
}

extension EpisodePresenter: EpisodePresenterProtocol {
    
    func loadEpisode(episodes: [String]) {
        interactor.loadEpisodes(episodes: episodes)
    }
    
    func loadCollection() {
        view.countEpisode = interactor.episodeFromChar.count
    }
    
    func configureViewCell(indexCell: Int) -> EpisodeCellModel {
        
        var model = EpisodeCellModel(name: Resources.TitleView.EpisodesView.noneDataEpisode.rawValue,
                                     number: Resources.TitleView.EpisodesView.noneDataEpisode.rawValue,
                                     date: Resources.TitleView.EpisodesView.noneDataEpisode.rawValue)
        
        if let name = interactor.episodeFromChar.saveObject(at: indexCell)?.name,
           let number = interactor.episodeFromChar.saveObject(at: indexCell)?.number,
           let date = interactor.episodeFromChar.saveObject(at: indexCell)?.date {
            
            model.name = name
            model.date = date
            model.number = number.transformNumberEpisode()
        }
        
        return model
    }
}
