//
//  HorizontalSnappingController.swift
//  Appstore
//
//  Created by Turan Çabuk on 11.01.2024.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {
    
    init() {
        let layout = SnappingLayout()
        super.init(collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SnappingLayout: UICollectionViewFlowLayout {
    // snap behavior
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        
        // we're using a magical 48
        let itemWidth = collectionView.frame.width - 48
        
        let itemSpace = itemWidth + minimumInteritemSpacing
        var pageNumber = round(collectionView.contentOffset.x / itemSpace)
        
        // Skip to the next cell, if there is residual scrolling velocity left.
        // This helps to prevent glitches
        let vX = velocity.x
        if vX > 0 {
            pageNumber += 1
        } else if vX < 0 {
            pageNumber -= 1
        }
        
        let nearestPageOffset = pageNumber * itemSpace
        return CGPoint(x: nearestPageOffset,
                       y: parent.y)
    }
    
}
