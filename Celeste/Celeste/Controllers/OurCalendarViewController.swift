//
//  CalendarViewController.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/15.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import FSCalendar

class OurCalendarViewController: UIViewController {
    private let who: Who
    let calendarView = OurCalendarView()

    var presented: Bool = false {
        didSet {
            calendarView.appearAnimation()
        }
    }
    
    init(who: Who) {
        self.who = who
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = calendarView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calendarView.appearAnimation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureActions()
        configureCalendar()
    }
    
    func configureActions() {
        calendarView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func configureCalendar() {
        calendarView.calendarView.delegate = self
        calendarView.calendarView.dataSource = self
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
}

//MARK: -  FSCalendarDelegate & FSCalendarDataSource

extension OurCalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.view.layoutIfNeeded()
    }
    
    
}
