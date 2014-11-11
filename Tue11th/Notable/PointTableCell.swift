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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(nameLabel: String,pointLabel: String , image: String){
        self.nameLabel.text = nameLabel
        self.pointLabel.text = pointLabel
        self.medalsImage.image = UIImage(named:image)
        
    }

}
