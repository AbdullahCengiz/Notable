//
//  SignUpViewController.swift
//  Notable
//
//  Created by Frida Samuelsson on 20/11/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation
import UIImage


func prepareNavigationBar(){
    
    //for settings button
    let image = UIImage(named: "settings_button") as UIImage?
    let uiButton    = UIButton.buttonWithType(UIButtonType.System) as UIButton
    uiButton.frame  = CGRectMake(0, 0, 30, 30)
    uiButton.setBackgroundImage(image, forState: UIControlState.Normal)
    uiButton.setTitle("", forState: UIControlState.Normal);
    uiButton.addTarget(self, action:"settingsButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
    self.navigationItem.setRightBarButtonItem(UIBarButtonItem(customView: uiButton), animated: true)
    self.navigationItem.hidesBackButton=true
}