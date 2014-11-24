//
//  SignUpPage.swift
//  Notable
//
//  Created by Frida Samuelsson on 20/11/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController,UITableViewDelegate {
    
    var navBar:UINavigationBar!
    
    
    
    @IBOutlet var navItem: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("in SignUpViewController")
        
        //prepareUI()
        prepareNavigationBar()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        styleView()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.title = "SignUpPage"
        
    }
    
    func prepareNavigationBar(){
        
        //for menubutton
        let menuImage = UIImage(named: "menu_btn") as UIImage?
        navItem.hidesBackButton=true
        
        
    }

    
        
        func styleView() {
            var bg:UIColor = UIColor.whiteColor()
            var btn:UIColor = UIColor.whiteColor()
            var txt:UIColor = UIColor.blackColor()
            Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)
            
            //Background- and ButtonColors
            self.view.backgroundColor = bg
            
        }
}