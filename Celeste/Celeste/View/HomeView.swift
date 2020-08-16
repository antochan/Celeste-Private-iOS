//
//  HomeView.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/14.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class HomeView: UIView {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let userImage: UserImageComponent = {
        let image = UserImageComponent()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.hero.id = HeroConstants.userImage
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.AppColors.black
        label.font = .main(size: 16)
        return label
    }()
    
    let calendarView: HomeSectionComponent = {
        let view = HomeSectionComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.apply(viewModel: HomeSectionComponent.ViewModel(backgroundColor: UIColor.AppColors.pastelOrange, titleText: "Our\nCalendar", sectionStyle: .horizontalHalf, image: #imageLiteral(resourceName: "People In Couple")))
        view.alpha = 0
        return view
    }()
    
    let dailyChallengesView: HomeSectionComponent = {
        let view = HomeSectionComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.apply(viewModel: HomeSectionComponent.ViewModel(backgroundColor: UIColor.AppColors.purple, titleText: "Daily\nChallenge", sectionStyle: .verticalHalf, image: #imageLiteral(resourceName: "Woman With Money")))
        view.alpha = 0
        return view
    }()
    
    let couponsView: HomeSectionComponent = {
        let view = HomeSectionComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.apply(viewModel: HomeSectionComponent.ViewModel(backgroundColor: UIColor.AppColors.pastelYellow, titleText: "Coupon\nRewards", sectionStyle: .horizontalHalf, image: #imageLiteral(resourceName: "gift_illustration")))
        view.alpha = 0
        return view
    }()
    
    let photosGalleryView: HomeSectionComponent = {
        let view = HomeSectionComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.apply(viewModel: HomeSectionComponent.ViewModel(backgroundColor: UIColor.AppColors.pastelPink, titleText: "Photo\nGallery", sectionStyle: .verticalHalf, image: #imageLiteral(resourceName: "Couple 3")))
        view.alpha = 0
        return view
    }()
    
    let randomThoughtsView: UIView = {
        let view = HomeSectionComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.apply(viewModel: HomeSectionComponent.ViewModel(backgroundColor: UIColor.AppColors.pastelYellow, titleText: "Random\nThoughs", sectionStyle: .horizontalHalf, image: #imageLiteral(resourceName: "Character 34")))
        view.alpha = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func appearAnimation() {
        userImage.fadeIn(duration: 0.3, delay: 0)
        nameLabel.fadeIn(duration: 0.3, delay: 0.2)
        calendarView.fadeIn(duration: 0.3, delay: 0.5)
        dailyChallengesView.fadeIn(duration: 0.3, delay: 0.6)
        couponsView.fadeIn(duration: 0.3, delay: 0.8)
        photosGalleryView.fadeIn(duration: 0.3, delay: 0.9)
        randomThoughtsView.fadeIn(duration: 0.3, delay: 0.9)
    }
    
    func handleDisappearAnimation(completion: @escaping (Bool) -> ()) {
        photosGalleryView.fadeOut(duration: 0.3, delay: 0)
        randomThoughtsView.fadeOut(duration: 0.3, delay: 0)
        couponsView.fadeOut(duration: 0.3, delay: 0.2)
        dailyChallengesView.fadeOut(duration: 0.3, delay: 0.5)
        calendarView.fadeOut(duration: 0.3, delay: 0.6)
        
        UIView.animate(withDuration: 0.3, delay: 0.8, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.nameLabel.alpha = 0
            self.userImage.alpha = 0
        }, completion: { finished in
            completion(true)
        })
    }
    
    func applyHomeView(who: Who) {
        switch who {
        case .lauren:
            userImage.apply(viewModel: UserImageComponent.ViewModel(who: .lauren, dimension: 50))
            nameLabel.text = "Hi, Lauren"
        case .antonio:
            userImage.apply(viewModel: UserImageComponent.ViewModel(who: .antonio, dimension: 50))
            nameLabel.text = "Hi, Antonio"
        }
    }
}

//MARK: - Private

private extension HomeView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(userImage, nameLabel, calendarView, dailyChallengesView, couponsView, photosGalleryView, randomThoughtsView)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1.05),
            
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.sixteen),
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.twentyFour),
            
            nameLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: Spacing.twelve),
            nameLabel.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
            
            calendarView.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: Spacing.thirtyTwo),
            calendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.sixteen),
            calendarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.sixteen),
            calendarView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.22),
            
            dailyChallengesView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: Spacing.twentyFour),
            dailyChallengesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.sixteen),
            dailyChallengesView.trailingAnchor.constraint(equalTo: calendarView.centerXAnchor, constant: -Spacing.eight),
            dailyChallengesView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.33),
            
            couponsView.topAnchor.constraint(equalTo: dailyChallengesView.topAnchor, constant: Spacing.thirtyTwo),
            couponsView.leadingAnchor.constraint(equalTo: calendarView.centerXAnchor, constant: Spacing.eight),
            couponsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.sixteen),
            couponsView.heightAnchor.constraint(equalTo: dailyChallengesView.heightAnchor, multiplier: 0.56),
            
            photosGalleryView.topAnchor.constraint(equalTo: couponsView.bottomAnchor, constant: Spacing.thirtyTwo),
            photosGalleryView.leadingAnchor.constraint(equalTo: couponsView.leadingAnchor),
            photosGalleryView.trailingAnchor.constraint(equalTo: couponsView.trailingAnchor),
            photosGalleryView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            
            randomThoughtsView.topAnchor.constraint(equalTo: dailyChallengesView.bottomAnchor, constant: Spacing.twentyFour),
            randomThoughtsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.sixteen),
            randomThoughtsView.trailingAnchor.constraint(equalTo: calendarView.centerXAnchor, constant: -Spacing.eight),
            randomThoughtsView.heightAnchor.constraint(equalTo: couponsView.heightAnchor)
        ])
    }
}
