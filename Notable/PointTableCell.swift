//
//  PointTableCellTableViewCell.swift
//  Notable
//
//  Created by abdullah cengiz on 23/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit

class PointTableCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var pointLabel: UILabel!
    @IBOutlet var medalsImage: UIImageView!
    @IBOutlet var cellBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // self.nameLabel.setTitle = "\(self.nameTextField.text)"


    
   
    
    //Check if score is higher than NSUserDefaults stored value and change NSUserDefaults stored value if it's true
    //FIX 26/11!!!!!!!!!!
/*
    var score = 5
    var goldValue = 5000
    var HSData: Int = NSUserDefaults.standardUserDefaults().integerForKey("HSData")
    
    /*
    if score > NSUserDefaults.standardUserDefaults().integerForKey("HSData") {
    NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "HSdata")
    NSUserDefaults.standardUserDefaults().synchronize()
    */
    
    if (score = goldValue){
        let goldValue = NSUserDefaults.standardUserDefaults().integerForKey("HSData")
    NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "HSdata")
    NSUserDefaults.standardUserDefaults().synchronize()
    
    } else if (score < goldValue) {
        let siverValue = NSUserDefaults.standardUserDefaults().integerForKey("HSData")
    NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "HSdata")
    NSUserDefaults.standardUserDefaults().synchronize()
    
    } else if (score < silverValue) {
        let bronzeValue = NSUserDefaults.standardUserDefaults().integerForKey("HSData")
    NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "HSdata")
    NSUserDefaults.standardUserDefaults().synchronize()
    
    } else if (score < bronzeValue){
    
    println("Did not reach highscore")

    }
*/
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCell(nameLabel: String,pointLabel: String , image: String){
        var defaults = NSUserDefaults()
        var highscoreName = defaults.stringArrayForKey("highscoreName")
        
        var highscoreNameShow = defaults.stringArrayForKey("highscoreName")
        
        self.nameLabel.text = "Name: \(highscoreNameShow)"

        var highscoreNumber = defaults.integerForKey("highscoreNumber")
        
        var highscoreNumberShow = defaults.integerForKey("highscoreNumber")
        self.pointLabel.text = "Number: \(highscoreNumberShow)"
        
        
        self.medalsImage.image = UIImage(named:image)
        
    }
    }