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

}