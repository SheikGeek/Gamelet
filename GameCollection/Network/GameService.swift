//
//  GameService.swift
//  GameCollection
//
//  Created by Chelsea Carr on 8/10/19.
//  Copyright © 2019 Chelsea Carr. All rights reserved.
//

import Foundation

class GameService: NSObject {
    
    static let main = GameService()
    private override init() {}
    
    private let boardGameRoute = "https://bgg-json.azurewebsites.net/collection/ithato"
    
    func fetchGames(completion: @escaping (([Game]) -> Void)) {
        
        guard let url = URL(string: boardGameRoute) else {
            //Unable to get games
            completion([])
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
    }
}
