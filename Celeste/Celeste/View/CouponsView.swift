//
//  CouponsView.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/31.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import FSPagerView

class CouponsView: UIView {
    private let outerCircleLayer = CAShapeLayer()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alpha = 0
        return scrollView
    }()
    
    private let innerCircleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.AppColors.koalaInnerCircleColor
        view.layer.cornerRadius = 137.5
        return view
    }()
    
    private let koalaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "Koala")
        return imageView
    }()
    
    private let pinkStarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "pink s")
        return imageView
    }()
    
    private let yellowStarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "yellow s")
        return imageView
    }()
    
    private let blueStarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "blue s")
        return imageView
    }()
    
    private let topDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.16)
        view.heightAnchor.constraint(equalToConstant: 4).isActive = true
        view.widthAnchor.constraint(equalToConstant: 32).isActive = true
        view.layer.cornerRadius = 2.0
        return view
    }()
    
    private let middleDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.32)
        view.heightAnchor.constraint(equalToConstant: 4).isActive = true
        view.widthAnchor.constraint(equalToConstant: 64).isActive = true
        view.layer.cornerRadius = 2.0
        return view
    }()
    
    private let bottomDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.56)
        view.heightAnchor.constraint(equalToConstant: 4).isActive = true
        view.widthAnchor.constraint(equalToConstant: 96).isActive = true
        view.layer.cornerRadius = 2.0
        return view
    }()
    
    let couponsCarousel: FSPagerView = {
        let carousel = FSPagerView()
        carousel.translatesAutoresizingMaskIntoConstraints = false
        carousel.scrollDirection = .horizontal
        carousel.itemSize = CGSize(width: UIScreen.main.bounds.width - 70, height: 335)
        return carousel
    }()
    
    let closeButton: CircularImageButton = {
        let button = CircularImageButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.apply(viewModel: CircularImageButton.ViewModel(image: #imageLiteral(resourceName: "close"), dimensions: 42, imageDimensions: 14))
        button.alpha = 0
        return button
    }()
    
    let giftButton: CircularImageButton = {
        let button = CircularImageButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.apply(viewModel: CircularImageButton.ViewModel(image: #imageLiteral(resourceName: "gift"), dimensions: 42, imageDimensions: 18))
        button.alpha = 0
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func appearAnimation() {
        scrollView.fadeIn(duration: 0.3, delay: 0.2)
        UIView.animate(withDuration: 0.4,
                       delay: 0.4,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.6,
                       options: .curveEaseOut,
                       animations: {
                        self.closeButton.alpha = 1
                        self.closeButton.transform = CGAffineTransform(translationX: 0, y: Spacing.thirtyTwo)
                        self.giftButton.alpha = 1
                        self.giftButton.transform = CGAffineTransform(translationX: 0, y: Spacing.thirtyTwo)
        })
    }
}

//MARK: - Private

private extension CouponsView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 815)
        outerCircleLayer.path = UIBezierPath(ovalIn: CGRect(x: (UIScreen.main.bounds.width - 325) / 2, y: 45, width: 325, height: 325)).cgPath
        outerCircleLayer.strokeColor = UIColor.AppColors.beige.withAlphaComponent(0.8).cgColor
        outerCircleLayer.lineWidth = 1.5
        outerCircleLayer.fillColor = UIColor.clear.cgColor
        
        scrollView.layer.addSublayer(outerCircleLayer)
        
        addSubviews(scrollView, closeButton, giftButton)
        scrollView.addSubviews(innerCircleView, pinkStarView, yellowStarView, blueStarView, couponsCarousel)
        innerCircleView.addSubview(koalaImageView)
        
        guard let pinkPoint = outerCircleLayer.path?.getPathElementsPoints().first else { return }
        pinkStarView.frame = CGRect(origin: CGPoint(x: pinkPoint.x - 11, y: pinkPoint.y - 11), size: CGSize(width: 25, height: 25))
        
        guard let yellowPoint = outerCircleLayer.path?.getPathElementsPoints()[4] else { return }
        yellowStarView.frame = CGRect(origin: CGPoint(x: yellowPoint.x , y: yellowPoint.y - 32), size: CGSize(width: 18, height: 18))
        
        guard let bluePoint = outerCircleLayer.path?.getPathElementsPoints()[7] else { return }
        blueStarView.frame = CGRect(origin: CGPoint(x: bluePoint.x, y: bluePoint.y), size: CGSize(width: 35, height: 35))
    }
    
    func configureLayout() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            innerCircleView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 75),
            innerCircleView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            innerCircleView.heightAnchor.constraint(equalToConstant: 265),
            innerCircleView.widthAnchor.constraint(equalToConstant: 265),
            
            koalaImageView.topAnchor.constraint(equalTo: innerCircleView.topAnchor, constant: Spacing.forty),
            koalaImageView.leadingAnchor.constraint(equalTo: innerCircleView.leadingAnchor, constant: Spacing.forty),
            koalaImageView.trailingAnchor.constraint(equalTo: innerCircleView.trailingAnchor, constant: -Spacing.forty),
            koalaImageView.bottomAnchor.constraint(equalTo: innerCircleView.bottomAnchor, constant: -Spacing.forty),
    
            couponsCarousel.topAnchor.constraint(equalTo: innerCircleView.bottomAnchor, constant:  40 + Spacing.twentyFour),
            couponsCarousel.centerXAnchor.constraint(equalTo: centerXAnchor),
            couponsCarousel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            couponsCarousel.heightAnchor.constraint(equalToConstant: 350),
            
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -Spacing.sixteen),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            giftButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -Spacing.sixteen),
            giftButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
        ])
    }
}

