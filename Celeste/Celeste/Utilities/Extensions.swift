//
//  Extensions.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/10.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ arrangedViews: UIView...) {
        arrangedViews.forEach { addArrangedSubview($0) }
    }
    
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func apply(cornerRadius: CornerRadius) {
        layer.cornerRadius = cornerRadius.style.value(forBounds: bounds)
        layer.maskedCorners = cornerRadius.cornerMasks
    }
    
    func apply(borderWidth: BorderWidth) {
        layer.borderWidth = borderWidth.rawValue
    }
    
    func fadeOut(duration: TimeInterval = 0.1, delay: TimeInterval = 0) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0
        }, completion: { finished in
            self.isHidden = true
        })
    }
    
    func fadeIn(duration: TimeInterval = 0.1, delay: TimeInterval = 0) {
        isHidden = false
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 1
        }, completion: { finished in
            self.isHidden = false
        })
    }
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

public extension NSAttributedString {
    func singleLineWidth() -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let textContainer = NSTextContainer(size: size)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = .byTruncatingTail
        textContainer.maximumNumberOfLines = 1
        
        let layoutManager = NSLayoutManager()
        layoutManager.usesFontLeading = false
        layoutManager.addTextContainer(textContainer)
        
        let textStorage = NSTextStorage(attributedString: self)
        textStorage.addLayoutManager(layoutManager)
        
        layoutManager.ensureLayout(for: textContainer)
        
        let usedRect = layoutManager.usedRect(for: textContainer)
        let width = ceil(usedRect.width)
        
        return width
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// This function displays a UIAlertView string for a given `message: String`.
       ///
       /// - Warning: Make sure this is called on the main thread
       ///
       /// Usage:
       ///
       ///     displayAlert("Your Message Here)
       func displayAlert(message: String, title: String = "") {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
           OKAction.setValue(UIColor.black, forKey: "titleTextColor")
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
       }
}
