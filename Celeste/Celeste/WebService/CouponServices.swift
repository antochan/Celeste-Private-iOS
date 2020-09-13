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
    typealias redeemCouponHandler = (_ success: Bool) -> Void
    typealias giftCouponHandler = (_ success: Bool) -> Void
    
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
    
    func redeemCoupon(who: Who, coupon: Coupon, completion: @escaping redeemCouponHandler) {
        reference(to: .Coupons).document(who.rawValue).collection("Coupons").document(coupon.id).updateData(["redeemed": true]) { error in
            if let _ = error {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func giftCoupon(who: Who, coupon: Coupon, completion: @escaping giftCouponHandler) {
        reference(to: .Coupons).document(who.rawValue).collection("Coupons").document(coupon.id).setData([
            "id": coupon.id,
            "title": coupon.title,
            "description": coupon.description,
            "redeemed": false
        ]) { err in
            if let _ = err {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
