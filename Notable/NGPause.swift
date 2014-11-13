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

    var delegate:AnyObject?
    
    required init(coder aDecoder: NSCoder) {
        self.delegate = nil
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("in NGPauseViewController")
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    
    override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    }

    
    @IBAction func goToMainPageAction(sender: UIButton) {
        if(delegate != nil) {
            var mNC = delegate!.navigationController as MasterNC
            mNC.popToViewControllerOfClass(MainPageViewController())
            self.dismissViewControllerAnimated(true, completion: {})
            
            mNC.popToViewControllerOfClass(PracticeViewController())
            self.dismissViewControllerAnimated(true, completion: {})
            
            mNC.popToViewControllerOfClass(LessonsViewController())
            self.dismissViewControllerAnimated(true, completion: {})
        }
    }
}
    
    
    
    
