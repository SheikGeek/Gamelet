//
//  GameListCollectionViewCell.swift
//  GameCollection
//
//  Created by Chelsea Carr on 8/10/19.
//  Copyright © 2019 Chelsea Carr. All rights reserved.
//

import Foundation
import UIKit

class GameListCollectionViewCell: UICollectionViewCell, NibNameable {
    
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
        
        let contentWidth: CGFloat = 40 //left = 20, right = 20
        let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width - contentWidth, height: 0))
        tempLabel.numberOfLines = 0
        tempLabel.lineBreakMode = .byWordWrapping
        tempLabel.text = name
        tempLabel.font = UIFont.systemFont(ofSize: 13.0)
        
        tempLabel.sizeToFit()
        
        let labelHeight: CGFloat = tempLabel.frame.height
        let imageHeight: CGFloat = 160
        let heightPadding: CGFloat = 50 //Bottom = 20, Top = 20, BetweenElements = 10
        
        return labelHeight + imageHeight + heightPadding
    }
}
