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
    let colors: [[UIColor]] = [[.blue, .red, .green, .purple, .yellow]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(FullScreenPagingCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.isPagingEnabled = false
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: .UIApplicationDidChangeStatusBarOrientation, object: nil)
    }
    
    func deviceOrientationDidChange() {
        if let indexPath = collectionView?.indexPathsForVisibleItems.last {
            collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return colors.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        cell.contentView.backgroundColor = colors[indexPath.section][indexPath.row]
        cell.
    
        return cell
    }
}

extension FullScreenPagingCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.bounds.width,
            height: collectionView.bounds.height
        )
    }
}
