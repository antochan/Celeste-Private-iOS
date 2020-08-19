//
//  CalendarEvent.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/17.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import Foundation
import UIKit

enum EventType: String {
    case food = "Food"
    case altered = "Altered"
    case date = "Date"
    case specialDay = "Special Occasion"
    case random = "Random"
    
    public var color: UIColor {
        switch self {
        case .food:
            return UIColor.AppColors.pastelOrange
        case .altered:
            return UIColor.AppColors.pastelPink
        case .date:
            return UIColor.AppColors.pastelRed
        case .specialDay:
            return UIColor.AppColors.purple
        case .random:
            return UIColor.AppColors.pastelYellow
        }
    }
}

struct CalendarEvent {
    let date: String // In YYYY/MM/dd format
    let eventType: EventType
    let eventLocation: String?
    let eventTitle: String
}
