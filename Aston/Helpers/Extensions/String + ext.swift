//
//  String + ext.swift
//  Aston
//
//  Created by Максим Сулим on 19.10.2023.
//

import Foundation



extension String {

/// Только для формата строки "S00E00" из Api RickAndMorty
    func transformNumberEpisode() -> String {
       
       let apiStr = self
       var episodeOrSeason = ""
       let arrStr = Array(apiStr)
       var numberSeason = ""
       var numberEpisodes = ""
       
       for i in 0..<arrStr.count {
           
           if arrStr[i] == "S" {
               episodeOrSeason = "S"
           }
           
           if episodeOrSeason == "S" && arrStr[i].isNumber {
               
               if numberSeason.count == 0 && arrStr[i] == "0" {
                   continue
               } else {
                   numberSeason += String(arrStr[i])
               }
           }
           
           if arrStr[i] == "E" {
               episodeOrSeason = "E"
           }
           
           if episodeOrSeason == "E" && arrStr[i].isNumber {
               
               if numberEpisodes.count == 0 && arrStr[i] == "0" {
                   continue
               } else {
                   numberEpisodes += String(arrStr[i])
               }
           }
           
       }
       
       return "Episode: \(numberEpisodes), Season \(numberSeason)"
   }
    
}
