//
//  CarouselCollectionViewCell.swift
//  NestedCarousels
//
//  Created by Space Wizard on 8/7/24.
//

import Foundation
import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        String(describing: CarouselCollectionViewCell.self)
    }
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var nestedCollectionView: UICollectionView = {
        let totalWidth: CGFloat = 160

        let itemSize = CGSize(width: 50, height: 80)
        let layout = CarouselCollectionViewLayout(itemSize: itemSize, totalWidth: totalWidth)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.backgroundColor = .red
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(NestedCollectionViewCell.self, forCellWithReuseIdentifier: NestedCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CarouselCollectionViewCell {
    
    func setup() {
        contentView.addSubview(containerView)
        containerView.addSubview(nestedCollectionView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nestedCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nestedCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            nestedCollectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            nestedCollectionView.topAnchor.constraint(equalTo: containerView.topAnchor)
        ])
    }
}

extension CarouselCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NestedCollectionViewCell.identifier, for: indexPath) as? NestedCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}
