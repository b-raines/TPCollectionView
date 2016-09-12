//
//  FullScreenPagingCollectionViewCell.swift
//  PagingTableView
//
//  Created by Brent Raines on 9/7/16.
//  Copyright © 2016 Brent Raines. All rights reserved.
//

import UIKit

class FullScreenPagingCollectionViewCell: UICollectionViewCell {
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    private let imageView = UIImageView()
    
    private func cellOffset() -> CGFloat {
        let collectionView = self.superview as? FullScreenPagingCollectionView
        let flowLayout = collectionView?.collectionViewLayout as? FullScreenPagingCollectionViewFlowLayout
        return flowLayout?.cellOffset ?? 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image = nil
    }
    
    func setup() {
        clipsToBounds = false
        contentMode = .redraw
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.backgroundColor = UIColor.white
    }
    
    override func draw(_ rect: CGRect) {
        let maskPath = UIBezierPath()
        maskPath.move(to: CGPoint(x: rect.origin.x, y: rect.origin.y))
        maskPath.addLine(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + cellOffset()))
        maskPath.addLine(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height))
        maskPath.addLine(to: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height - cellOffset()))
        maskPath.close()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
