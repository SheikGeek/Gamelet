//
//  GameMainDetailsTableViewCell.swift
//  GameCollection
//
//  Created by Chelsea Carr on 8/11/19.
//  Copyright © 2019 Chelsea Carr. All rights reserved.
//

import Foundation
import UIKit

class GameMainDetailsTableViewCell: UITableViewCell, NibNameable {
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameTypeLabel: UILabel!
    
    func setup(imageURL: String, name: String, typeString: String) {
        gameNameLabel.text = name
        gameTypeLabel.text = typeString
        ImageService.main.fetchImage(from: imageURL) { [weak self] image in
            
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                UIView.transition(with: self.gameImageView,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    self.gameImageView.backgroundColor = image == nil ? UIColor(named: "Secondary Color") : UIColor.clear
                                    self.gameImageView.image = image
                },
                                  completion: nil)
            }
        }
    }
}
