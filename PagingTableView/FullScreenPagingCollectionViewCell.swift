//
//  FullScreenPagingCollectionViewCell.swift
//  PagingTableView
//
//  Created by Brent Raines on 9/7/16.
//  Copyright © 2016 Brent Raines. All rights reserved.
//

import UIKit

class FullScreenPagingCollectionViewCell: UICollectionViewCell {
    private func cellOffset() -> CGFloat {
        let collectionView = self.superview as? FullScreenPagingCollectionView
        let flowLayout = collectionView?.collectionViewLayout as? FullScreenPagingCollectionViewFlowLayout
        return (flowLayout?.tabBarHeight ?? 0) * 0.5
    }
    
    override func draw(_ rect: CGRect) {
        let maskPath = UIBezierPath()
        maskPath.move(to: CGPoint(x: rect.origin.x, y: rect.origin.y))
        maskPath.addLine(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + cellOffset()))
        maskPath.addLine(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height))
        maskPath.addLine(to: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height - cellOffset()))
        maskPath.close()
        
        let maskLayer = CAShapeLayer()
        maskLayer.masksToBounds = false
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
