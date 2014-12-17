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
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(nameLabel: String,pointLabel: String , image: String){
        var defaults = NSUserDefaults()
        
        /*
        var highscoreName = defaults.stringArrayForKey("highscoreName")
        
        var highscoreNameShow = defaults.stringArrayForKey("highscoreName")
        
        self.nameLabel.text = "Name: \(highscoreNameShow)"

        var highscoreNumber = defaults.integerForKey("highscoreNumber")
        
        var highscoreNumberShow = defaults.integerForKey("highscoreNumber")
        self.pointLabel.text = "Number: \(highscoreNumberShow)"
        
        */
        
        //Check if score is higher than NSUserDefaults stored value and change NSUserDefaults stored value if it's true
        //score = datan på Main page nummer
        
        /*
        var highscoreNumber: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNumber") as Int
        
        var highestValue:Int = 5000
        
        if(highscoreNumber == nil){
            println(highscoreNumber)
        }
        
       
        
        
        if ((highscoreNumber! as Int) == highestValue) {
        var goldValue = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumber")
        NSUserDefaults.standardUserDefaults().setInteger((highscoreNumber! as Int), forKey: "highscoreNumber")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        } else if (highscoreNumber < goldValue) {
        var siverValue = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumber")
        NSUserDefaults.standardUserDefaults().setInteger((highscoreNumber! as Int), forKey: "highscoreNumber")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        } else if (highscoreNumber < silverValue) {
        var bronzeValue = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumber")
        NSUserDefaults.standardUserDefaults().setInteger((highscoreNumber! as Int), forKey: "highscoreNumber")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        } else if (highscoreNumber < bronzeValue){
        
        println("Did not reach highscore")
        
        }
        
*/
        
        self.nameLabel.text = nameLabel
        self.pointLabel.text = pointLabel
        self.medalsImage.image = UIImage(named:image)

        
    }
    }