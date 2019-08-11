//
//  Game.swift
//  GameCollection
//
//  Created by Chelsea Carr on 8/10/19.
//  Copyright © 2019 Chelsea Carr. All rights reserved.
//

import Foundation

class Game: Codable {
    
    var name = ""
    var gameID = -1
    var imageURLString = ""
    var thumbnailURLString = ""
    var minPlayers = -1
    var maxPlayers = -1
    var playingTime = -1
    var isExpansion = false
    var yearPublished = 0
    var numPlays = 0
    
    var owned = false
    var preOrdered = false
    var willingToTrade = false
    var wantToTrade = false
    var wantToBuy = false
    var wantToPlay = false
    var wantForLater = false
    
    enum CodingKeys: String, CodingKey {
        case name
        case gameID = "gameId"
        case imageURLString = "image"
        case thumbnailURLString = "thumbnail"
        case minPlayers
        case maxPlayers
        case playingTime
        case isExpansion
        case yearPublished
        case numPlays
        case owned
        case preOrdered
        case willingToTrade = "forTrade"
        case wantToTrade = "want"
        case wantToBuy = "wantToBuy"
        case wantToPlay = "wantToPlay"
        case wantForLater = "wishList"
    }
}
