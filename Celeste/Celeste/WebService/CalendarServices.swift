//
//  CalendarServices.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/29.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class CalendarServices {
    typealias getDatesInfoHandler = (_ result: Result<[CalendarEvent]>) -> Void
    typealias postCalendarEventsHandler = (_ success: Bool) -> Void
    typealias removeCalendarEventsHandler = (_ success: Bool) -> Void
    
    private func reference(to collectionReference: CollectionReferences) -> CollectionReference {
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    func configure() {
        FirebaseApp.configure()
    }
    
    func getCalendarEvents(completion: @escaping getDatesInfoHandler) {
        reference(to: .Calendar).getDocuments { (querySnapshot, error) in
            var calendarEvents = [CalendarEvent]()
            if let error = error {
                completion(Result.failure(CalendarFailures.calendarDataError(error)))
            } else {
                for document in querySnapshot!.documents {
                    let event = try! FirestoreDecoder().decode(CalendarEvent.self, from: document.data())
                    calendarEvents.append(event)
                }
                completion(Result.success(calendarEvents))
            }
        }
    }
    
    func postCalendarEvents(calendarEvents: [CalendarEvent], completion: @escaping postCalendarEventsHandler) {
        calendarEvents.forEach {
            reference(to: .Calendar).document($0.id).setData([
                "date": $0.date,
                "eventDescription": $0.eventDescription ?? "",
                "eventLocation": $0.eventLocation ?? "",
                "eventTitle": $0.eventTitle,
                "eventType": $0.eventType.rawValue,
                "id": $0.id
            ]) { err in
                if let _ = err {
                    completion(false)
                }
            }
        }
        completion(true)
    }
    
    func removeCalendarEvent(calendarEvent: CalendarEvent, completion: @escaping removeCalendarEventsHandler) {
        reference(to: .Calendar).document(calendarEvent.id).delete() { err in
            if let _ = err {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
}
