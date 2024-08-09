//
//  ViewController.swift
//  NestedCarousels
//
//  Created by Space Wizard on 8/7/24.
//

import UIKit

class CarouselViewController: UIViewController {
    
    private let itemSize: CGSize = CGSize(width: 160, height: 250)
        
    private lazy var collectionView: UICollectionView = {
        let layout = CarouselCollectionViewLayout(itemSize: itemSize, totalWidth: UIScreen.main.bounds.width)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
    }
}

extension CarouselViewController {
    
    func setup() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    func presentNestedCarouselViewController(startingFrame: CGRect) {
        let nestedCarouselViewController = NestedCarouselViewController(
            startingFrame: startingFrame,
            itemSize: itemSize,
            totalWidth: UIScreen.main.bounds.width
        )

        nestedCarouselViewController.view.frame = startingFrame
        addChild(nestedCarouselViewController)
        
        view.addSubview(nestedCarouselViewController.view)
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut]) { [weak self] in
            guard let self = self else { return }
            
            nestedCarouselViewController.view.frame = self.collectionView.frame
            self.view.layoutIfNeeded()
        }
        
        nestedCarouselViewController.didMove(toParent: self)
    }
}

extension CarouselViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.identifier , for: indexPath) as? CarouselCollectionViewCell else { return UICollectionViewCell() }
        
        cell.onTapCell = { [weak self] cellFrame in
            guard let self = self else { return }
            
            self.presentNestedCarouselViewController(startingFrame: cellFrame)
        }
        
        return cell
    }
}
