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
    var baseClass : AnyObject!
    
    
    init(targetClass:AnyObject!){
        
        baseClass  = targetClass
    }
    
    
    func setTheme(themeName:String){
        
        println(baseClass.title!!)
        
        var settingsPage = baseClass as SettingsViewController
        
        var backgroundColor = UIColor()
        var buttonColor = UIColor()
        
        if themeName == "firstTheme" {
            
            
            //First
            if let firstThemeBackgroundColorData = NSUserDefaults.standardUserDefaults().objectForKey("firstThemeBackgroundColor") as? NSData {
                if let firstThemeBackgroundColor = NSKeyedUnarchiver.unarchiveObjectWithData(firstThemeBackgroundColorData) as? UIColor {
                    println(firstThemeBackgroundColor)
                    backgroundColor = firstThemeBackgroundColor
                }
            }
            
            if let firstThemeButtonColorData = NSUserDefaults.standardUserDefaults().objectForKey("firstThemeButtonColor") as? NSData {
                if let firstThemeButtonColor = NSKeyedUnarchiver.unarchiveObjectWithData(firstThemeButtonColorData) as? UIColor {
                    println(firstThemeButtonColor)
                    buttonColor = firstThemeButtonColor
                }
            }
            
            
            
        }
        else if (themeName == "secondTheme") {
            
            //Second
            if let secondThemeBackgroundColorData = NSUserDefaults.standardUserDefaults().objectForKey("secondThemeBackgroundColor") as? NSData {
                if let secondThemeBackgroundColor = NSKeyedUnarchiver.unarchiveObjectWithData(secondThemeBackgroundColorData) as? UIColor {
                    println(secondThemeBackgroundColor)
                    backgroundColor = secondThemeBackgroundColor
                }
            }
            
            if let secondThemeButtonColorData = NSUserDefaults.standardUserDefaults().objectForKey("secondThemeButtonColor") as? NSData {
                if let secondThemeButtonColor = NSKeyedUnarchiver.unarchiveObjectWithData(secondThemeButtonColorData) as? UIColor {
                    println(secondThemeButtonColor)
                    buttonColor = secondThemeButtonColor
                }
            }}
            
            //Third
        else if themeName == "thirdTheme" {
            
            if let thirdThemeBackgroundColorData = NSUserDefaults.standardUserDefaults().objectForKey("thirdThemeBackgroundColor") as? NSData {
                if let thirdThemeBackgroundColor = NSKeyedUnarchiver.unarchiveObjectWithData(thirdThemeBackgroundColorData) as? UIColor {
                    println(thirdThemeBackgroundColor)
                    backgroundColor = thirdThemeBackgroundColor
                }
            }
            
            if let thirdThemeButtonColorData = NSUserDefaults.standardUserDefaults().objectForKey("thirdThemeButtonColor") as? NSData {
                if let thirdThemeButtonColor = NSKeyedUnarchiver.unarchiveObjectWithData(thirdThemeButtonColorData) as? UIColor {
                    println(thirdThemeButtonColor)
                    buttonColor = thirdThemeButtonColor
                }
            }}
            
            
            //Fourth
        else if themeName == "fourthTheme" {
            
            if let fourthThemeBackgroundColorData = NSUserDefaults.standardUserDefaults().objectForKey("fourthThemeBackgroundColor") as? NSData {
                if let fourthThemeBackgroundColor = NSKeyedUnarchiver.unarchiveObjectWithData(fourthThemeBackgroundColorData) as? UIColor {
                    println(fourthThemeBackgroundColor)
                    backgroundColor = fourthThemeBackgroundColor
                }
            }
            
            if let fourthThemeButtonColorData = NSUserDefaults.standardUserDefaults().objectForKey("fourthThemeButtonColor") as? NSData {
                if let fourthThemeButtonColor = NSKeyedUnarchiver.unarchiveObjectWithData(fourthThemeButtonColorData) as? UIColor {
                    println(fourthThemeButtonColor)
                    buttonColor = fourthThemeButtonColor
                }
            }}
            
          //Fifth
            
        else if themeName == "fifthTheme" {
            
            if let fifthThemeBackgroundColorData = NSUserDefaults.standardUserDefaults().objectForKey("fifthThemeBackgroundColor") as? NSData {
                if let fifthThemeBackgroundColor = NSKeyedUnarchiver.unarchiveObjectWithData(fifthThemeBackgroundColorData) as? UIColor {
                    println(fifthThemeBackgroundColor)
                    backgroundColor = fifthThemeBackgroundColor
                }
            }
            
            if let fifthThemeButtonColorData = NSUserDefaults.standardUserDefaults().objectForKey("fifthThemeButtonColor") as? NSData {
                if let fifthThemeButtonColor = NSKeyedUnarchiver.unarchiveObjectWithData(fifthThemeButtonColorData) as? UIColor {
                    println(fifthThemeButtonColor)
                    buttonColor = fifthThemeButtonColor
                }
            }
        }
        
        setColor(backgroundColor:backgroundColor,
            buttonColor: buttonColor,baseClass:settingsPage)
        
    }
    
    
    func setColor(#backgroundColor:UIColor,buttonColor:UIColor,baseClass:SettingsViewController){
        
        baseClass.view.backgroundColor = backgroundColor
        baseClass.soundSlider.backgroundColor = buttonColor
        baseClass.resetAnswersButton.backgroundColor = buttonColor
        baseClass.resetHighScoresButton.backgroundColor = buttonColor
        baseClass.soundLevelInicatorContainer.backgroundColor = buttonColor
        baseClass.colorSlider.backgroundColor = buttonColor
        baseClass.storeButton.backgroundColor = buttonColor
    }

    
    
}

