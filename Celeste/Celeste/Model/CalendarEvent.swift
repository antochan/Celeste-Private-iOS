//
//  CalendarEvent.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/17.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import Foundation

enum EventType {
    case food
    case altered
    case date
    case specialDay
    case random
}

struct CalendarEvent {
    let date: String // In YYYY/MM/dd format
    let eventType: EventType
    let eventLocation: String?
    let eventTitle: String
}
