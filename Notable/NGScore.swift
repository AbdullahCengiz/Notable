//
//  NGScore.swift
//  Notable
//
//  Created by Frida Samuelsson on 25/11/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import AVFoundation


class NGScore: UIViewController, UITableViewDelegate {
    
    var delegate: AnyObject?

    @IBOutlet var textFieldBg: UIView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var congratsView: UIView!
    @IBOutlet var sendButton: UIButton!


    
    required init(coder aDecoder: NSCoder) {
        self.delegate = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congratsView.layer.cornerRadius = 4.0
        sendButton.layer.cornerRadius = 4.0
        
        
        println("in NGScoreViewController")

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func showFromRect(_rect: CGRect, inView view: UIView!, animated: Bool)(nameTextField: UITextField){
        
        var delegate: UIActionSheet
    }

    func setColor(#backgroundColor:UIColor){
        
        self.view.backgroundColor = backgroundColor
        
    }

      @IBAction func sendButton(sender: UIButton) {
        var nameTextField: UITextField!
            setUpPoints()
        
        if self.nameTextField.text.isEmpty {
            
            println("Name not entered!")
            
            
        } else {
            self.nameTextField.text = "\(self.nameTextField.text)"
                NSUserDefaults.standardUserDefaults().objectForKey("nameText")
                NSUserDefaults.standardUserDefaults().synchronize()
 
            
            println("entered name = \(self.nameTextField.text)")
            
            
        }
        
        // insert link to rest of code for getting it to the highscore here Frida!
        
        
        func textFieldDidEndEditing(textField: UITextField!){
            
            NSUserDefaults.standardUserDefaults().didChangeValueForKey("highscoreName")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            println("Name inserted. Woho!")
            
            
        }
        
        //Pop to MainPageControllerView
        var mNC = delegate!.navigationController as MasterNC
        mNC.popToViewControllerOfClass(MainPageViewController())
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    
    func setUpPoints(){
        
        
        var highscoreNumberGold: Int = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumberGold") as Int
        var highscoreNumberSilver: Int = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumberSilver") as Int
        var highscoreNumberBronze: Int = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumberBronze") as Int
        
        
        
        var highscoreNameGold: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNameGold")
        var highscoreNameSilver: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNameSilver")
        var highscoreNameBronze: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNameBronze")

        
        
        var pointLabel: Int = NSUserDefaults.standardUserDefaults().objectForKey("pointLabel") as Int

    
        
        if (pointLabel > highscoreNumberGold){
            highscoreNumberBronze = highscoreNumberSilver
            highscoreNumberSilver = highscoreNumberGold
            highscoreNumberGold = pointLabel
            
            
            NSUserDefaults.standardUserDefaults().setObject(self.nameTextField.text, forKey: "highscoreNameGold")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            
        }else if (pointLabel > highscoreNumberSilver){
            highscoreNumberBronze = highscoreNumberSilver
            highscoreNumberSilver = pointLabel
            
            NSUserDefaults.standardUserDefaults().setObject(self.nameTextField.text, forKey: "highscoreNameSilver")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        else if (pointLabel > highscoreNumberBronze){
            highscoreNumberBronze = pointLabel
            
            NSUserDefaults.standardUserDefaults().setObject(self.nameTextField.text, forKey: "highscoreNameBronze")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
        
        
        NSUserDefaults.standardUserDefaults().setInteger(highscoreNumberGold, forKey: "highscoreNumberGold")
        NSUserDefaults.standardUserDefaults().synchronize()
        NSUserDefaults.standardUserDefaults().setInteger(highscoreNumberSilver, forKey: "highscoreNumberSilver")
        NSUserDefaults.standardUserDefaults().synchronize()
        NSUserDefaults.standardUserDefaults().setInteger(highscoreNumberBronze, forKey: "highscoreNumberBronze")
        NSUserDefaults.standardUserDefaults().synchronize()
        
       
        
        }


}