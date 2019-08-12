//
//  GameDetailsViewController.swift
//  GameCollection
//
//  Created by Chelsea Carr on 8/11/19.
//  Copyright © 2019 Chelsea Carr. All rights reserved.
//

import Foundation
import UIKit

class GameDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var game: Game?
    
    private let dataSource: [RowType] = [.mainGameInfo]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(GameMainDetailsTableViewCell.nib, forCellReuseIdentifier: GameMainDetailsTableViewCell.nibName)
    }
}

private extension GameDetailsViewController {
    
    enum RowType {
        case mainGameInfo
        case numberOfPlayers //I didn't get to implement this :(
    }
}

extension GameDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameMainDetailsTableViewCell.nibName, for: indexPath) as? GameMainDetailsTableViewCell else {
            fatalError("GameMainDetailsTableViewCell was not setup properly")
        }
        
        guard let game = game else {
            fatalError("No game passed to this view controller")
        }
        
        cell.setup(imageURL: game.imageURLString, name: game.name, typeString: game.formattedGameTypeString())
        return cell

    }
}

