//
//  AuthView.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/10.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class WhoThisView: UIView {
    private let titleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.twelve
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Who Dis?"
        label.font = .bellefair(size: 35)
        label.alpha = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello and welcome to Celeste! The digital scratchbook just for us HEH! Choose below who is using the app right now, if you're name isn't there then... leave!"
        label.font = .bellefair(size: 18)
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()
    
    private let userStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
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
        titleLabel.fadeIn()
        subtitleLabel.transform = .identity
        subtitleLabel.fadeIn()
    }
    
    func handleDisappearAnimation(completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.6,
                       options: .curveEaseOut,
                       animations: {
                        self.titleLabel.transform = CGAffineTransform(translationX: -Spacing.sixteen, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: {
                            self.userStack.alpha = 0
                            self.titleLabel.alpha = 0
                            self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -UIScreen.main.bounds.height * 0.1)
            }) { (_) in
                completion(true)
            }
        }
        
        UIView.animate(withDuration: 0.4,
                       delay: 0.4,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.6,
                       options: .curveEaseOut,
                       animations: {
                        self.subtitleLabel.transform = CGAffineTransform(translationX: -Spacing.sixteen, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: {
                            self.subtitleLabel.alpha = 0
                            self.subtitleLabel.transform = self.subtitleLabel.transform.translatedBy(x: 0, y: -UIScreen.main.bounds.height * 0.1)
            }) { (_) in
                completion(true)
            }
        }
        
    }
}

//MARK: - Private

private extension WhoThisView {
    func commonInit() {
        backgroundColor = .white
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
