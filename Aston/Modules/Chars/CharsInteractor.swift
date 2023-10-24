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
    func loadChars()
    var cachedDataImageChar: NSCache<AnyObject, NSData> { get }
}

final class CharsInteractor {
    
    weak var presentor: CharsPresentorProtocol!
    
    init(presentor: CharsPresentorProtocol) {
        self.presentor = presentor
    }

//MARK: private propirties
    
    private var nextUrlChars: String = ""
    
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
    
    func loadChars() {
        startRequest()
    }
    
    func loadImageChar(charUrl: String, indexCell: Int) {
        
        let urlString = charUrl
        
        NetworkRequest.shared.request(stringUrl: urlString) { result in
            
            switch result {
                
            case .success(let data):
                
                do {
                    
                    if let _ = self.cachedDataImageChar.object(forKey: indexCell as AnyObject) {
    
//если комплишен запроса вернется, когда эта ячейка уже была загружена, выходим из метода не обновляя ее
                        return
                    } else {
                        
                        self.imageChars[indexCell] = data
                        self.presentor.reloadTableRow(indexCell: indexCell)
                        self.cachedDataImageChar.setObject(data as NSData, forKey: indexCell as AnyObject)
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
                
                //self.appCharsFromApi(resultsChar: resultData.results)
                self.charsFromApi += resultData.results
                self.nextUrlChars = resultData.info.next
                
                self.presentor.loadTable()
                                
            } else {
                print(error!.localizedDescription)
                
            }
        }
    }

}
