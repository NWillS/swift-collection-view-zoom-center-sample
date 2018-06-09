//
//  SampleCollectionViewFlowLayout.swift
//  swift-collection-view-zoom-center-sample
//
//  Created by devWill on 2018/06/09.
//  Copyright © 2018年 devWill. All rights reserved.
//

import UIKit

class SampleCollectionViewFlowLayout: UICollectionViewFlowLayout {
    let scalingOffset: CGFloat = 25
    let minimumScaleFactor: CGFloat = 0.3
    let itemWidth = 125
    let itemHeight = 100
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.prepare()
    }
    
    override func prepare() {
        self.scrollDirection = .horizontal
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        self.minimumLineSpacing = -40
        
        let verticalInsets: CGFloat = (collectionView?.bounds.size.height)! / 2
        
        self.sectionInset = UIEdgeInsets(top: verticalInsets,
                                         left: 0,
                                         bottom: verticalInsets,
                                         right: 0)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributeArray: NSArray = super.layoutAttributesForElements(in: rect)! as NSArray
        let visibleRect: CGRect = CGRect(origin: self.collectionView!.contentOffset,
                                         size: (self.collectionView?.bounds.size)!)
        let visibleCenterX: CGFloat = visibleRect.midX
        
        attributeArray.enumerateObjects { object,_,_ in
            guard let attributes = object as? UICollectionViewLayoutAttributes else {
                fatalError("attributes is nil")
            }
            let distanceFromCenter: CGFloat = visibleCenterX - attributes.center.x
            let absDistanceFromCenter: CGFloat = min(abs(distanceFromCenter), self.scalingOffset)
            let scale: CGFloat = absDistanceFromCenter * (self.minimumScaleFactor - 1) / self.scalingOffset + 1
            attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        }
        
        return attributeArray as? [UICollectionViewLayoutAttributes]
    }
}

