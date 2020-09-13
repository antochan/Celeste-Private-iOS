//
//  GiftCouponViewController.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/9/12.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

protocol GiftCouponDelegate: AnyObject {
    func successfullyGifted()
}

class GiftCouponViewController: UIViewController {
    let giftCouponView = GiftCouponView()
    private let couponServices: CouponServices
    private let who: Who
    weak var delegate: GiftCouponDelegate?
    
    init(couponServices: CouponServices, who: Who) {
        self.couponServices = couponServices
        self.who = who
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = giftCouponView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configureActions()
    }
    
    func configureActions() {
        giftCouponView.submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }

    @objc func submitTapped() {
        guard let couponTitle = giftCouponView.couponTitleTextField.text, !couponTitle.isEmpty, let couponDescription = giftCouponView.couponDescriptionTextField.text, !couponDescription.isEmpty else {
            displayAlert(message: "Please make sure to a coupon title and description", title: "Coupon details pls!")
            return
        }
        let whoToGift: Who = who == .lauren ? .antonio : .lauren
        
        giftCouponRequest(whoToGift: whoToGift,
                          coupon: Coupon(id: UUID().uuidString,
                                         title: couponTitle,
                                         description: couponDescription,
                                         redeemed: false))
    }
    
    func giftCouponRequest(whoToGift: Who, coupon: Coupon) {
        let sv = UIViewController.displaySpinner(onView: giftCouponView, loadingText: "Gifting..")
        couponServices.giftCoupon(who: whoToGift, coupon: coupon) { [weak self] success in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                UIViewController.removeSpinner(spinner: sv)
            })
            guard let strongSelf = self else { return }
            if success {
                strongSelf.delegate?.successfullyGifted()
                strongSelf.dismiss(animated: true)
            } else {
                strongSelf.displayAlert(message: "Oops, something went wrong please let anto know 442 error!", title: "Sorry!")
            }
        }
    }
}
