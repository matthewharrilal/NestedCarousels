//
//  CarouselCollectionViewLayout.swift
//  NestedCarousels
//
//  Created by Space Wizard on 8/7/24.
//

import Foundation
import UIKit

class CarouselCollectionViewLayout: UICollectionViewLayout {
    
    private var itemSize: CGSize
    
    private var totalWidth: CGFloat
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        collectionView?.bounds.width ?? 0
    }
    
    init(itemSize: CGSize, totalWidth: CGFloat) {
        self.itemSize = itemSize
        self.totalWidth = totalWidth
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        contentHeight = 0
        cache.removeAll()
        
        let numberOfSections = collectionView.numberOfSections
        let numberOfItems = collectionView.numberOfItems(inSection: numberOfSections - 1)
        
        var yOffset: CGFloat = 16
        let spacing: CGFloat = 25
        
        let numberOfItemsPerRow: Int = 2
        
        let availableWidth: CGFloat = totalWidth - ((CGFloat(numberOfItemsPerRow) * itemSize.width) + spacing)
        
        var xOffset = availableWidth / 2
        
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: numberOfSections - 1)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            if item != 0 && (item % numberOfItemsPerRow) == 0 {
                yOffset += itemSize.height + spacing
                xOffset = availableWidth / 2
            }
            
            let frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height)
            attributes.frame = frame
            
            xOffset = frame.maxX + spacing
            contentHeight = max(frame.maxY, contentHeight)
            cache.append(attributes)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        super.layoutAttributesForItem(at: indexPath)

        return cache.first { $0.indexPath == indexPath }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        super.layoutAttributesForElements(in: rect)
        
        return cache.filter { $0.frame.intersects(rect) }
    }
}
