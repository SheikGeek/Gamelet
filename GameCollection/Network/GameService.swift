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

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            
            do {
                let games = try JSONDecoder().decode([Game].self, from: data)
                completion(games)
            } catch {
                print("Error: \(error)")
                completion([])
            }
        }.resume()
    }
}
