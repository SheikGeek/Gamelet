//
//  BoardGame.swift
//  GameCollection
//
//  Created by Chelsea Carr on 8/10/19.
//  Copyright © 2019 Chelsea Carr. All rights reserved.
//

import Foundation

class BoardGame: Codable, Game {
    
    var name = ""
    var id = -1
    var imageURLString = ""
    var thumbnailURLString = ""
    var gameType = GameType.boardGame
    
    var minPlayers = -1
    var maxPlayers = -1
    var playingTime = -1
    var isExpansion = false
    var yearPublished = 0
    var numPlays = 0
    
    var owned = false
    
    enum CodingKeys: String, CodingKey {
        case name
        case id = "gameId"
        case imageURLString = "image"
        case thumbnailURLString = "thumbnail"
        case minPlayers
        case maxPlayers
        case playingTime
        case isExpansion
        case yearPublished
        case numPlays
        case owned
    }
    
    func formattedGameTypeString() -> String {
        var gameTypeString = gameType.rawValue
        if isExpansion {
            gameTypeString += " - expansion"
        }
        
        return gameTypeString
    }
}
