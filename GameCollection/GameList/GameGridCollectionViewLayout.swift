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
    func cellHeight(at indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat
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

        return collectionView.bounds.width
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        
        let numberOfColumns = 2
        
        let spaceBetweenCells: CGFloat = 12
        let columnWidth = (contentWidth - (spaceBetweenCells * 2)) / CGFloat(numberOfColumns)
        
        var column = 0
        var xOffset: CGFloat = spaceBetweenCells
        var yOffsetTotals = [CGFloat]()
        
        for _ in 0..<numberOfColumns {
            yOffsetTotals.append(spaceBetweenCells)
        }

        for index in 0 ..< numberOfItems {
            
            let indexPath = IndexPath(item: index, section: 0)
            
            var cellWidth = columnWidth
            if column != numberOfColumns - 1 {
                cellWidth -= spaceBetweenCells
            }
            
            let cellHeight = delegate?.cellHeight(at: indexPath, cellWidth: cellWidth) ?? 0
            let frame = CGRect(x: xOffset, y: yOffsetTotals[column], width: cellWidth, height: cellHeight)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            layoutAttributes.append(attributes)
            
            yOffsetTotals[column] += cellHeight + spaceBetweenCells

            let nextColumn = column + 1
            if nextColumn > numberOfColumns - 1 {
                column = 0
            } else {
                column = nextColumn
            }
            
            xOffset = CGFloat(column) * columnWidth + spaceBetweenCells
        }
        
        //Button Height is 56 and vertical padding is 40
        let pickMeButtonSpacing: CGFloat = 96
        contentHeight = (yOffsetTotals.max() ?? 0) + pickMeButtonSpacing
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
