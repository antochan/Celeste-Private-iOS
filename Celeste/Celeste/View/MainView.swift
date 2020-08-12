//
//  MainView.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/11.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class MainView: UIView {
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.AppColors.black
        view.alpha = 0
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.AppColors.white
        view.layer.cornerRadius = Spacing.fortyEight
        view.clipsToBounds = true
        return view
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let calendarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.heightAnchor.constraint(equalToConstant: 22).isActive = true
        button.widthAnchor.constraint(equalToConstant: 22).isActive = true
        button.setImage(#imageLiteral(resourceName: "calendar"), for: .normal)
        return button
    }()
    
    private let titleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.four
        stackView.alpha = 0
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.lightBlue
        label.text = "Total Time Together"
        label.font = .bellefair(size: 16)
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.white
        label.font = .bellefair(size: 32) 
        label.isUserInteractionEnabled = true
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func appearAnimation() {
        backgroundView.fadeIn(duration: 0.3, delay: 0.2)
        userImageView.fadeIn(duration: 0.3, delay: 0.2)
        calendarButton.fadeIn(duration: 0.3, delay: 0.2)
        titleStack.fadeIn(duration: 0.3, delay: 0.2)
        UIView.animate(withDuration: 0.6,
                       delay: 0.3,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: .curveEaseOut,
                       animations: {
                        self.contentView.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height * 0.725)
        }) { (_) in
            print("content view appeared")
        }
    }
    
    func applyMainView(who: Who) {
        switch who {
        case .lauren:
            userImageView.image = #imageLiteral(resourceName: "ebichu")
        case .antonio:
            userImageView.image = #imageLiteral(resourceName: "groot")
        }
    }
    
    func applyTime(dateString: String?) {
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
        addSubviews(backgroundView)
        backgroundView.addSubviews(calendarButton, titleStack, userImageView, contentView)
        titleStack.addArrangedSubviews(titleLabel, subtitleLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            userImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            userImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            calendarButton.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            calendarButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            titleStack.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: Spacing.twentyFour),
            titleStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            titleStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            contentView.topAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height)
        ])
    }
}
