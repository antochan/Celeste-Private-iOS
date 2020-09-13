//
//  Fonts.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/10.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

extension UIFont {
    class func bellefair(size: CGFloat) -> UIFont {
        return UIFont(name: "Bellefair-Regular", size: size)!
    }
    
    class func main(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    class func mainItalic(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Italic", size: size)!
    }
    
    class func mainBold(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    
    class func mainMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    
    class func caros(size: CGFloat) -> UIFont {
        return UIFont(name: "CarosSoftLight", size: size)!
    }
    
    class func carosMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "CarosSoft", size: size)!
    }
    
    class func carosLight(size: CGFloat) -> UIFont {
        return UIFont(name: "CarosSoftLight", size: size)!
    }
    
    class func carosExtraLight(size: CGFloat) -> UIFont {
        return UIFont(name: "CarosSoftExtraLight", size: size)!
    }
}
