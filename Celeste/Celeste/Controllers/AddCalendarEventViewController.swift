//
//  AddCalendarEventViewController.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/30.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import DropDown

class AddCalendarEventViewController: UIViewController {
    private let selectedDates: [String]
    private let calendarServices: CalendarServices
    private let addEventView = AddCalendarEventView()
    
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
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        dismissKeyboard()
        addEventView.eventTypeDropDown.show()
    }
    
    func configureDropDownAppearance() {
        let appearance = DropDown.appearance()
        appearance.backgroundColor = UIColor.AppColors.beige
        appearance.selectionBackgroundColor = UIColor.AppColors.beige
        appearance.textFont = UIFont.main(size: 15)
        appearance.cornerRadius = 12
    }

}
