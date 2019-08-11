//
//  Game.swift
//  GameCollection
//
//  Created by Chelsea Carr on 8/11/19.
//  Copyright © 2019 Chelsea Carr. All rights reserved.
//

import Foundation

protocol Game: class {
    var name: String { get set }
    var id: Int { get set }
    var thumbnailURLString: String { get }
    var imageURLString: String { get }
    var owned: Bool { get set }
    var gameType: GameType { get }
    
    func formattedGameTypeString() -> String
}

enum GameType: String {
    case videoGame = "Video Game"
    case boardGame = "Board Game"
}
