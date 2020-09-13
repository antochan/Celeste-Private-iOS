//
//  CouponsCollectionCellComponent.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/9/2.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import FSPagerView

class CouponsCollectionCell: FSPagerViewCell {
    public var actions: Actions?
    private var coupon: Coupon?
    
    private let cardView: RoundedShadowView = {
        let card = RoundedShadowView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 32
        card.apply(viewModel: RoundedShadowView.ViewModel(backgroundColor: .white, shadowColor: UIColor.AppColors.black, shadowOpacity: 0.2, shadowRadius: 4.0))
        return card
    }()
    
    private let couponTextStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = Spacing.twelve
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let couponTitle: UILabel = {
        let label = UILabel()
        label.font = .carosMedium(size: 22)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let couponDescription: UILabel = {
        let label = UILabel()
        label.font = .caros(size: 14)
        label.textAlignment = .center
        label.numberOfLines = 5
        return label
    }()
    
    private let redeemButton: ButtonComponent = {
        let button = ButtonComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(coupon: Coupon) {
        self.coupon = coupon
        couponTitle.text = coupon.title
        couponDescription.text = coupon.description
        if let redeemed = coupon.redeemed {
            redeemButton.isEnabled = !redeemed
            if redeemed {
                redeemButton.apply(viewModel: ButtonComponent.ViewModel(style: .primary, text: "Redeemed", color: UIColor.AppColors.koalaRedeemButtonColor))
            } else {
                redeemButton.apply(viewModel: ButtonComponent.ViewModel(style: .primary, text: "Redeem", color: UIColor.AppColors.koalaRedeemButtonColor))
            }
        } else {
            redeemButton.apply(viewModel: ButtonComponent.ViewModel(style: .primary, text: "Loading...", color: UIColor.AppColors.koalaRedeemButtonColor))
            redeemButton.isEnabled = false
        }
    }
    
    @objc func redeemTapped() {
        actions?(coupon)
    }
}

//MARK: - Private

private extension CouponsCollectionCell {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }

    func configureSubviews() {
        addSubviews(cardView)
        cardView.addSubviews(couponTextStack, redeemButton)
        couponTextStack.addArrangedSubviews(couponTitle, couponDescription, UIView())
        redeemButton.addTarget(self, action: #selector(redeemTapped), for: .touchUpInside)
    }

    func configureLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85),
            
            couponTextStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Spacing.twentyFour),
            couponTextStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Spacing.twentyFour),
            couponTextStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Spacing.twentyFour),
            
            redeemButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Spacing.twentyFour),
            redeemButton.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.7),
            redeemButton.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            redeemButton.heightAnchor.constraint(lessThanOrEqualToConstant: 35)
        ])
    }
}

//MARK: - Actionable
extension CouponsCollectionCell: Actionable {
    public typealias Actions = (_ coupon: Coupon?) -> Void
}
