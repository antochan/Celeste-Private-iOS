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
    
    let roundedButton: CircularImageButton = {
        let view = CircularImageButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.apply(viewModel: CircularImageButton.ViewModel(image: #imageLiteral(resourceName: "next"), dimensions: 48))
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
        addSubviews(userImage, titleStack, roundedButton)
        titleStack.addArrangedSubviews(titleLabel, subtitleLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            userImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            userImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            
            titleStack.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: Spacing.thirtyTwo + 75),
            titleStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            titleStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            roundedButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            roundedButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Spacing.thirtyTwo)
        ])
    }
}
