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
    
    @IBOutlet weak var pauseMessages: UILabel!
    @IBOutlet weak var resumeMessages: UILabel!
    @IBOutlet weak var endMessages: UILabel!
    @IBOutlet var settingsLabel: UILabel!


    
    required init(coder aDecoder: NSCoder) {
        self.delegate = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("in NGPauseViewController")
        
        //for Your "NAME" is Paused
        if (delegate!.title!! == "newPractice") {
            pauseMessages.text = "Your Practice is Paused"
        } else if
            (delegate!.title!! == "newGame") {
            self.pauseMessages.text = "Your Game is Paused"
        } else if
            (delegate!.title!! == "newLesson") {
                self.pauseMessages.text = "Your Lesson is Paused"
        } else {
            self.pauseMessages.text = "thisOneGoesToNothing!"
        }
        
        //for TAP HERE TO RESUME "NAME"
        if (delegate!.title!! == "newPractice") {
            resumeMessages.text = "TAP HERE TO RESUME PRACTICE"
        } else if
            (delegate!.title!! == "newGame") {
            self.resumeMessages.text = "TAP HERE TO RESUME GAME"
        } else if
            (delegate!.title!! == "newLesson") {
            self.resumeMessages.text = "TAP HERE TO RESUME LESSON"
        } else {
            self.resumeMessages.text = "thisOneGoesToNothing!"
        }
        
        //for End "NAME"
        if (delegate!.title!! == "newPractice") {
            endMessages.text = "End Practice"
        } else if
            (delegate!.title!! == "newGame") {
                self.endMessages.text = "End Game"
        } else if
            (delegate!.title!! == "newLesson") {
                self.endMessages.text = "End Lesson"
        } else {
            self.endMessages.text = "thisOneGoesToNothing!"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        styleView()
    }
    
    func styleView() {
        var bg:UIColor = UIColor.whiteColor()
        var btn:UIColor = UIColor.whiteColor()
        var txt:UIColor = UIColor.yellowColor()
        Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)
        
        self.view.backgroundColor = bg
        
        self.pauseMessages.textColor = txt
        self.endMessages.textColor = txt
        self.settingsLabel.textColor = txt
        
        
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
    
    @IBAction func resumePage(sender: UIButton) {
 if(delegate != nil) {
    var mNC = delegate!.navigationController as MasterNC
    self.dismissViewControllerAnimated(true, completion: {})
    
        }
    }

    @IBAction func settingsPage(sender: AnyObject) {
        if(delegate != nil) {
            var mNC = delegate!.navigationController as MasterNC
            self.dismissViewControllerAnimated(true, completion: {})
//mNC.popToViewControllerOfClass(settingsViewController())
//Grenuttag? - Not in the main stack? - new segue?
        }
    }


func setColor(#backgroundColor:UIColor){
    
    self.view.backgroundColor = backgroundColor

}
}










