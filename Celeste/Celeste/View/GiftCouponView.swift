//
//  GiftCouponView.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/9/12.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import TextFieldEffects

class GiftCouponView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .carosMedium(size: 21)
        label.textColor = UIColor.AppColors.black
        label.text = "Gift a Coupon"
        label.textAlignment = .center
        return label
    }()
    
    let couponTitleTextField: HoshiTextField = {
        let textfield = HoshiTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderInactiveColor = .gray
        textfield.borderActiveColor = .black
        textfield.font = .caros(size: 15)
        textfield.placeholder = "Coupon Title"
        textfield.placeholderColor = .gray
        return textfield
    }()
    
    let couponDescriptionTextField: HoshiTextField = {
        let textfield = HoshiTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderInactiveColor = .gray
        textfield.borderActiveColor = .black
        textfield.font = .caros(size: 15)
        textfield.placeholder = "Coupon Description"
        textfield.placeholderColor = .gray
        return textfield
    }()
    
    let submitButton: ButtonComponent = {
        let button = ButtonComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.apply(viewModel: ButtonComponent.ViewModel(style: .primary, text: "Submit"))
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private

private extension GiftCouponView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(titleLabel, couponTitleTextField, couponDescriptionTextField, submitButton)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60.0),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            couponTitleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.sixteen),
            couponTitleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            couponTitleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            couponTitleTextField.heightAnchor.constraint(equalToConstant: 60),
            
            couponDescriptionTextField.topAnchor.constraint(equalTo: couponTitleTextField.bottomAnchor, constant: Spacing.sixteen),
            couponDescriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            couponDescriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            couponDescriptionTextField.heightAnchor.constraint(equalToConstant: 60),
            
            
            submitButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.fortyEight),
            submitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            submitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
        ])
    }
}
