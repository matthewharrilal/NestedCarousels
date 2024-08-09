//
//  ContextualMenuPresentationController.swift
//  NestedCarousels
//
//  Created by Space Wizard on 8/8/24.
//

import Foundation
import UIKit

class ContextualMenuPresentationController: UIPresentationController {
    
    private var menuSize = CGSize(width: 200, height: 200)
    
    private var dimmingView: UIView!
    
    weak var contextualMenuDelegate: ContextualMenuTransitionDelegate?
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return .zero
        }
        
        return CGRect(
            x: containerView.center.x - (menuSize.width / 2),
            y: containerView.center.y - (menuSize.height / 2),
            width: menuSize.width,
            height: menuSize.height
        )
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        guard let containerView = containerView else { return }
        
        dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0
        containerView.addSubview(dimmingView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapDimmingView))
        dimmingView.addGestureRecognizer(tapGestureRecognizer)
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.dimmingView.alpha = 1
        }
    }
}

extension ContextualMenuPresentationController {
    
    @objc func didTapDimmingView() {
        presentedViewController.dismiss(animated: true) { [weak self] in
            self?.contextualMenuDelegate?.didTapDimmingView()
        }
    }
}
