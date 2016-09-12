//
//  FullScreenPagingCollectionViewController.swift
//  PagingTableView
//
//  Created by Brent Raines on 9/7/16.
//  Copyright © 2016 Brent Raines. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FullScreenPagingCell"

class FullScreenPagingCollectionViewController: UICollectionViewController {
    let images: [[String]] = [["water_glass", "sneaker", "heart"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(FullScreenPagingCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.isPagingEnabled = false
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return images.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FullScreenPagingCollectionViewCell
        
        cell.image = UIImage(named: images[indexPath.section][indexPath.row])

        return cell
    }
}
