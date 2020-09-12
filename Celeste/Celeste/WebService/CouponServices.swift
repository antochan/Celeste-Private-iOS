//
//  CouponServices.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/9/11.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class CouponServices {
    typealias getCouponsHandler = (_ result: Result<[Coupon]>) -> Void
    
    private func reference(to collectionReference: CollectionReferences) -> CollectionReference {
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    func configure() {
        FirebaseApp.configure()
    }
    
    func getCoupons(who: Who, completion: @escaping getCouponsHandler) {
        
        reference(to: .Coupons).document(who.rawValue).collection("Coupons").getDocuments { (querySnapshot, error) in
            var coupons = [Coupon]()
            if let error = error {
                completion(Result.failure(CouponFailures.couponDataError(error)))
            } else {
                for document in querySnapshot!.documents {
                    let event = try! FirestoreDecoder().decode(Coupon.self, from: document.data())
                    coupons.append(event)
                }
                completion(Result.success(coupons))
            }
        }
    }
    
}
