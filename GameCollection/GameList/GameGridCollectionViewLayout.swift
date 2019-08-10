//
//  GameGridCollectionViewLayout.swift
//  GameCollection
//
//  Created by Chelsea Carr on 8/10/19.
//  Copyright © 2019 Chelsea Carr. All rights reserved.
//

import Foundation
import UIKit

protocol GameGridCollectionViewLayoutDelegate: class {
    func cellHeight(at indexPath: IndexPath) -> CGFloat
}

class GameGridCollectionViewLayout: UICollectionViewLayout {
    
    weak var delegate: GameGridCollectionViewLayoutDelegate?
    
    fileprivate var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var numberOfItems: Int {
        return collectionView?.numberOfItems(inSection: 0) ?? 0
    }
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        
        let numberOfColumns = 2
        let spaceBetweenCells: CGFloat = 6
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: CGFloat = 0

        var column = 0
        var yOffset: CGFloat = 0
        
        for index in 0 ..< numberOfItems {
            
            let indexPath = IndexPath(item: index, section: 0)
            
            let cellHeight = delegate?.cellHeight(at: indexPath) ?? 0
            let frame = CGRect(x: xOffset, y: yOffset, width: columnWidth, height: cellHeight)
            
            // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            layoutAttributes.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in layoutAttributes {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath.item]
    }
}
