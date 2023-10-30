//
//  CharsInteractor.swift
//  Aston
//
//  Created by Максим Сулим on 12.10.2023.
//

import Foundation

protocol CharsInteractorProtocol: AnyObject {
    var charsFromApi: [ResultChar] { get }
    var imageChars: [Int:Data] { get }
    func loadImageChar(charUrl: String, indexCell: Int)
    func loadChars(countChars: Int)
    var cachedDataImageChar: NSCache<AnyObject, NSData> { get }
}

final class CharsInteractor {
    
    weak var presenter: CharsPresenterProtocol!
    
    init(presenter: CharsPresenterProtocol) {
        self.presenter = presenter
    }

//MARK: private propirties
    
// ссылка на новых чаров
    private var nextUrlChars: String = "" {
        didSet {
            isLoadedChars = false
        }
    }
    
// флаг загрузки новых чаров
    private var isLoadedChars = false
    private var charsOnTheScreen: Int = Resources.LayoutView.CharsView.countRowNoneData
    
//MARK: - protocol methods
    
    var charsFromApi: [ResultChar] = [] {
        
        didSet {
            charsFromApi = charsFromApi.sorted(by: { $0.id < $1.id })
        }
    }
    
    var imageChars: [Int : Data] = [:]
    
    lazy var cachedDataImageChar: NSCache<AnyObject, NSData> = {
        
        let cache = NSCache<AnyObject, NSData>()
        
        return cache
        
    }()
}

extension CharsInteractor: CharsInteractorProtocol {
    
    func loadChars(countChars: Int) {
        charsOnTheScreen += countChars
        startRequest()
    }
    
    func loadImageChar(charUrl: String, indexCell: Int) {
        
        let urlString = charUrl
        
        NetworkRequest.shared.request(stringUrl: urlString) { result in
            
            switch result {
                
            case .success(let data):
                
                do {
                    
                    self.imageChars[indexCell] = data
                    self.cachedDataImageChar.setObject(data as NSData, forKey: indexCell as AnyObject)
                    
                    if indexCell + 1 == self.charsOnTheScreen - Resources.LayoutView.CharsView.reserveRows {
                        self.presenter.reloadTable()
                    }
                    
                    if indexCell + Resources.LayoutView.CharsView.reserveRows ==
                        self.charsFromApi.count && self.isLoadedChars == false {
                        
                        self.loadCharacters(urlCharacters: self.nextUrlChars)
                        self.isLoadedChars = true
                        
                    }
                    
                }
                
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
}


//MARK: - network methods

extension CharsInteractor {
    
    private func startRequest() {
        
        let urlString = StartApi.startApi.rawValue
        
        NetworkData.shared.workDataStartRequest(urlString: urlString) { result, error in
            
            if error == nil {
               
                guard let resultData = result else {
                    return
                }
        
                self.loadCharacters(urlCharacters: resultData.characters)
                
            } else {
                print(error!.localizedDescription)
                
            }
        }
    }
    
    private func loadCharacters(urlCharacters: String) {
        
        let urlString = urlCharacters
        
        NetworkData.shared.workDataCharacters(urlString: urlString) { result, error in
            
            if error == nil {
               
                guard let resultData = result else {
                    return
                }
                
                self.charsFromApi += resultData.results
                self.nextUrlChars = resultData.info.next
                
                self.presenter.reloadTable()
                                
            } else {
                print(error!.localizedDescription)
                
            }
        }
    }

}
