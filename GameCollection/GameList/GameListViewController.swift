//
//  GameListViewController.swift
//  GameCollection
//
//  Created by Chelsea Carr on 8/10/19.
//  Copyright © 2019 Chelsea Carr. All rights reserved.
//

import UIKit

class GameListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: GameGridCollectionViewLayout!
    
    private var dataSource = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout.delegate = self
        collectionView.register(GameListCollectionViewCell.nib, forCellWithReuseIdentifier: GameListCollectionViewCell.nibName)
        
        updateDataSource()
    }
}

extension GameListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameListCollectionViewCell.nibName, for: indexPath) as? GameListCollectionViewCell else {
            fatalError("GameListCollectionViewCell was not setup properly")
        }
        
        let game = dataSource[indexPath.item]
        cell.setup(imageURL: game.thumbnailURLString, name: game.name)
        
        return cell
    }
}

private extension GameListViewController {
    
    func updateDataSource() {
        GameService.main.fetchGames { [weak self] games in
            self?.dataSource = games
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension GameListViewController: GameGridCollectionViewLayoutDelegate {
    func cellHeight(at indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        guard indexPath.item < dataSource.count - 1 else {
            //out of index, don't try to fetch the data
            return 0
        }
        
        let game = dataSource[indexPath.item]
        return GameListCollectionViewCell.calculateCellHeight(name: game.name, width: cellWidth)
    }
}
