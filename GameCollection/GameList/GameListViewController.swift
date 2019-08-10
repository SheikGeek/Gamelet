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
    
    private var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout.delegate = self
    }
}

extension GameListViewController: GameGridCollectionViewLayoutDelegate {
    func cellHeight(at indexPath: IndexPath) -> CGFloat {
        
    }
    
    
}
