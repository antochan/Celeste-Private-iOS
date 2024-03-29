//
//  Colors.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/11.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

extension UIColor {
    struct AppColors {
        static let black = UIColor(hexString: "#000000")
        static let beige = UIColor(hexString: "#F5F3F1")
        static let white = UIColor(hexString: "#FFFFFF")
        static let offWhite = UIColor(hexString: "#F9FBF5")
        static let lightGray = UIColor(hexString: "#F6F7FB")
        
        static let pastelOrange = UIColor(hexString: "#FFCCB4")
        static let purple = UIColor(hexString: "#E4DDF0")
        static let lightPurplePastel = UIColor(hexString: "#EFE1EA")
        static let darkPastelPurple = UIColor(hexString: "#D5D8FF")
        static let pastelYellow = UIColor(hexString: "#FEEFD6")
        static let pastelPink = UIColor(hexString: "#FAE4E6")
        static let pastelRed = UIColor(hexString: "#ff6961")
        
        static let koalaOne = UIColor(hexString: "#D9C7FF")
        static let koalaTwo = UIColor(hexString: "#D2BDFF")
        static let koalaThree = UIColor(hexString: "#E6DAFF")
        static let koalaFour = UIColor(hexString: "#D9EEFF")
        static let koalaRedeemButtonColor = UIColor(hexString: "#5D54C1")
        
        static let koalaInnerCircleColor = UIColor(hexString: "#D9EEFF")
        static let couponShadowColor = UIColor(hexString: "#AACCE6")
    }
}
