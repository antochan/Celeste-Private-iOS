//
//  PillComponent.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/30.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class PillComponent: UIView, Component {
    struct ViewModel {
        let pillBackgroundColor: UIColor
        let pillLabelText: String
        let textColor: UIColor
        let shadowColor: UIColor
        let shadowOpacity: Float
        let shadowRadius: CGFloat
    }
    
    private let shadowView: RoundedShadowView = {
        let view = RoundedShadowView()
        view.layer.cornerRadius = 13
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let pillLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.mainMedium(size: 13)
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
        shadowView.apply(viewModel: RoundedShadowView.ViewModel(backgroundColor: viewModel.pillBackgroundColor,
                                                                shadowColor: viewModel.shadowColor,
                                                                shadowOpacity: viewModel.shadowOpacity,
                                                                shadowRadius: viewModel.shadowRadius))
        pillLabel.textColor = viewModel.textColor
        pillLabel.text = viewModel.pillLabelText
    }
    
}

//MARK: - Privte

private extension PillComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(shadowView, pillLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.eight),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.four),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.four),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.eight),
            
            pillLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: Spacing.twelve),
            pillLabel.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: Spacing.eight),
            pillLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -Spacing.twelve),
            pillLabel.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -Spacing.eight),
        ])
    }
}
