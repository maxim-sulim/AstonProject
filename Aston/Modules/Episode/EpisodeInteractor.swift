//
//  EpisodeInteractor.swift
//  Aston
//
//  Created by Максим Сулим on 13.10.2023.
//

import Foundation

protocol EpisodeInteractorProtocol: AnyObject {
    func loadEpisodes(episodes:[String])
    var episodeFromChar: [EpisodeCellModel] { get set }
}

final class EpisodeInteractor {
    
    var presenter: EpisodePresenterProtocol!
    
    init(presenter: EpisodePresenterProtocol!) {
        self.presenter = presenter
    }
    
    var episodeFromChar: [EpisodeCellModel] = []
    
}

extension EpisodeInteractor: EpisodeInteractorProtocol {
    
    func loadEpisodes(episodes: [String]) {
        loadEpisodeFromApi(episodes: episodes)
    }
    
}

extension EpisodeInteractor {
    
    private func sortedEpisodes(arrEpisode: inout [EpisodeCellModel]) -> [EpisodeCellModel] {
         
         return arrEpisode.sorted(by: {$0.number < $1.number})
         
     }
    
    private func loadEpisodeFromApi(episodes: [String]) {
            
            let episodeUrl: [String] = episodes
            
            guard episodeUrl.count != 0 else {
                return
            }
            
            for i in 0..<episodeUrl.count {
                
                let url = episodeUrl[i]
                
                NetworkData.shared.workDataEpisodeChar(urlString: url) { result, error in
                    
                    if error == nil {
                        
                        guard let resultData = result else {
                            return
                        }
                        
                        self.episodeFromChar.append(EpisodeCellModel(name: resultData.name,
                                                                     number: resultData.episode,
                                                                     date: resultData.airDate))
                        
                        self.episodeFromChar = self.sortedEpisodes(arrEpisode: &self.episodeFromChar)
                        
                        if i == episodeUrl.count - 1 {
                            self.presenter.getCountEpisode()
                        }
                        
                    } else {
                        print(error!.localizedDescription)
                        
                    }
                }
            }
        
    }
    
}
