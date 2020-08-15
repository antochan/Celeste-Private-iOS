//
//  CircularImageButton.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/14.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class CircularImageButton: UIView, Component {
    struct ViewModel {
        var image: UIImage? = nil
        let backgroundColor: UIColor = UIColor.AppColors.white
        let dimensions: CGFloat
    }
    
    public var actions: Actions?
    
    let circleView: RoundedShadowView = {
        let view = RoundedShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func apply(viewModel: ViewModel) {
        circleView.backgroundColor = viewModel.backgroundColor
        imageView.image = viewModel.image
        
        circleView.heightAnchor.constraint(equalToConstant: viewModel.dimensions).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: viewModel.dimensions).isActive = true
        circleView.layer.cornerRadius = viewModel.dimensions / 2
    }
    
}

//MARK: - Private
private extension CircularImageButton {
    func commonInit() {
        configureSubviews()
        configureLayout()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    func configureSubviews() {
        addSubviews(circleView)
        circleView.addSubviews(imageView)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: topAnchor),
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            circleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            circleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: circleView.topAnchor, constant: Spacing.twelve),
            imageView.bottomAnchor.constraint(equalTo: circleView.bottomAnchor, constant: -Spacing.twelve),
            imageView.leadingAnchor.constraint(equalTo: circleView.leadingAnchor, constant: Spacing.twelve),
            imageView.trailingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: -Spacing.twelve)
        ])
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        actions?(.buttonAction)
    }
}

//MARK: - Actionable
extension CircularImageButton: Actionable {
    public typealias Actions = (Action) -> Void
    
    public enum Action {
        case buttonAction
    }
}


