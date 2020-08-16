//
//  CalendarView.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/15.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import FSCalendar

class OurCalendarView: UIView {
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        return button
    }()
    
    lazy var calendarView: FSCalendar = {
        let calendarView = FSCalendar()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.alpha = 0
        return calendarView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func appearAnimation() {
        calendarView.fadeIn(duration: 0.3, delay: 0.2)
    }
    
}

//MARK: - Private

private extension OurCalendarView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        calendarView.today = Date()
        calendarView.appearance.headerTitleColor = UIColor.AppColors.black
        calendarView.appearance.headerTitleFont = UIFont.mainMedium(size: 20)
        calendarView.appearance.weekdayTextColor = .lightGray
        addSubviews(backButton, calendarView)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            backButton.heightAnchor.constraint(equalToConstant: 22),
            backButton.widthAnchor.constraint(equalToConstant: 22),
            
            calendarView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Spacing.sixteen),
            calendarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            calendarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.sixteen),
            calendarView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
}
