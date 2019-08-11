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
    
    private let shadowColor = UIColor(named: "Tertiary Color")?.cgColor
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 4.0
        contentView.layer.borderColor = shadowColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = shadowColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        gameImageView.backgroundColor = UIColor.clear
        gameImageView.image = nil
        gameNameLabel.text = nil
    }
    
    func setup(imageURL: String, name: String) {
        gameNameLabel.text = name
        
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
