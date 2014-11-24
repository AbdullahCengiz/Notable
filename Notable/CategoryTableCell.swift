//
//  CategoryTableCell.swift
//  Notable
//
//  Created by abdullah cengiz on 30/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit


class CategoryTableCell: UITableViewCell {
    
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var tickImage: UIImageView!
    
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
        
        
    }
    
    
}
