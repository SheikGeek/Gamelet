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
    @IBOutlet weak var gameTypeLabel: UILabel!
    
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
        gameTypeLabel.text = nil
    }
    
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
    
    static func calculateCellHeight(name: String, width: CGFloat) -> CGFloat {
        
        let contentWidth: CGFloat = 40 //left = 20, right = 20
        
        //Calculate name label Height
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width - contentWidth, height: 0))
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.font = UIFont.systemFont(ofSize: 13.0)
        nameLabel.text = name
        
        nameLabel.sizeToFit()
        
        //Calculate type label Height
        let typeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width - contentWidth, height: 0))
        typeLabel.font = UIFont.systemFont(ofSize: 12.0)

        //This will always be one line, so we can use the placeholder text
        typeLabel.text = "Game Type"
        typeLabel.sizeToFit()
        
        let nameLabelHeight: CGFloat = nameLabel.frame.height
        let typeLabelHeight: CGFloat = typeLabel.frame.height
        let imageHeight: CGFloat = 160
        let heightPadding: CGFloat = 55 //Bottom = 20, Top = 20, ImageToLabelSpace = 10, LabelToLabelSpace = 5
        
        return nameLabelHeight + typeLabelHeight + imageHeight + heightPadding
    }
}
