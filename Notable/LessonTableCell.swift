//
//  LessonsTableCell.swift
//  Notable
//
//  Created by abdullah cengiz on 11/12/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation

class LessonTableCell: UITableViewCell {


    @IBOutlet var lessonNameLabel: UILabel!
    @IBOutlet var lessonHint: UILabel!

    @IBOutlet var lessonCellRoot: UIView!

    func styleView() {
        var bg:UIColor = UIColor.greenColor()
        var btn:UIColor = UIColor.yellowColor()
        var txt:UIColor = UIColor.blueColor()
        Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)

        self.lessonNameLabel.textColor = txt
        self.lessonNameLabel.backgroundColor = btn
        self.lessonHint.textColor = txt
        self.lessonHint.backgroundColor = btn
        self.lessonCellRoot.backgroundColor = bg
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


    func setCell(#lessonNameLabel: String,lessonHint:String){

        self.lessonNameLabel.text = lessonNameLabel
        self.lessonHint.text = lessonHint
        styleView()
        
    }
}