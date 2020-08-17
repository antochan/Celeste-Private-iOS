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
        calendarView.calendarView.allowsMultipleSelection = true
        calendarView.calendarView.register(OurCalendarCell.self, forCellReuseIdentifier: "cell")
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
        
        calendarView.calendarTableView.delegate = self
        calendarView.calendarTableView.dataSource = self
        calendarView.calendarTableView.register(UITableViewCell.self, forCellReuseIdentifier: "testCell")
        
        view.addGestureRecognizer(self.scopeGesture)
        calendarView.calendarTableView.panGestureRecognizer.require(toFail: self.scopeGesture)
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
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
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        self.configureVisibleCells()
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        self.configureVisibleCells()
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: position)
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = "Test"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
