//
//  NGPause.swift
//  Notable
//
//  Created by Frida Samuelsson on 12/11/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation
import UIKit

class NGPause: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("in MainPageViewController")
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    
    override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    }

    
    @IBAction func goToMainPageAction(sender:UIButton) {
    println("In Pause Game Back")
        self.performSegueWithIdentifier("goToMainPage", sender: nil)
    }
    
    
}
    
    
    
    
