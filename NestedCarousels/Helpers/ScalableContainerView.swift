//
//  ScalableContainerView.swift
//  NestedCarousels
//
//  Created by Space Wizard on 8/8/24.
//

import Foundation
import UIKit

class ScalableContainerView: UIView {
    
    private var animator: UIViewPropertyAnimator?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        animator = UIViewPropertyAnimator(duration: 0.25, curve: .easeOut, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            self?.layer.shadowOpacity = 0.3
        })
        
        animator?.startAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        animator = UIViewPropertyAnimator(duration: 0.25, curve: .easeOut, animations: { [weak self] in
            self?.transform = .identity
            self?.layer.shadowOpacity = 0
        })
        
        animator?.startAnimation()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        animator?.stopAnimation(true)
        
        animator = UIViewPropertyAnimator(duration: 0.25, curve: .easeOut, animations: { [weak self] in
            self?.transform = .identity
            self?.layer.shadowOpacity = 0
        })
        
        animator?.startAnimation()
    }
}

private extension ScalableContainerView {
    
//    private lazy var shapeLayer: CAShapeLayer = {
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
//        shapeLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
//        shapeLayer.cornerRadius = 50
//        shapeLayer.borderColor = UIView.colors.randomElement()?.cgColor
//        shapeLayer.borderWidth = 2
//        shapeLayer.opacity = 0
//        layer.addSublayer(shapeLayer)
//        return shapeLayer
//    }()
    
    // NO-OP for now ... not being used
//    func createRipple() {
//        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
//        scaleAnimation.fromValue = 0.0
//        scaleAnimation.toValue = 1.0
//        
//        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
//        opacityAnimation.fromValue = 1.0
//        opacityAnimation.toValue = 0.0
//        
//        let animationGroup = CAAnimationGroup()
//        animationGroup.animations = [scaleAnimation, opacityAnimation]
//        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeOut)
//        animationGroup.duration = 0.6
//        shapeLayer.add(animationGroup, forKey: "rippleEffect")
//    }
}
