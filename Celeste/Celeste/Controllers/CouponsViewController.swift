//
//  CouponsViewController.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/31.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import FSPagerView

class CouponsViewController: UIViewController {
    let couponView = CouponsView()
    private let who: Who
    private let couponServices: CouponServices
    
    private var coupons: [Coupon] = [Coupon(title: "Fetching Coupons", description: "Currently fetching your coupons from the server ;) Please give it a second to load in all your coupons", redeemed: nil)] {
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
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//          return .lightContent
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
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
    
    func configureActions() {
        couponView.closeButton.actions = { [weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.dismiss(animated: true)
        }
    }
    
    func configureCarousel() {
        couponView.couponsCarousel.register(CouponsCollectionCell.self, forCellWithReuseIdentifier: "CouponsCell")
        couponView.couponsCarousel.transformer = FSPagerViewTransformer(type: .zoomOut)
        couponView.couponsCarousel.delegate = self
        couponView.couponsCarousel.dataSource = self
    }
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.AppColors.koalaOne.cgColor, UIColor.AppColors.koalaTwo.cgColor, UIColor.AppColors.koalaThree.cgColor, UIColor.AppColors.koalaFour.cgColor]
        gradientLayer.locations = [0.0, 0.2, 0.4, 0.6, 1.0]
        gradientLayer.frame = couponView.bounds
        couponView.layer.insertSublayer(gradientLayer, at: 0)
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
        return cell
    }
}
