//
//  Theme.swift
//  Notable
//
//  Created by Frida Samuelsson on 17/11/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation
import UIKit

class Theme
{
    //var baseClass : AnyObject!
    //var title : String!
    var currentPage : AnyObject!
    
    
    init(){
        //title = baseClass.title!!
    }
    
    func fetchThemeColors(inout backgroundColor:UIColor, inout buttonColor:UIColor) {
        backgroundColor = UIColor.whiteColor()
        if let bgColorData = NSUserDefaults.standardUserDefaults().objectForKey("colorBackgrounds") as? NSData {
            println("Hej3")
            if let bgColor = NSKeyedUnarchiver.unarchiveObjectWithData(bgColorData) as? UIColor {
                backgroundColor = bgColor
                println("Hej2")
            }
        }
        
        buttonColor = UIColor.blackColor()
        if let buttonColorData = NSUserDefaults.standardUserDefaults().objectForKey("colorButtons") as? NSData {
            println("Hej4")
            if let btnColor = NSKeyedUnarchiver.unarchiveObjectWithData(buttonColorData) as? UIColor {
                println("Hej")
                buttonColor = btnColor
            }
        }
        println("Color1 fetched \(backgroundColor), color \(buttonColor)")
    }
    
    
}

