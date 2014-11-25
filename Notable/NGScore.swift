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

    
    required init(coder aDecoder: NSCoder) {
        self.delegate = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congratsView.layer.cornerRadius = 4.0
        
        
        println("in NGScoreViewController")
        var nameTextField: UITextField!
        
        
        if self.nameTextField.text.isEmpty {
            
            println("Clicked on testButton!")
            
            
        } else {
            self.nameTextField.text = "Enter Your Name" }
        // insert link to rest of code for getting it to the highscore here Frida!
        
        
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
        
    }}