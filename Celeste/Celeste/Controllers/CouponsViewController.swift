//
//  CouponsViewController.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/31.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import FSPagerView
import SPStorkController
import SPAlert

class CouponsViewController: UIViewController {
    let couponView = CouponsView()
    private let who: Who
    private let couponServices: CouponServices
    
    private var coupons: [Coupon] = [Coupon(id: "123", title: "Fetching Coupons", description: "Currently fetching your coupons from the server ;) Please give it a second to load in all your coupons", redeemed: nil)] {
        didSet {
            couponView.couponsCarousel.reloadData()
        }
    }
    
    init(who: Who, couponServices: CouponServices) {
        self.who = who
        self.couponServices = couponServices
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = couponView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        couponView.appearAnimation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCarousel()
        configureActions()
        fetchCoupons(who: who)
    }
    
    func fetchCoupons(who: Who) {
        couponServices.getCoupons(who: who) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let coupons):
                strongSelf.coupons = coupons
            case .failure(_):
                strongSelf.displayAlert(message: "Something went wrong getting coupons from server, let anto know :( Sorry! 421", title: "Oops!")
            }
        }
    }
    
    func redeemCoupon(who: Who, coupon: Coupon) {
        let sv = UIViewController.displaySpinner(onView: couponView, loadingText: "Redeeming..")
        couponServices.redeemCoupon(who: who, coupon: coupon) { [weak self] success in
            guard let strongSelf = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                UIViewController.removeSpinner(spinner: sv)
            })
            if success {
                strongSelf.fetchCoupons(who: who)
            } else {
                strongSelf.displayAlert(message: "Something went wrong redeeming this coupon, let anto know :(", title: "Oops!")
            }
        }
    }
    
    func configureActions() {
        couponView.closeButton.actions = { [weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.dismiss(animated: true)
        }
        
        couponView.giftButton.actions = { [weak self] action in
            guard let strongSelf = self else { return }
            let giftCouponViewController = GiftCouponViewController(couponServices: strongSelf.couponServices, who: strongSelf.who)
            giftCouponViewController.delegate = self
            let transitionDelegate = SPStorkTransitioningDelegate()
            transitionDelegate.customHeight = 450
            giftCouponViewController.transitioningDelegate = transitionDelegate
            giftCouponViewController.modalPresentationStyle = .custom
            giftCouponViewController.modalPresentationCapturesStatusBarAppearance = true
            strongSelf.present(giftCouponViewController, animated: true, completion: nil)
        }
    }
    
    func configureCarousel() {
        couponView.couponsCarousel.register(CouponsCollectionCell.self, forCellWithReuseIdentifier: "CouponsCell")
        couponView.couponsCarousel.transformer = FSPagerViewTransformer(type: .linear)
        couponView.couponsCarousel.delegate = self
        couponView.couponsCarousel.dataSource = self
    }

}

//MARK: - FSPagerViewDelegate & FSPagerViewDataSource

extension CouponsViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return coupons.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "CouponsCell", at: index) as! CouponsCollectionCell
        cell.apply(coupon: coupons[index])
        cell.actions = { [weak self] coupon in
            guard let strongSelf = self, let coupon = coupon else { return }
            strongSelf.redeemCoupon(who: strongSelf.who, coupon: coupon)
        }
        return cell
    }
}

//MARK: - GiftCouponDelegate

extension CouponsViewController: GiftCouponDelegate {
    func successfullyGifted() {
        SPAlert.present(title: "Sent Over Coupon!", preset: .done)
    }
}
