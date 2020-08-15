//
//  WhoThisView.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/10.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class WhoThisView: UIView {
    private enum Constants {
        static let animateInDuration: TimeInterval = 0.3
        static let animateInDelay: TimeInterval = 0.2
        static let disappearDuration: TimeInterval = 0.4
        static let transformHeight = -UIScreen.main.bounds.height * 0.1
    }
    
    private let titleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.twelve
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.black
        label.text = "Who Dis?"
        label.font = .bellefair(size: 35)
        label.alpha = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.black
        label.text = "Hello and welcome to Celeste! The digital scratchbook just for us HEH! Choose below who is using the app right now, if your name isn't there then... leave!"
        label.font = .bellefair(size: 18)
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()
    
    private let userStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alpha = 0
        stackView.spacing = Spacing.twentyFour
        return stackView
    }()
    
    let laurenComponent: UserComponent = {
        let component = UserComponent()
        let componentViewModel = UserComponent.ViewModel(who: .lauren)
        component.apply(viewModel: componentViewModel)
        return component
    }()
    
    let antonioComponent: UserComponent = {
        let component = UserComponent()
        let componentViewModel = UserComponent.ViewModel(who: .antonio)
        component.apply(viewModel: componentViewModel)
        return component
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func appearAnimation() {
        titleLabel.transform = .identity
        titleLabel.fadeIn(duration: Constants.animateInDuration, delay: Constants.animateInDelay)
        subtitleLabel.transform = .identity
        subtitleLabel.fadeIn(duration: Constants.animateInDuration, delay: Constants.animateInDelay)
        userStack.fadeIn(duration: Constants.animateInDuration, delay: Constants.animateInDelay)
    }
    
    func handleDisappearAnimation(completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: Constants.disappearDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.6,
                       options: .curveEaseOut,
                       animations: {
                        self.titleLabel.transform = CGAffineTransform(translationX: -Spacing.sixteen, y: 0)
        }) { (_) in
            UIView.animate(withDuration: Constants.disappearDuration,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: {
                            self.userStack.alpha = 0
                            self.titleLabel.alpha = 0
                            self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: Constants.transformHeight)
            }) { (_) in
                completion(true)
            }
        }
        
        UIView.animate(withDuration: Constants.disappearDuration,
                       delay: Constants.disappearDuration,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.6,
                       options: .curveEaseOut,
                       animations: {
                        self.subtitleLabel.transform = CGAffineTransform(translationX: -Spacing.sixteen, y: 0)
        }) { (_) in
            UIView.animate(withDuration: Constants.disappearDuration,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: {
                            self.subtitleLabel.alpha = 0
                            self.subtitleLabel.transform = self.subtitleLabel.transform.translatedBy(x: 0, y: Constants.transformHeight)
            }) { (_) in
                completion(true)
            }
        }
    }
}

//MARK: - Private

private extension WhoThisView {
    func commonInit() {
        backgroundColor = UIColor.AppColors.white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(titleStack, userStack)
        titleStack.addArrangedSubviews(titleLabel, subtitleLabel)
        userStack.addArrangedSubviews(laurenComponent, antonioComponent)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            titleStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -UIScreen.main.bounds.height * 0.2),
            titleStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            userStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            userStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: UIScreen.main.bounds.height * 0.2),
            userStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }
}
