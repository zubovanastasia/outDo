//
//  DismissAnimation.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

final class DismissAnimation: NSObject {
    
    var duration: TimeInterval = 0.3
    var transition:TTransition = .crossdisolve
    var vSpace: CGFloat = 0
    
    private func updateDuration(_ frame: CGRect) {
        if transition == .crossdisolve { return }
        if transition == .showFromRight { return }
        if frame.height > UIScreen.main.bounds.height * 0.5 {
            duration *= 1.4
        }
    }
    
    private func getAnimatedFrame(_ frame: CGRect) -> CGRect {
        switch transition {
        case .bottomsheet:
            return frame.offsetBy(dx: 0, dy: frame.height)
        case .showFromBottom:
            return frame.offsetBy(dx: 0, dy: frame.height + vSpace)
        case .showFromTop:
            return frame.offsetBy(dx: 0, dy: -(frame.height + vSpace))
        case .showFromRight:
            return frame.offsetBy(dx: frame.width, dy: 0)
        default: return frame
        }
    }
    
    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let from = transitionContext.view(forKey: .from)!
        let initialFrame = transitionContext.initialFrame(for: transitionContext.viewController(forKey: .from)!)
        updateDuration(initialFrame)
        let toFrame = getAnimatedFrame(initialFrame)
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            from.frame = toFrame
            if self.transition == .crossdisolve {
                from.alpha = 0
            }
        }
        animator.addCompletion { (position) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        return animator
    }
}

extension DismissAnimation: UIViewControllerAnimatedTransitioning {
   
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.animator(using: transitionContext)
        animator.startAnimation()
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return self.animator(using: transitionContext)
    }
}

