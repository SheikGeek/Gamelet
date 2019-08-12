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
    @IBOutlet weak var pickForMeButton: UIButton!
    
    private let showGameSegueIdentifier = "ShowGameChoiceSegue"
    
    private var dataSource = [Game]()
    private var selectedGame: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "What Should I Play Today?"
        
        layout.delegate = self
        collectionView.register(GameListCollectionViewCell.nib, forCellWithReuseIdentifier: GameListCollectionViewCell.nibName)
        
        updateDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedGame = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        backItem.tintColor = UIColor(named: "Secondary Color")
        navigationItem.backBarButtonItem = backItem
        
        if let viewController = segue.destination as? GameDetailsViewController {
            viewController.game = selectedGame
        }
    }
    
    @IBAction func tappedPickForMe(_ sender: UIButton) {
        guard let randomGame = dataSource.randomElement() else {
            let alert = UIAlertController(title: "Sorry!", message: "It looks like you don't have any games to choose from.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
            return
        }
        
        selectedGame = randomGame
        performSegue(withIdentifier: showGameSegueIdentifier, sender: self)
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
        cell.setup(imageURL: game.thumbnailURLString, name: game.name, typeString: game.formattedGameTypeString())
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedGame = dataSource[indexPath.item]
        performSegue(withIdentifier: showGameSegueIdentifier, sender: self)
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
    
    func setupButton() {
        //Did not finish implementing style here
        pickForMeButton.layer.cornerRadius = 4.0
    }
}

extension GameListViewController: GameGridCollectionViewLayoutDelegate {
    func cellHeight(at indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        guard indexPath.item < dataSource.count else {
            //out of index, don't try to fetch the data
            return 0
        }
        
        let game = dataSource[indexPath.item]
        return GameListCollectionViewCell.calculateCellHeight(name: game.name, width: cellWidth)
    }
    
    func firstLetterOfItem(at indexPath: IndexPath) -> String {
        guard indexPath.item < dataSource.count else {
            //out of index, don't try to fetch the data
            return ""
        }
        
        let game = dataSource[indexPath.item]
        guard let firstCharacter = game.name.first?.lowercased() else {
            //The first character could not be found
            return ""
        }
        
        return "\(firstCharacter)"
    }
}
