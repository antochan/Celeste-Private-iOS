//
//  MainView.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/11.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class MainView: UIView {
    private let userImage: UserImageComponent = {
        let image = UserImageComponent()
        image.alpha = 0
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Spacing.four
        stackView.alpha = 0
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.black
        label.text = "You've been trapped for..."
        label.font = .bellefair(size: 16)
        label.textAlignment = .center
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.black
        label.font = .bellefair(size: 42)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let lockButton: CircularImageButton = {
        let view = CircularImageButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.apply(viewModel: CircularImageButton.ViewModel(image: #imageLiteral(resourceName: "lock"), dimensions: 42))
        view.alpha = 0
        return view
    }()
    
    let refreshButton: CircularImageButton = {
        let view = CircularImageButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.apply(viewModel: CircularImageButton.ViewModel(image: #imageLiteral(resourceName: "refresh"), dimensions: 42))
        view.alpha = 0
        return view
    }()
    
    let nextButton: CircularImageButton = {
        let view = CircularImageButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.apply(viewModel: CircularImageButton.ViewModel(image: #imageLiteral(resourceName: "next"), dimensions: 50))
        view.alpha = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func appearAnimation() {
        lockButton.fadeIn(duration: 0.3, delay: 0)
        refreshButton.fadeIn(duration: 0.3, delay: 0)
        nextButton.fadeIn(duration: 0.5, delay: 0)
        UIView.animate(withDuration: 0.6,
                       delay: 0.2,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.3,
                       options: .curveEaseIn,
                       animations: {
                        self.userImage.alpha = 1
                        self.userImage.transform = CGAffineTransform(translationX: 0, y: 75)
        })
        titleStack.fadeIn(duration: 0.6, delay: 0.8)
    }
    
    func handleDisappearAnimation(completion: @escaping (Bool) -> ()) {
        self.titleStack.fadeOut(duration: 0.6, delay: 0)
        self.lockButton.fadeOut(duration: 0.3, delay: 0.3)
        self.refreshButton.fadeOut(duration: 0.3, delay: 0.3)
        self.nextButton.fadeOut(duration: 0.3, delay: 0.3)
//        UIView.animate(withDuration: 0.3, delay: 0.3, options: UIView.AnimationOptions.curveEaseOut, animations: {
//            self.userImage.transform = CGAffineTransform(translationX: 0, y: -75)
//            self.userImage.alpha = 0
//        }, completion: { finished in
//            completion(true)
//        })
    }
    
    func applyMainView(who: Who) {
        switch who {
        case .lauren:
            userImage.apply(viewModel: UserImageComponent.ViewModel(who: .lauren, dimension: 150))
        case .antonio:
            userImage.apply(viewModel: UserImageComponent.ViewModel(who: .antonio, dimension: 150))
        }
    }
    
    func applyTime(dateString: String?, animate: Bool) {
        if animate {
            subtitleLabel.fadeTransition(0.2)
        }
        subtitleLabel.text = dateString ?? "Unknown time ago!"
    }
}

//MARK: - Private

private extension MainView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(userImage, titleStack, nextButton, lockButton, refreshButton)
        titleStack.addArrangedSubviews(titleLabel, subtitleLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            userImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            userImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            
            titleStack.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: Spacing.thirtyTwo + 75),
            titleStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            titleStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Spacing.thirtyTwo),
            
            lockButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            lockButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            refreshButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            refreshButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
        ])
    }
}
