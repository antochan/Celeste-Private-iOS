//
//  OTPView.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/10.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import OTPTextField

class OTPView: UIView {
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        return button
    }()
    
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
        label.font = .bellefair(size: 35)
        label.alpha = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bellefair(size: 18)
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()
    
    let OTPField: OTPTextField = {
        let field = OTPTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholderColor = .black
        field.spacing = Spacing.sixteen
        field.font = UIFont.bellefair(size: 28)
        field.alpha = 0
        return field
    }()
    
    let submitButton: ButtonComponent = {
        let button = ButtonComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonViewModel = ButtonComponent.ViewModel(style: .primary, text: "Submit")
        button.apply(viewModel: buttonViewModel)
        button.alpha = 0
        return button
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
        titleLabel.fadeIn(duration: 0.2, delay: 0.1)
        subtitleLabel.transform = .identity
        subtitleLabel.fadeIn(duration: 0.2, delay: 0.1)
        OTPField.fadeIn(duration: 0.2, delay: 0.1)
        submitButton.fadeIn(duration: 0.2, delay: 0.1)
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
    
    func applyTexts(who: Who) {
        switch who {
        case .lauren:
            titleLabel.text = "Hello Lauren."
            subtitleLabel.text = "Since Celeste is OUR baby, gotta make sure you're actually Lauren and not some random side hoe. Enter the passcode below to verify it's you."
        case .antonio:
            titleLabel.text = "Suh Dude.."
            subtitleLabel.text = "psh, just enter the damn passcode you idiot."
        }
    }
}

//MARK: - Private

private extension OTPView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(backButton, titleStack, OTPField, submitButton)
        titleStack.addArrangedSubviews(titleLabel, subtitleLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            backButton.heightAnchor.constraint(equalToConstant: 22),
            backButton.widthAnchor.constraint(equalToConstant: 22),
            
            titleStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -UIScreen.main.bounds.height * 0.2),
            titleStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            OTPField.centerXAnchor.constraint(equalTo: centerXAnchor),
            OTPField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            OTPField.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            submitButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: UIScreen.main.bounds.height * 0.15),
            submitButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }
}
