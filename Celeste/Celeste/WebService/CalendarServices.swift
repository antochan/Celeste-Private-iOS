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
    
}
