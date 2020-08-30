//
//  AddCalendarEventViewController.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/30.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class AddCalendarEventViewController: UIViewController {
    private let selectedDates: [Date]
    private let calendarServices: CalendarServices
    private let addEventView = AddCalendarEventView()
    
    init(selectedDates: [Date], calendarService: CalendarServices) {
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
        print(selectedDates)
    }

}
