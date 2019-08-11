//
//  GameListCollectionViewCell.swift
//  GameCollection
//
//  Created by Chelsea Carr on 8/10/19.
//  Copyright © 2019 Chelsea Carr. All rights reserved.
//

import Foundation
import UIKit

class GameListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        gameImageView.image = nil
        gameNameLabel.text = nil
    }
    
    func setup(imageURL: String, name: String) {
        gameNameLabel.text = name
        
        ImageService.main.fetchImage(from: imageURL) { [weak self] image in
            
            guard let image = image, let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                UIView.transition(with: self.gameImageView,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    self.gameImageView.image = image
                                  },
                                  completion: nil)
            }
        }
    }
    
    static func calculateCellHeight(name: String, width: CGFloat) -> CGFloat {
        
        let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        tempLabel.text = name
        tempLabel.font = UIFont.systemFont(ofSize: 13.0)
        
        tempLabel.sizeToFit()
        return tempLabel.frame.height
    }
}
