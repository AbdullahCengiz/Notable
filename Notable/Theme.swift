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
    
    func fetchThemeColors(inout backgroundColor:UIColor, inout buttonColor:UIColor, inout textColor:UIColor) {
        
        backgroundColor = UIColor(red:226/255.0, green:232/255.0, blue:239/255.0, alpha:1.0)
        if let bgColorData = NSUserDefaults.standardUserDefaults().objectForKey("colorBackgrounds") as? NSData {
            //println("Hej3")
            if let bgColor = NSKeyedUnarchiver.unarchiveObjectWithData(bgColorData) as? UIColor {
                backgroundColor = bgColor
                //println("Dummy bg color 2")
            }
        }
        
        buttonColor = UIColor.whiteColor()
        if let buttonColorData = NSUserDefaults.standardUserDefaults().objectForKey("colorButtons") as? NSData {
            //println("Hej4")
            if let btnColor = NSKeyedUnarchiver.unarchiveObjectWithData(buttonColorData) as? UIColor {
                //println("Dummy btn color 2")
                buttonColor = btnColor
            }
        }
        textColor = UIColor.blackColor()
        if let textColorData = NSUserDefaults.standardUserDefaults().objectForKey("colorText") as? NSData {
            //println("Hej5")
            if let txtColor = NSKeyedUnarchiver.unarchiveObjectWithData(textColorData) as? UIColor {
                //println("Dummy txt color 2")
                textColor = txtColor
            }
        }

        //println("Color1 fetched \(backgroundColor), color \(buttonColor)")
    }
    
    
}

