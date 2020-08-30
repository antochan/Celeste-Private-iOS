//
//  CalendarEventTableCellComponent.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/17.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class CalendarEventTableCellComponent: UIView, Component, Reusable, Pressable {
    public let configuration = PressableConfiguration(pressScale: .medium)
    
    struct ViewModel {
        let calendarEvent: CalendarEvent
    }
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor.AppColors.lightGray
        view.clipsToBounds = true
        return view
    }()
    
    private let eventTypePill: PillComponent = {
        let view = PillComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "more"), for: .normal)
        return button
    }()
    
    private let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.eight
        return stackView
    }()
    
    private let calendarEventTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.mainMedium(size: 18)
        label.textColor = UIColor.AppColors.black
        return label
    }()
    
    private let calendarEventLocationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.main(size: 15)
        label.textColor = .gray
        return label
    }()
    
    private let calendarEventDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.main(size: 12)
        label.textColor = UIColor.AppColors.black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        set(isPressed: true, animated: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        set(isPressed: false, animated: true)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        set(isPressed: false, animated: true)
    }
    
    func apply(viewModel: ViewModel) {
        eventTypePill.apply(viewModel: PillComponent.ViewModel(pillBackgroundColor: viewModel.calendarEvent.eventType.color, pillLabelText: viewModel.calendarEvent.eventType.rawValue))
        calendarEventTitleLabel.text = viewModel.calendarEvent.eventTitle
        
        calendarEventLocationLabel.isHidden = viewModel.calendarEvent.eventLocation == nil
        calendarEventLocationLabel.text = viewModel.calendarEvent.eventLocation
        
        calendarEventDescriptionLabel.isHidden = viewModel.calendarEvent.eventDescription == nil
        calendarEventDescriptionLabel.text = viewModel.calendarEvent.eventDescription
    }
    
    func prepareForReuse() {
        // no-op
    }
}

//MARK: - Private

private extension CalendarEventTableCellComponent {
    func commonInit() {
        backgroundColor = .white
        layer.cornerRadius = 15
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(cardView)
        cardView.addSubviews(eventTypePill, moreButton, infoStack)
        infoStack.addArrangedSubviews(calendarEventTitleLabel, calendarEventLocationLabel, calendarEventDescriptionLabel)
        infoStack.setCustomSpacing(Spacing.sixteen, after: calendarEventLocationLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.eight),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.eight),
            
            moreButton.centerYAnchor.constraint(equalTo: eventTypePill.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Spacing.sixteen),
            moreButton.heightAnchor.constraint(equalToConstant: 20),
            moreButton.widthAnchor.constraint(equalToConstant: 20),
            
            eventTypePill.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Spacing.sixteen),
            eventTypePill.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Spacing.sixteen),
            
            infoStack.topAnchor.constraint(equalTo: eventTypePill.bottomAnchor, constant: Spacing.twentyFour),
            infoStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Spacing.sixteen),
            infoStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Spacing.sixteen),
            infoStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Spacing.twentyFour)
        ])
    }
}
