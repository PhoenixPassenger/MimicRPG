//
//  CustomFonts.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 09/09/21.
//

import UIKit

extension UIFont {
    class func josefinSansBold() -> UIFont {
        guard let font = UIFont(name: "JosefinSans-Bold", size: 24) else {
            fatalError("""
               Failed to load the "JosefinSans-Bold" font.
               Make sure the font file is included in the project and the font name is spelled correctly.
               """
           )
        }
        return font
    }
    
    class func josefinSansBold17() -> UIFont {
        guard let font = UIFont(name: "JosefinSans-Bold", size: 17) else {
            fatalError("""
               Failed to load the "JosefinSans-Bold" font.
               Make sure the font file is included in the project and the font name is spelled correctly.
               """
           )
        }
        return font
    }
    
    class func josefinSansSkillTitle() -> UIFont {
        return josefinSansBold17()
    }
    
    class func josefinSansBold25() -> UIFont {
        guard let font = UIFont(name: "JosefinSans-Bold", size: 25) else {
            fatalError("""
               Failed to load the "JosefinSans-Bold" font.
               Make sure the font file is included in the project and the font name is spelled correctly.
               """
           )
        }
        return font
    }
    
    class func josefinSansSkillDesc() -> UIFont {
        guard let font = UIFont(name: "JosefinSans-Regular", size: 12) else {
            fatalError("""
               Failed to load the "JosefinSans-Bold" font.
               Make sure the font file is included in the project and the font name is spelled correctly.
               """
           )
        }
        return font
    }
    
    class func josefinSansRegular() -> UIFont {
        guard let font = UIFont(name: "JosefinSans-Regular", size: 20) else {
            fatalError("""
               Failed to load the "JosefinSans-Regular" font.
               Make sure the font file is included in the project and the font name is spelled correctly.
               """
           )
        }
        return font
    }
    
    class func josefinSansResult() -> UIFont {
        guard let font = UIFont(name: "JosefinSans-Bold", size: 70) else {
            fatalError("""
               Failed to load the "JosefinSans-Bold" font.
               Make sure the font file is included in the project and the font name is spelled correctly.
               """
           )
        }
        return font
    }
    
    class func josefinSansDetail() -> UIFont {
        guard let font = UIFont(name: "JosefinSans-Regular", size: 14) else {
            fatalError("""
               Failed to load the "JosefinSans-Regular" font.
               Make sure the font file is included in the project and the font name is spelled correctly.
               """
           )
        }
        return font
    }
    
    class func josefinSansButton() -> UIFont {
        guard let font = UIFont(name: "JosefinSans-Regular", size: 17) else {
            fatalError("""
               Failed to load the "JosefinSans-Regular" font.
               Make sure the font file is included in the project and the font name is spelled correctly.
               """
           )
        }
        return font
    }
}

