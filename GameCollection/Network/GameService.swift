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
    
    private var boardGames = [BoardGame]()
    private var steamGames = [SteamGame]()

    private var canExecuteCompletion = false
    
    func fetchGames(completion: @escaping (([Game]) -> Void)) {

        canExecuteCompletion = false
        
        let queue = OperationQueue()
        let dispatchGroup = DispatchGroup()
        
        let boardAndSteamGamesOperation = BlockOperation {
            self.fetchBoardGames(withDispatchGroup: dispatchGroup)
            self.fetchSteamGames(withDispatchGroup: dispatchGroup)

            dispatchGroup.wait()
        }
        
        let completionOperation = BlockOperation {
            completion(self.createSortedListOfGames())
        }
        completionOperation.addDependency(boardAndSteamGamesOperation)

        queue.addOperation(boardAndSteamGamesOperation)
        queue.addOperation(completionOperation)
    }
}

private extension GameService {
    
    func fetchBoardGames(withDispatchGroup group: DispatchGroup) {
        
        let boardGameRoute = "https://bgg-json.azurewebsites.net/collection/ithato"
        guard let url = URL(string: boardGameRoute) else {
            //Unable to get games
            self.boardGames = []
            return
        }
        
        group.enter()
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.boardGames = []
                group.leave()
                return
            }
            
            do {
                let games = try JSONDecoder().decode([BoardGame].self, from: data)
                self?.boardGames = games.filter { $0.owned }
                
                group.leave()
            } catch {
                print("Error: \(error)")
                self?.boardGames = []
                
                group.leave()
            }
        }.resume()
    }
    
    func fetchSteamGames(withDispatchGroup group: DispatchGroup) {
        
        guard let path = Bundle.main.path(forResource: "SteamGames", ofType: "json") else {
            steamGames = []
            return
        }
        
        let url = URL(fileURLWithPath: path)
        group.enter()

        do {
            let jsonData = try Data(contentsOf: url)
            let steamGamesResponse = try JSONDecoder().decode([String: [SteamGame]].self, from: jsonData)
            if let games = steamGamesResponse["games"] {
                steamGames = games
            }
            
            group.leave()
        } catch {
            print("Error: \(error)")
            steamGames = []
            
            group.leave()
        }
    }
    
    func createSortedListOfGames() -> [Game] {
        let allGames: [Game] = steamGames + boardGames
        return allGames.sorted(by: { $0.name.lowercased() < $1.name.lowercased()})
    }
}
