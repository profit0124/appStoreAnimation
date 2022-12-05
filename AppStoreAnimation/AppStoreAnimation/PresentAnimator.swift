//
//  PresentAnimator.swift
//  AppStoreAnimation
//
//  Created by Sooik Kim on 2022/12/06.
//

import UIKit

enum AnimationType {
    case present
    case dismiss
}

class PresentAnimator: NSObject {
    let animationType: AnimationType
    
    init(animationType: AnimationType) {
        self.animationType = animationType
        super.init()
    }
}


extension PresentAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if animationType == .present {
            presentAnimation(using: transitionContext)
        } else {
            dismissAnimation(using: transitionContext)
        }
    }
}


extension PresentAnimator {
    func presentAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let fromVC = transitionContext.viewController(forKey: .from) as? ViewController else { return }
        
        guard let toVC = transitionContext.viewController(forKey: .to) as? PresentViewController else { return }
        
        guard let selectedCell = fromVC.selecetedCell else { return }
    
        let frame = selectedCell.convert(selectedCell.frame, to: fromVC.view)
        toVC.view.frame = frame
        toVC.view.layer.cornerRadius = 8
        toVC.imageView.frame.size = frame.size
        toVC.view.layoutIfNeeded()
        containerView.addSubview(toVC.view)
        UIView.animate(withDuration: 1.0, animations: {
            toVC.view.frame = fromVC.view.frame
            toVC.view.layer.cornerRadius = 0
            toVC.imageView.frame.size.width = UIScreen.main.bounds.width
            toVC.imageView.frame.size.height = UIScreen.main.bounds.width * 1.2
            toVC.view.layoutIfNeeded()
        }) { completed in
            transitionContext.completeTransition(completed)
        }
    }
    
    func dismissAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? PresentViewController else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) as? ViewController else { return }
        guard let selectedCell = toVC.selecetedCell else { return }
        
        UIView.animate(withDuration: 1.0, animations: {
            let frame = selectedCell.convert(selectedCell.frame, to: toVC.view)
            fromVC.view.frame = frame
            fromVC.view.layer.cornerRadius = 8
            fromVC.imageView.frame.size.width = frame.width
            fromVC.imageView.frame.size.height = frame.height
            fromVC.view.layoutIfNeeded()
        }) { completed in
            transitionContext.completeTransition(completed)
        }
    }
    
    
}
