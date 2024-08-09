//
//  ContextualMenuTransitionDelegate.swift
//  NestedCarousels
//
//  Created by Space Wizard on 8/8/24.
//

import Foundation
import UIKit

class ContextualMenuTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    private lazy var transitionAnimator = ContextualMenuAnimator(startingFrame: startingFrame)
    
    public var startingFrame: CGRect = .zero {
        didSet {
            transitionAnimator = ContextualMenuAnimator(startingFrame: startingFrame)
        }
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        ContextualMenuPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
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
