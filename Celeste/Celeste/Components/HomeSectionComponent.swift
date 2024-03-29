//
//  HomeSectionComponent.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/15.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

public enum HomeSectionStyle {
    case mainCard
    case horizontalHalf
    case verticalHalf
}

class HomeSectionComponent: UIView, Component, Pressable {
    public let configuration = PressableConfiguration(pressScale: .medium)
    public var actions: Actions?
    
    struct ViewModel {
        let backgroundColor: UIColor
        let titleText: String
        let sectionStyle: HomeSectionStyle
        let image: UIImage
    }
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 22
        view.clipsToBounds = true
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.AppColors.black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
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
    
    func apply(viewModel: ViewModel) {
        backgroundColor = viewModel.backgroundColor
        titleLabel.text = viewModel.titleText
        imageView.image = viewModel.image
        switch viewModel.sectionStyle {
        case .horizontalHalf:
            imageView.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.5).isActive = true
            imageView.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.8).isActive = true
            titleLabel.font = .carosMedium(size: 15)
        case .verticalHalf:
            imageView.widthAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.5).isActive = true
            imageView.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.7).isActive = true
            titleLabel.font = .carosMedium(size: 15)
        case .mainCard:
            imageView.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.5).isActive = true
            imageView.heightAnchor.constraint(equalTo: cardView.heightAnchor).isActive = true
            titleLabel.font = .carosMedium(size: 15)
        }
    }
}

//MARK: - Private

private extension HomeSectionComponent {
    func commonInit() {
        backgroundColor = .white
        layer.cornerRadius = 22
        configureSubviews()
        configureLayout()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    func configureSubviews() {
        addSubview(cardView)
        cardView.addSubviews(titleLabel, imageView)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Spacing.sixteen),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            
            imageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Spacing.four),
            imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Spacing.eight)
        ])
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        actions?(.componentTapped)
    }
}

//MARK: - Actionable
extension HomeSectionComponent: Actionable {
    public typealias Actions = (Action) -> Void
    
    public enum Action {
        case componentTapped
    }
}
