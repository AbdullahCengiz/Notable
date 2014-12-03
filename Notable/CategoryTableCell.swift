//
//  CategoryTableCell.swift
//  Notable
//
//  Created by abdullah cengiz on 30/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit


class CategoryTableCell: UITableViewCell {
    
    @IBOutlet weak var categoryTableCell: UIView!
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var tickImage: UIImageView!
    



func styleView() {
        var bg:UIColor = UIColor.greenColor()
        var btn:UIColor = UIColor.yellowColor()
        var txt:UIColor = UIColor.blueColor()
        Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)

        self.categoryNameLabel.textColor = txt
        self.categoryNameLabel.backgroundColor = btn
        self.categoryTableCell.backgroundColor = btn
        self.contentView.backgroundColor = btn
    }



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
    func setCell(categoryNameLabel: String){
        self.categoryNameLabel.text = categoryNameLabel
        
        
        
        styleView()
        

    }
}