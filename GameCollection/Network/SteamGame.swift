//
//  SteamGame.swift
//  GameCollection
//
//  Created by Chelsea Carr on 8/11/19.
//  Copyright © 2019 Chelsea Carr. All rights reserved.
//

import Foundation

class SteamGame: Codable, Game {   
    
    var name = ""
    var id = -1
    var owned = true
    var imageURLString: String {
        return createImageURLString()
    }
    var thumbnailURLString: String {
        return createImageURLString()
    }
    
    var imageHashString = ""

    enum CodingKeys: String, CodingKey {
        case name
        case id = "appid"
        case imageHashString = "img_icon_url"
    }
    
    func createImageURLString() -> String {
        let baseURLString = "http://media.steampowered.com/steamcommunity/public/images/apps/"
        return "\(baseURLString)\(id)/\(imageHashString)"
    }
}
