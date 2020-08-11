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
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = Spacing.twelve
        return stackView
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .bellefair(size: 18)
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
        switch viewModel.who {
        case .lauren:
            userImageView.image = #imageLiteral(resourceName: "ebichu")
            usernameLabel.text = "Lauren Ting-An Chen"
        case .antonio:
            userImageView.image = #imageLiteral(resourceName: "groot")
            usernameLabel.text = "Antonio \"Honey\" Chan"
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
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubviews(userImageView, usernameLabel)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(componentTapped)))
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
