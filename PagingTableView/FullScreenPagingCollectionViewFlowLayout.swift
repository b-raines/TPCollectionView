//
//  FullScreenPagingCollectionViewFlowLayout.swift
//  PagingTableView
//
//  Created by Brent Raines on 9/7/16.
//  Copyright © 2016 Brent Raines. All rights reserved.
//

import UIKit

class FullScreenPagingCollectionViewFlowLayout: UICollectionViewFlowLayout {
    let cellOffset = UITabBarController().tabBar.bounds.height * 0.5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollDirection = .vertical
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        sectionInset = UIEdgeInsets(top: -cellOffset, left: 0, bottom: 0, right: 0)
    }
    
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: collectionView?.bounds.width ?? 0, height: (collectionView?.bounds.height ?? 0) - cellOffset)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }

        return attributes.flatMap { layoutAttributesForItem(at: $0.indexPath) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let itemCount = collectionView?.numberOfItems(inSection: indexPath.section) ?? 0
        let verticalOffset = itemSize.height * CGFloat(indexPath.item) - cellOffset
        attributes.zIndex = indexPath.item
        attributes.transform3D = CATransform3DMakeTranslation(0, 0, CGFloat(indexPath.item - itemCount))
        attributes.frame = CGRect(
            origin: CGPoint(x: 0, y: 0 + verticalOffset),
            size: CGSize(width: collectionView?.bounds.width ?? 0, height: (collectionView?.bounds.height ?? 0) + cellOffset)
        )
        let pointZero = (collectionView?.superview?.convert(.zero, to: collectionView).y ?? cellOffset) - cellOffset
        let maxY = max(pointZero, attributes.frame.origin.y)
        attributes.frame.origin.y = maxY
        
        return attributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var offsetAdjustment = CGFloat(MAXFLOAT)
        let verticalOffset = proposedContentOffset.y - cellOffset
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
