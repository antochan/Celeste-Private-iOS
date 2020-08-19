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
    
    private let titleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Spacing.four
        stackView.alpha = 0
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.AppColors.black
        label.font = .main(size: 20)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.AppColors.black
        label.text = "Welcome Back"
        label.font = .mainMedium(size: 24)
        return label
    }()
    
    let calendarView: HomeSectionComponent = {
        let view = HomeSectionComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.apply(viewModel: HomeSectionComponent.ViewModel(backgroundColor: UIColor.AppColors.pastelOrange, titleText: "Our Calendar", sectionStyle: .mainCard, image: #imageLiteral(resourceName: "People In Couple")))
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
        view.apply(viewModel: HomeSectionComponent.ViewModel(backgroundColor: UIColor.AppColors.pastelYellow, titleText: "Coupon Rewards", sectionStyle: .horizontalHalf, image: #imageLiteral(resourceName: "gift_illustration")))
        view.alpha = 0
        return view
    }()
    
    let photosGalleryView: HomeSectionComponent = {
        let view = HomeSectionComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.apply(viewModel: HomeSectionComponent.ViewModel(backgroundColor: UIColor.AppColors.pastelPink, titleText: "Photo Gallery", sectionStyle: .verticalHalf, image: #imageLiteral(resourceName: "Couple 3")))
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
        titleStack.fadeIn(duration: 0.3, delay: 0.2)
        calendarView.fadeIn(duration: 0.3, delay: 0.4)
        dailyChallengesView.fadeIn(duration: 0.3, delay: 0.6)
        couponsView.fadeIn(duration: 0.3, delay: 0.8)
        photosGalleryView.fadeIn(duration: 0.3, delay: 1.0)
        randomThoughtsView.fadeIn(duration: 0.3, delay: 1.0)
    }
    
    func handleDisappearAnimation(completion: @escaping (Bool) -> ()) {
        photosGalleryView.fadeOut(duration: 0.3, delay: 0)
        randomThoughtsView.fadeOut(duration: 0.3, delay: 0)
        couponsView.fadeOut(duration: 0.3, delay: 0.2)
        dailyChallengesView.fadeOut(duration: 0.3, delay: 0.4)
        calendarView.fadeOut(duration: 0.3, delay: 0.6)
        
        UIView.animate(withDuration: 0.3, delay: 0.8, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.titleStack.alpha = 0
            self.userImage.alpha = 0
        }, completion: { finished in
            completion(true)
        })
    }
    
    func applyHomeView(who: Who) {
        switch who {
        case .lauren:
            userImage.apply(viewModel: UserImageComponent.ViewModel(who: .lauren, dimension: 100))
            titleLabel.text = "Hi, Lauren"
        case .antonio:
            userImage.apply(viewModel: UserImageComponent.ViewModel(who: .antonio, dimension: 100))
            titleLabel.text = "Hi, Antonio"
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
        contentView.addSubviews(userImage, titleStack, calendarView, dailyChallengesView, couponsView, photosGalleryView, randomThoughtsView)
        titleStack.addArrangedSubviews(titleLabel, subtitleLabel)
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
            contentView.heightAnchor.constraint(equalToConstant: 830),
            
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.sixteen),
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.twentyFour),
            
            titleStack.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: Spacing.twelve),
            titleStack.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
            titleStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.sixteen),
            
            calendarView.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: Spacing.sixteen),
            calendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.sixteen),
            calendarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.sixteen),
            calendarView.heightAnchor.constraint(equalToConstant: 170),
            
            dailyChallengesView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: Spacing.sixteen),
            dailyChallengesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.sixteen),
            dailyChallengesView.trailingAnchor.constraint(equalTo: calendarView.centerXAnchor, constant: -Spacing.eight),
            dailyChallengesView.heightAnchor.constraint(equalToConstant: 260),
            
            couponsView.topAnchor.constraint(equalTo: dailyChallengesView.topAnchor),
            couponsView.leadingAnchor.constraint(equalTo: calendarView.centerXAnchor, constant: Spacing.eight),
            couponsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.sixteen),
            couponsView.heightAnchor.constraint(equalToConstant: 170),
            
            photosGalleryView.topAnchor.constraint(equalTo: couponsView.bottomAnchor, constant: Spacing.sixteen),
            photosGalleryView.leadingAnchor.constraint(equalTo: couponsView.leadingAnchor),
            photosGalleryView.trailingAnchor.constraint(equalTo: couponsView.trailingAnchor),
            photosGalleryView.heightAnchor.constraint(equalToConstant: 290),
            
            randomThoughtsView.topAnchor.constraint(equalTo: dailyChallengesView.bottomAnchor, constant: Spacing.sixteen),
            randomThoughtsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.sixteen),
            randomThoughtsView.trailingAnchor.constraint(equalTo: calendarView.centerXAnchor, constant: -Spacing.eight),
            randomThoughtsView.heightAnchor.constraint(equalTo: couponsView.heightAnchor)
        ])
    }
}
