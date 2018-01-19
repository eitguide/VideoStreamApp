//
//  UIColor.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/16/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    public convenience init(hex: Int) {
        let components = getColorComponents(hex)
        self.init(red: components.red, green: components.green, blue: components.blue, alpha: 1.0)
    }
    
    public convenience init(hex: Int, alpha: CGFloat) {
        let components = getColorComponents(hex)
        self.init(red: components.red, green: components.green, blue: components.blue, alpha: alpha)
    }
    
    convenience init(hexString: String) {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        Scanner(string: hexSanitized).scanHexInt32(&rgb)
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    
    public func alpha(_ value:CGFloat) -> UIKit.UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return UIKit.UIColor(red: red, green: green, blue: blue, alpha: value)
    }
    
    public final func toRGBAComponents() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return (r, g, b, a)
        }
        
        return (0, 0, 0, 0)
    }
}

private func getColorComponents(_ value: Int) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
    let r = CGFloat(value >> 16 & 0xFF) / 255.0
    let g = CGFloat(value >> 8 & 0xFF) / 255.0
    let b = CGFloat(value & 0xFF) / 255.0
    
    return (r, g, b)
}
