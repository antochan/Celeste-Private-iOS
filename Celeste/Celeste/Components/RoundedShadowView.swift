//
//  RoundedShadowView.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/14.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView, Pressable, Component {
    struct ViewModel {
        let backgroundColor: UIColor
        let shadowColor: UIColor
        let shadowOpacity: Float
        let shadowRadius: CGFloat
    }
    
    let containerView = UIView()
    let cornerRadius: CGFloat = 6.0
    public let configuration = PressableConfiguration(pressScale: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        set(isPressed: true, animated: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        set(isPressed: false, animated: true)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        set(isPressed: false, animated: true)
    }
    
    func layoutView() {
        // set the cornerRadius of the containerView's layer
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true
        
        addSubview(containerView)
        
        //
        // add additional views to the containerView here
        //
        
        // add constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // pin the containerView to the edges to the view
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func apply(viewModel: ViewModel) {
        layer.backgroundColor = viewModel.backgroundColor.cgColor
        layer.shadowColor = viewModel.shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4.0)
        layer.shadowOpacity = viewModel.shadowOpacity
        layer.shadowRadius = viewModel.shadowRadius
    }
}
