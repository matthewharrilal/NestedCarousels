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
}
