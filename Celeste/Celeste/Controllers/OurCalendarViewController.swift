//
//  CalendarViewController.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/15.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import FSCalendar
import SPStorkController

class OurCalendarViewController: UIViewController {
    private let who: Who
    let calendarView = OurCalendarView()
    private let calendarServices: CalendarServices
    
    var presented: Bool = false {
        didSet {
            calendarView.appearAnimation()
        }
    }
    
    private var calendarData: [CalendarEvent] = [] {
        didSet {
            calendarView.calendarView.reloadData()
            updateCalendarTableEventsData()
        }
    }
    private var calendarEventsTableData: [CalendarEvent] = [] {
        didSet {
            calendarView.calendarTableView.reloadData()
        }
    }
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendarView.calendarView, action: #selector(self.calendarView.calendarView.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()
    
    init(who: Who, calendarServices: CalendarServices) {
        self.who = who
        self.calendarServices = calendarServices
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
        fetchEventsData()
    }
    
    func fetchEventsData() {
        calendarServices.getCalendarEvents { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let calendarEvents):
                strongSelf.calendarData = calendarEvents
            case .failure(_):
                strongSelf.displayAlert(message: "Something went wrong getting dates from server, let anto know :( Sorry! 420", title: "Oops!")
            }
        }
    }
    
    func removeCalendarEvent(calendarEvent: CalendarEvent) {
        calendarServices.removeCalendarEvent(calendarEvent: calendarEvent) { [weak self] success in
            guard let strongSelf = self else { return }
            if success {
                strongSelf.fetchEventsData()
            } else {
                strongSelf.displayAlert(message: "Something went wrong attempting to delete this event, let anto know 421!", title: "Oops!")
            }
        }
    }
    
    func configureActions() {
        calendarView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        calendarView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    func configureCalendar() {
        calendarView.calendarView.delegate = self
        calendarView.calendarView.dataSource = self
        calendarView.calendarView.allowsMultipleSelection = true
        calendarView.calendarView.register(OurCalendarCell.self, forCellReuseIdentifier: "CalendarCell")
        calendarView.calendarView.appearance.headerTitleColor = UIColor.AppColors.black
        calendarView.calendarView.appearance.headerTitleFont = UIFont.mainMedium(size: 22)
        calendarView.calendarView.appearance.weekdayFont = UIFont.main(size: 13)
        calendarView.calendarView.appearance.weekdayTextColor = .lightGray
        calendarView.calendarView.placeholderType = .none
        calendarView.calendarView.appearance.titleFont = UIFont.main(size: 14)
        calendarView.calendarView.appearance.titleTodayColor = .black
        calendarView.calendarView.appearance.headerMinimumDissolvedAlpha = 0
        calendarView.calendarView.appearance.caseOptions = .weekdayUsesSingleUpperCase
        calendarView.calendarView.appearance.headerDateFormat = "MMMM"
        calendarView.calendarView.appearance.eventOffset = CGPoint(x: 0, y: -Spacing.four)
        calendarView.calendarView.appearance.eventDefaultColor = UIColor.AppColors.purple
        calendarView.calendarView.appearance.eventSelectionColor = UIColor.AppColors.beige
        
        calendarView.calendarTableView.delegate = self
        calendarView.calendarTableView.dataSource = self
        calendarView.calendarTableView.register(ComponentTableViewCell<CalendarEventTableCellComponent>.self, forCellReuseIdentifier: "CalendarEventCell")
        
        view.addGestureRecognizer(self.scopeGesture)
        calendarView.calendarTableView.panGestureRecognizer.require(toFail: self.scopeGesture)
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func addButtonTapped() {
        if calendarView.calendarView.selectedDates.isEmpty {
            displayAlert(message: "No selected dates! Select at least one date to add an event!", title: "Oops!")
        } else {
            let addEventViewController = AddCalendarEventViewController(selectedDates: calendarView.calendarView.selectedDates.map({self.dateFormatter.string(from: $0)}),
                                                                        calendarService: calendarServices)
            addEventViewController.delegate = self
            let transitionDelegate = SPStorkTransitioningDelegate()
            transitionDelegate.customHeight = 610
            addEventViewController.transitioningDelegate = transitionDelegate
            addEventViewController.modalPresentationStyle = .custom
            addEventViewController.modalPresentationCapturesStatusBarAppearance = true
            present(addEventViewController, animated: true, completion: nil)
        }
    }
    
    func updateCalendarTableEventsData() {
        calendarEventsTableData = calendarData.filter { event in calendarView.calendarView.selectedDates.contains(where: { dateFormatter.string(from: $0) == event.date }) }
        calendarView.noEventLabel.isHidden = !calendarEventsTableData.isEmpty
    }
    
    func calendarMoreTapped(calendarEvent: CalendarEvent) {
        let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you want to delete this event?", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction) in
            self.removeCalendarEvent(calendarEvent: calendarEvent)
        }))

        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction) in
            // no - op
        }))

        present(alert, animated: true)
    }
}

