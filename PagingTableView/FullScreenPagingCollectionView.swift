//
//  FullScreenPagingCollectionView.swift
//  PagingTableView
//
//  Created by Brent Raines on 9/7/16.
//  Copyright © 2016 Brent Raines. All rights reserved.
//

import UIKit

class FullScreenPagingCollectionView: UICollectionView {
    let tabBarHeight = UITabBarController().tabBar.bounds.height
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        clipsToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = false
    }
}
