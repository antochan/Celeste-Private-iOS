//
//  UserComponent.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/10.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class UserComponent: UIView, Component, Pressable {
    struct ViewModel {
        let who: Who
    }
    
    public let configuration = PressableConfiguration(pressScale: .medium)
    public var actions: Actions?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Spacing.eight
        return stackView
    }()
    
    private let imageBackgroundView: UserImageComponent = {
        let component = UserImageComponent()
        return component
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.black
        label.font = .bellefair(size: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(viewModel: ViewModel) {
        imageBackgroundView.apply(viewModel: UserImageComponent.ViewModel(who: viewModel.who, dimension: 88.0))
        switch viewModel.who {
        case .lauren:
            usernameLabel.text = "Lauren"
        case .antonio:
            usernameLabel.text = "Antonio"
        }
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
    
    @objc func componentTapped() {
        actions?(.componentTapped)
    }
}

//MARK: - Private

private extension UserComponent {
    func commonInit() {
        layer.cornerRadius = Spacing.eight
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubviews(imageBackgroundView, usernameLabel)
        imageBackgroundView.addSubview(userImageView)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(componentTapped)))
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.eight),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.eight),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.eight),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.eight),
            
            userImageView.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor),
            userImageView.trailingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: -Spacing.four),
            userImageView.leadingAnchor.constraint(equalTo: imageBackgroundView.leadingAnchor, constant: Spacing.four),
            userImageView.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: -Spacing.eight)
        ])
    }
}

//MARK: - Actionable
extension UserComponent: Actionable {
    public typealias Actions = (Action) -> Void
    
    public enum Action {
        case componentTapped
    }
}

//MARK: - UserImageComponent

class UserImageComponent: UIView, Component {
    struct ViewModel {
        let who: Who
        let dimension: CGFloat
    }
    
    private let imageBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(viewModel: ViewModel) {
        switch viewModel.who {
        case .lauren:
            userImageView.image = AppConstants.laurenImage
            imageBackgroundView.backgroundColor = UIColor.AppColors.purple
        case .antonio:
            imageBackgroundView.backgroundColor = UIColor.AppColors.beige
            userImageView.image = AppConstants.antoImage
        }
        
        imageBackgroundView.heightAnchor.constraint(equalToConstant: viewModel.dimension).isActive = true
        imageBackgroundView.widthAnchor.constraint(equalToConstant: viewModel.dimension).isActive = true
        imageBackgroundView.layer.cornerRadius = viewModel.dimension / 2
    }
    
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(imageBackgroundView)
        imageBackgroundView.addSubview(userImageView)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            imageBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            imageBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            userImageView.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor),
            userImageView.trailingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: -Spacing.four),
            userImageView.leadingAnchor.constraint(equalTo: imageBackgroundView.leadingAnchor, constant: Spacing.four),
            userImageView.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: -Spacing.eight)
        ])
    }
}