//MARK: - UIGestureRecognizerDelegate

extension OurCalendarViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = calendarView.calendarTableView.contentOffset.y <= -calendarView.calendarTableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch calendarView.calendarView.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            @unknown default:
                return false
            }
        }
        return shouldBegin
    }
}

//MARK: -  FSCalendarDelegate & FSCalendarDataSource

extension OurCalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarView.calendarHeightConstraint?.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        configureVisibleCells()
        updateCalendarTableEventsData()
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        configureVisibleCells()
        updateCalendarTableEventsData()
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CalendarCell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: position)
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if !calendarData.filter({ $0.date == dateFormatter.string(from: date) }).isEmpty {
            return 1
        } else {
            return 0
        }
    }
    
    private func configureVisibleCells() {
        calendarView.calendarView.visibleCells().forEach { (cell) in
            let date = calendarView.calendarView.date(for: cell)
            let position = calendarView.calendarView.monthPosition(for: cell)
            self.configure(cell: cell, for: date!, at: position)
        }
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        
        let diyCell = (cell as! OurCalendarCell)
        // Custom today circle
        diyCell.circleImageView.isHidden = !self.gregorian.isDateInToday(date)

        // Configure selection layer
        if position == .current {
            var selectionType = SelectionType.none
            if calendarView.calendarView.selectedDates.contains(date) {
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
                if calendarView.calendarView.selectedDates.contains(date) {
                    if calendarView.calendarView.selectedDates.contains(previousDate) && calendarView.calendarView.selectedDates.contains(nextDate) {
                        selectionType = .middle
                    }
                    else if calendarView.calendarView.selectedDates.contains(previousDate) && calendarView.calendarView.selectedDates.contains(date) {
                        selectionType = .rightBorder
                    }
                    else if calendarView.calendarView.selectedDates.contains(nextDate) {
                        selectionType = .leftBorder
                    }
                    else {
                        selectionType = .single
                    }
                }
            }
            else {
                selectionType = .none
            }
            if selectionType == .none {
                diyCell.selectionLayer.isHidden = true
                return
            }
            diyCell.selectionLayer.isHidden = false
            diyCell.selectionType = selectionType
        } else {
            diyCell.circleImageView.isHidden = true
            diyCell.selectionLayer.isHidden = true
        }
    }
}

//MARK: -  UITableViewDelegate & UITableViewDataSource

extension OurCalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendarEventsTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarEventCell", for: indexPath) as! ComponentTableViewCell<CalendarEventTableCellComponent>
        let calendarComponentVM = CalendarEventTableCellComponent.ViewModel(calendarEvent: calendarEventsTableData[indexPath.row])
        let cellVM = ComponentTableViewCell<CalendarEventTableCellComponent>.ViewModel(componentViewModel: calendarComponentVM)
        cell.apply(viewModel: cellVM)
        cell.selectionStyle = .none
        cell.component.actions = { [weak self] calendarEvent in
            guard let event = calendarEvent, let strongSelf = self else { return }
            strongSelf.calendarMoreTapped(calendarEvent: event)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 186
        return UITableView.automaticDimension
    }
}

//MARK: - AddCalendarEventDelegate

extension OurCalendarViewController: AddCalendarEventDelegate {
    func successfullyAdded() {
        fetchEventsData()
    }
}
