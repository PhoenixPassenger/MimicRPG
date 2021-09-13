//
//  CustomColors.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 09/09/21.
//

import UIKit
// swiftlint:disable all
extension UIColor {
    // MARK: - Color Hex Code Approach
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        if length == 6 {
            red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            alpha = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    // MARK: - Custom Colors
    static var azure: UIColor { return UIColor(hex: "#2F80ED")! }
    
    static var vividSkyBlue: UIColor { return UIColor(hex: "#56CCF2")! }
    
    static var brandy: UIColor { return UIColor(hex: "#853B3B")! }
    
    static var lightBrandy: UIColor { return UIColor(hex: "#FFD8D9")! }
    
    static var shamrock: UIColor { return UIColor(hex: "#3E9C5E")! }
    
    static var lightShamrock: UIColor { return UIColor(hex: "#B0EBC4")! }
    
    static var gunmetal: UIColor { return UIColor(hex: "#182B38")! }
    
    static var darkGunmetal: UIColor { return UIColor(hex: "#14222C")! }
    
    static var ivory: UIColor { return UIColor(hex: "#F7FBEF")! }
    
    static var cultured: UIColor { return UIColor(hex: "#F2F2F2")! }
}
