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

    var delegate:UIViewController?

    @IBOutlet weak var pauseMessages: UILabel!
    @IBOutlet weak var resumeMessages: UILabel!
    @IBOutlet weak var endMessages: UILabel!
    @IBOutlet var settingsLabel: UILabel!

    @IBOutlet var goSettings: UILabel!

    @IBOutlet var endGame: UILabel!



    required init(coder aDecoder: NSCoder) {
        self.delegate = nil
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        println("in NGPauseViewController")

        //for Your "NAME" is Paused
        if (delegate!.title! == "newPractice") {
            pauseMessages.text = "Your Practice is Paused"
        }
        else if
            (delegate!.title! == "endPractice") {
                self.pauseMessages.text = "Your Practice is Completed"
        }
        else if
            (delegate!.title! == "newGame") {
                self.pauseMessages.text = "Your Game is Paused"
        } else if
            (delegate!.title! == "Choose Lesson") {
                self.pauseMessages.text = "Your Lesson is Paused"
        }
        else if
            (delegate!.title! == "In App Purchases") {
                self.pauseMessages.text = "Your Shopping is Paused"
        }
        else {
            self.pauseMessages.text = "thisOneGoesToNothing!"
        }



        //for TAP HERE TO RESUME "NAME"
        if (delegate!.title! == "newPractice") {
            resumeMessages.text = "TAP HERE TO RESUME PRACTICE"
        }
        else if
            (delegate!.title! == "endPractice") {
                resumeMessages.text = "TAP HERE TO RETURN CATEGORY SELECTION"
        }
        else if
            (delegate!.title! == "newGame") {
                self.resumeMessages.text = "TAP HERE TO RESUME GAME"
        } else if
            (delegate!.title! == "Choose Lesson") {
                self.resumeMessages.text = "TAP HERE TO RESUME LESSON"
        }
        else if
            (delegate!.title! == "In App Purchases") {
                self.resumeMessages.text = "TAP HERE TO RESUME SHOPPING"
        }
        else {
            self.resumeMessages.text = "thisOneGoesToNothing!"
        }

        //for End "NAME"
        if (delegate!.title! == "newPractice") {
            endMessages.text = "End Practice"
        } else if
            (delegate!.title! == "newGame") {
                self.endMessages.text = "End Game"
        } else if
            (delegate!.title! == "Choose Lesson") {
                self.endMessages.text = "End Lesson"
        }
        else if
            (delegate!.title! == "In App Purchases") {
                self.endMessages.text = "End Shopping"
        }
        else {
            self.endMessages.text = "thisOneGoesToNothing!"
        }

        //for setting font sizes
        setFontSizes()
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

        }
    }

    @IBAction func resumePage(sender: UIButton) {
        if(delegate != nil) {

            if
                (delegate!.title! == "endPractice") {
                    var mNC = delegate!.navigationController as MasterNC
                    mNC.popToViewControllerOfClass(PracticeViewController())
                    self.dismissViewControllerAnimated(true, completion: {})
            }
            else {

                var mNC = delegate!.navigationController as MasterNC
                self.dismissViewControllerAnimated(true, completion: {})
            }

        }
    }

    @IBAction func settingsLink(sender: AnyObject) {
        if(delegate != nil) {

            println("Will open settings page !!!!!!!!!")


            var settingsPage: SettingsViewController = delegate!.storyboard!.instantiateViewControllerWithIdentifier("SettingsViewController") as SettingsViewController

            settingsPage.delegate = self

            println(settingsPage)
            println(delegate!)

            self.delegate!.navigationController?.pushViewController(settingsPage, animated: true)


            self.dismissViewControllerAnimated(true, completion: {

                println("NGPause dismissed !!!!!!!!!")


            })

        }

    }


    func setColor(#backgroundColor:UIColor){

        self.view.backgroundColor = backgroundColor

    }


    func setFontSizes(){

        let TRI_ISIPHONE = UIDevice.currentDevice().userInterfaceIdiom == .Phone;
        let TRI_ISIPAD = UIDevice.currentDevice().userInterfaceIdiom == .Pad;

        if(TRI_ISIPAD){

            pauseMessages.font = UIFont (name: "Roboto-Light", size: 50)

            resumeMessages.font = UIFont (name: "Roboto-Light", size: 22)

            endMessages.font = UIFont (name: "Roboto-Light", size: 50)

            settingsLabel.font = UIFont (name: "Roboto-Light", size: 50)

            goSettings.font = UIFont (name: "Roboto-Light", size: 22)

            endGame.font = UIFont (name: "Roboto-Light", size: 22)


        }else{

            pauseMessages.font = UIFont (name: "Roboto-Light", size: 25)

            resumeMessages.font = UIFont (name: "Roboto-Light", size: 13)
            
            endMessages.font = UIFont (name: "Roboto-Light", size: 25)
            
            settingsLabel.font = UIFont (name: "Roboto-Light", size: 25)
            
            goSettings.font = UIFont (name: "Roboto-Light", size: 13)
            
            endGame.font = UIFont (name: "Roboto-Light", size: 13)
            
            
        }
        
    }
    
    
}
