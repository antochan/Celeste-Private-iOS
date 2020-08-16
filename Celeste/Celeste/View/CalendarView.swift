//
//  CalendarView.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/15.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import HorizonCalendar

class OurCalendarView: UIView {
    let calendar = OurCalendarView(initialContent: makeContent())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeContent() -> CalendarViewContent {
        let calendar = Calendar(identifier: .gregorian)
        
        let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
    }
    
}

//MARK: - Private

private extension OurCalendarView {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(calendar)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            calendar.leadingAnchor.constraint(equalTo: leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
