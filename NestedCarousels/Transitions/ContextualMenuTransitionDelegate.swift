//
//  ContextualMenuTransitionDelegate.swift
//  NestedCarousels
//
//  Created by Space Wizard on 8/8/24.
//

import Foundation
import UIKit

protocol ContextualMenuTransitionDelegate: UIViewControllerTransitioningDelegate {
    func didTapDimmingView()
}

class ContextualMenuTransitionDelegateImplementation: NSObject, UIViewControllerTransitioningDelegate {
    
    private lazy var transitionAnimator = ContextualMenuAnimator(startingFrame: startingFrame)
    
    public var startingFrame: CGRect = .zero {
        didSet {
            transitionAnimator = ContextualMenuAnimator(startingFrame: startingFrame)
        }
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = ContextualMenuPresentationController(
            presentedViewController: presented,
            presenting: presenting ?? source
        )
        
        // Whoevers conforms to ContextualMenuTransitionDelegate can own the contextualMenuDelegate of the presentationController
        // Don't typically want to use source in case you have embeeded presenting view controllers ... source may not be accurate source of truth
        if let presentingViewController = source as? ContextualMenuTransitionDelegate {
            presentationController.contextualMenuDelegate = presentingViewController
        }
        
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionAnimator.transitioningForward = true
        return transitionAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionAnimator.transitioningForward = false
        return transitionAnimator
    }
}
