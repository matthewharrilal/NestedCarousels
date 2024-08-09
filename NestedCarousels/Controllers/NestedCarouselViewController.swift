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
    
    private var displayLink: CADisplayLink?
    private var contextualMenuTransitionDelegate = ContextualMenuTransitionDelegate()
    
    public lazy var collectionView: UICollectionView = {
        let layout = CarouselCollectionViewLayout(itemSize: itemSize, totalWidth: totalWidth)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NestedCollectionViewCell.self, forCellWithReuseIdentifier: NestedCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
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
    
    @objc func updateContentOffset() {
        collectionView.contentOffset.y += 0.25
        
        let visibleHeight = collectionView.contentSize.height - collectionView.bounds.height
        if collectionView.contentOffset.y >= visibleHeight {
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.collectionView.contentOffset = CGPoint(x: 0, y: 0)
            }
        }
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
        
        startAnimatingContentOffset()
    }
    
    func startAnimatingContentOffset() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateContentOffset))
        displayLink?.add(to: .main, forMode: .default)
    }
}

extension NestedCarouselViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NestedCollectionViewCell.identifier, for: indexPath) as? NestedCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension NestedCarouselViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NestedCollectionViewCell else { return }
        
        displayLink?.invalidate()
        
        if let cellFrame = cell.superview?.convert(cell.frame, to: nil) {
            let contextualMenuViewController = ContextualMenuViewController()
            contextualMenuTransitionDelegate.startingFrame = cellFrame
            contextualMenuViewController.transitioningDelegate = contextualMenuTransitionDelegate
            contextualMenuViewController.modalPresentationStyle = .custom
            present(contextualMenuViewController, animated: true)
        }
    }
}
