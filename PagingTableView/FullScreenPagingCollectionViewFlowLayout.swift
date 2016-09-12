//
//  FullScreenPagingCollectionViewFlowLayout.swift
//  PagingTableView
//
//  Created by Brent Raines on 9/7/16.
//  Copyright © 2016 Brent Raines. All rights reserved.
//

import UIKit

class FullScreenPagingCollectionViewFlowLayout: UICollectionViewFlowLayout {
    let tabBarHeight = UITabBarController().tabBar.bounds.height
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollDirection = .vertical
        minimumInteritemSpacing = 0
        minimumLineSpacing = -(tabBarHeight * 0.5)
        sectionInset = UIEdgeInsets(top: -(tabBarHeight * 0.5), left: 0, bottom: -tabBarHeight * 0.5, right: 0)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var offsetAdjustment = CGFloat(MAXFLOAT)
        let verticalOffset = proposedContentOffset.y - tabBarHeight * 0.5
        let targetRect = CGRect(x: 0, y: proposedContentOffset.y, width: collectionView!.bounds.width, height: collectionView!.bounds.height)
        let attributes: [UICollectionViewLayoutAttributes] = layoutAttributesForElements(in: targetRect)!
        for attribute in attributes {
            guard attribute.representedElementCategory == .cell else {
                return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            }
            
            let itemOffset = attribute.frame.origin.y
            if abs(itemOffset - verticalOffset) < abs(offsetAdjustment) {
                offsetAdjustment = itemOffset - verticalOffset
            }
        }
        
        return CGPoint(x: proposedContentOffset.x, y: proposedContentOffset.y + offsetAdjustment)
    }
}
