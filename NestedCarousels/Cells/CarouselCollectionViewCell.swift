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
    
    var onTapCell: ((CGRect) -> Void)?
    
    private var displayLink: CADisplayLink?
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        return view
    }()
    
    public lazy var nestedCollectionView: UICollectionView = {
        let totalWidth: CGFloat = 160

        let itemSize = CGSize(width: 50, height: 80)
        let layout = CarouselCollectionViewLayout(itemSize: itemSize, totalWidth: totalWidth)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(hex: "#F39A9D")
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(NestedCollectionViewCell.self, forCellWithReuseIdentifier: NestedCollectionViewCell.identifier)
        startAnimatingContentOffset()
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func updateContentOffset() {
        let offsetY = nestedCollectionView.contentOffset.y + 0.25
        let visibleHeight = nestedCollectionView.bounds.height
        nestedCollectionView.contentOffset = CGPoint(x: 0, y: offsetY)
        
        if offsetY >= nestedCollectionView.contentSize.height - (visibleHeight - 50) {
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.nestedCollectionView.contentOffset = CGPoint(x: 0, y: 0)
            }
        }
    }
}

private extension CarouselCollectionViewCell {
    
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
    
    func startAnimatingContentOffset() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateContentOffset))
        displayLink?.add(to: .main, forMode: .common)
    }
}

extension CarouselCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NestedCollectionViewCell.identifier, for: indexPath) as? NestedCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension CarouselCollectionViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NestedCollectionViewCell else { return }
        
        if let cellFrame = cell.superview?.convert(cell.frame, to: nil) {
            onTapCell?(cellFrame)
        }
    }
}
