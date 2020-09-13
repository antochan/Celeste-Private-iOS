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
        button.imageEdgeInsets = UIEdgeInsets(top: Spacing.four, left: Spacing.four, bottom: Spacing.four, right: Spacing.four)
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: Spacing.four, left: Spacing.four, bottom: Spacing.four, right: Spacing.four)
        return button
    }()
    
    let calendarView: FSCalendar = {
        let calendarView = FSCalendar()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.alpha = 0
        return calendarView
    }()
    
    let calendarTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let noEventLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "There are no events from the selected dates yet! Feel free to add one or select other dates :)"
        label.font = .caros(size: 15)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    var calendarHeightConstraint: NSLayoutConstraint?
    
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
        addSubviews(backButton, addButton, calendarView, calendarTableView, noEventLabel)
    }
    
    func configureLayout() {
        calendarHeightConstraint = calendarView.heightAnchor.constraint(equalToConstant:  UIDevice.current.model.hasPrefix("iPad") ? 420.0 : 320.0)
        calendarHeightConstraint?.isActive = true
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            backButton.heightAnchor.constraint(equalToConstant: 22),
            backButton.widthAnchor.constraint(equalToConstant: 22),
            
            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.sixteen),
            addButton.heightAnchor.constraint(equalToConstant: 22),
            addButton.widthAnchor.constraint(equalToConstant: 22),
            
            calendarView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Spacing.sixteen),
            calendarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            calendarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.sixteen),
            
            calendarTableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: Spacing.twentyFour),
            calendarTableView.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor),
            calendarTableView.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor),
            calendarTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            noEventLabel.centerXAnchor.constraint(equalTo: calendarTableView.centerXAnchor),
            noEventLabel.centerYAnchor.constraint(equalTo: calendarTableView.centerYAnchor),
            noEventLabel.leadingAnchor.constraint(equalTo: calendarTableView.leadingAnchor, constant: Spacing.twentyFour),
            noEventLabel.trailingAnchor.constraint(equalTo: calendarTableView.trailingAnchor, constant: -Spacing.twentyFour)
        ])
    }
}
