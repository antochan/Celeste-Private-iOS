//
//  AddCalendarEventView.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/30.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import TextFieldEffects
import DropDown

class AddCalendarEventView: UIView {
    private let selectedDatesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.mainMedium(size: 15)
        label.textColor = UIColor.AppColors.black
        label.text = "Selected Dates"
        return label
    }()
    
    private var pillScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let pillStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.four
        return stackView
    }()
    
    let eventTitleTextField: HoshiTextField = {
        let textfield = HoshiTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderInactiveColor = .gray
        textfield.borderActiveColor = .black
        textfield.font = UIFont.main(size: 16)
        textfield.placeholder = "Event Name (Required)"
        textfield.placeholderColor = .gray
        return textfield
    }()
    
    let eventLocationTextField: HoshiTextField = {
        let textfield = HoshiTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderInactiveColor = .gray
        textfield.borderActiveColor = .black
        textfield.font = UIFont.main(size: 16)
        textfield.placeholder = "Event Location (Optional)"
        textfield.placeholderColor = .gray
        return textfield
    }()
    
    let eventTypeTextField: HoshiTextField = {
        let textfield = HoshiTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderInactiveColor = .gray
        textfield.borderActiveColor = .black
        textfield.font = UIFont.main(size: 16)
        textfield.placeholder = "Event Type (Required)"
        textfield.placeholderColor = .gray
        return textfield
    }()
    
    let eventTypeDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.dataSource = EventType.allCases.map { $0.rawValue }
        return dropDown
    }()
    
    let eventDescriptionTextfield: HoshiTextField = {
        let textfield = HoshiTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderInactiveColor = .gray
        textfield.borderActiveColor = .black
        textfield.font = UIFont.main(size: 16)
        textfield.placeholder = "Event Description (Optional)"
        textfield.placeholderColor = .gray
        return textfield
    }()
    
    let submitButton: ButtonComponent = {
        let button = ButtonComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.apply(viewModel: ButtonComponent.ViewModel(style: .primary, text: "Submit"))
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyDatePills(dateStrings: [String]) {
        dateStrings.forEach {
            pillStackView.addArrangedSubview(createDatePills(dateString: $0))
        }
    }
    
    func createDatePills(dateString: String) -> PillComponent {
        let pill = PillComponent()
        pill.apply(viewModel: PillComponent.ViewModel(pillBackgroundColor: .white, pillLabelText: dateString, textColor: .black, shadowColor: .gray, shadowOpacity: 0.2, shadowRadius: 2.0))
        return pill
    }
    
}

//MARK: - Private

private extension AddCalendarEventView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        eventTypeDropDown.anchorView = eventTypeTextField
        eventTypeDropDown.bottomOffset = CGPoint(x: 0, y: 60)
        addSubviews(selectedDatesTitleLabel, pillScrollView, eventTitleTextField, eventTypeTextField, eventLocationTextField, eventDescriptionTextfield, submitButton)
        pillScrollView.addSubview(pillStackView)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            selectedDatesTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60.0),
            selectedDatesTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            pillScrollView.topAnchor.constraint(equalTo: selectedDatesTitleLabel.bottomAnchor, constant: Spacing.eight),
            pillScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            pillScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.sixteen),
            
            pillStackView.topAnchor.constraint(equalTo: pillScrollView.topAnchor),
            pillStackView.leadingAnchor.constraint(equalTo: pillScrollView.leadingAnchor),
            pillStackView.trailingAnchor.constraint(equalTo: pillScrollView.trailingAnchor),
            pillStackView.bottomAnchor.constraint(equalTo: pillScrollView.bottomAnchor),
            pillStackView.heightAnchor.constraint(equalTo: pillScrollView.heightAnchor),
            
            eventTitleTextField.topAnchor.constraint(equalTo: pillScrollView.bottomAnchor, constant: Spacing.sixteen),
            eventTitleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            eventTitleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            eventTitleTextField.heightAnchor.constraint(equalToConstant: 60),
            
            eventTypeTextField.topAnchor.constraint(equalTo: eventTitleTextField.bottomAnchor, constant: Spacing.sixteen),
            eventTypeTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            eventTypeTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            eventTypeTextField.heightAnchor.constraint(equalToConstant: 60),
            
            eventLocationTextField.topAnchor.constraint(equalTo: eventTypeTextField.bottomAnchor, constant: Spacing.sixteen),
            eventLocationTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            eventLocationTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            eventLocationTextField.heightAnchor.constraint(equalToConstant: 60),
            
            eventDescriptionTextfield.topAnchor.constraint(equalTo: eventLocationTextField.bottomAnchor, constant: Spacing.sixteen),
            eventDescriptionTextfield.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            eventDescriptionTextfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            eventDescriptionTextfield.heightAnchor.constraint(equalToConstant: 60),
            
            submitButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.fortyEight),
            submitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            submitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
        ])
    }
}
