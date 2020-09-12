//
//  Coupons.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/9/9.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import Foundation
import UIKit

struct Coupon: Codable {
    let title: String
    let description: String
    let redeemed: Bool?
}
