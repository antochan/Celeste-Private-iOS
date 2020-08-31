//
//  AddCalendarEventViewController.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/30.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import DropDown

protocol AddCalendarEventDelegate: AnyObject {
    func successfullyAdded()
}

class AddCalendarEventViewController: UIViewController {
    private let selectedDates: [String]
    private let calendarServices: CalendarServices
    private let addEventView = AddCalendarEventView()
    weak var delegate: AddCalendarEventDelegate?
    
    init(selectedDates: [String], calendarService: CalendarServices) {
        self.selectedDates = selectedDates
        self.calendarServices = calendarService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = addEventView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        addEventView.applyDatePills(dateStrings: selectedDates)
        configureDropDownAppearance()
        configureActions()
    }
    
    func configureActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        addEventView.eventTypeTextField.addGestureRecognizer(tap)
        addEventView.eventTypeDropDown.selectionAction = { (_: Int, item: String) in
            self.addEventView.eventTypeTextField.text = item
        }
        addEventView.submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        dismissKeyboard()
        addEventView.eventTypeDropDown.show()
    }
    
    @objc func submitTapped() {
        guard let eventName = addEventView.eventTitleTextField.text, !eventName.isEmpty else {
            displayAlert(message: "Please make sure to include an event name!", title: "Event name pls!")
            return
        }
        
        guard let eventTypeString = addEventView.eventTypeTextField.text, !eventTypeString.isEmpty, let eventType = EventType(rawValue: eventTypeString) else {
            displayAlert(message: "Please make sure to select an event type!", title: "Event type pls!")
            return
        }
        
        let calendarEvents = selectedDates.map { CalendarEvent(id: UUID().uuidString,
                                                               date: $0,
                                                               eventType: eventType,
                                                               eventLocation: addEventView.eventLocationTextField.text,
                                                               eventDescription: addEventView.eventDescriptionTextfield.text,
                                                               eventTitle: eventName)}
        postCalendarEvents(calendarEvents: calendarEvents)
    }
    
    func configureDropDownAppearance() {
        let appearance = DropDown.appearance()
        appearance.backgroundColor = UIColor.AppColors.beige
        appearance.selectionBackgroundColor = UIColor.AppColors.beige
        appearance.textFont = UIFont.main(size: 15)
        appearance.cornerRadius = 12
    }
    
    func postCalendarEvents(calendarEvents: [CalendarEvent]) {
        calendarServices.postCalendarEvents(calendarEvents: calendarEvents) { [weak self] success in
            guard let strongSelf = self else { return }
            if success {
                strongSelf.delegate?.successfullyAdded()
                strongSelf.dismiss(animated: true)
            } else {
                strongSelf.displayAlert(message: "Oops, something went wrong please let anto know 402 error!", title: "Sorry!")
            }
        }
    }

}
