//
//  NestedCarouselViewController.swift
//  NestedCarousels
//
//  Created by Space Wizard on 8/8/24.
//

import Foundation
import UIKit

class NestedCarouselViewController: UIViewController {
    
    private let startingFrame: CGRect
    private let itemSize: CGSize
    private let totalWidth: CGFloat
    
    public lazy var collectionView: UICollectionView = {
        let layout = CarouselCollectionViewLayout(itemSize: itemSize, totalWidth: totalWidth)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NestedCollectionViewCell.self, forCellWithReuseIdentifier: NestedCollectionViewCell.identifier)
        collectionView.dataSource = self
        return collectionView
    }()
    
    init(startingFrame: CGRect, itemSize: CGSize, totalWidth: CGFloat) {
        self.startingFrame = startingFrame
        self.itemSize = itemSize
        self.totalWidth = totalWidth
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NestedCarouselViewController {
    
    func setup() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}

extension NestedCarouselViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NestedCollectionViewCell.identifier, for: indexPath) as? NestedCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}
