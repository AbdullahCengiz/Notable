//
//  InAppPurchaseTableCell.swift
//  Notable
//
//  Created by abdullah cengiz on 22/12/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation

import UIKit


class InAppPurchaseTableCell: UITableViewCell {

    @IBOutlet weak var innAppPurchaseTableCell: UIView!
    @IBOutlet var innAppPurchaseName: UILabel!
    @IBOutlet var innAppPurchasePrice: UILabel!

    func styleView() {
        var bg:UIColor = UIColor.greenColor()
        var btn:UIColor = UIColor.yellowColor()
        var txt:UIColor = UIColor.blueColor()
        Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)

        self.innAppPurchaseName.textColor = txt
        self.innAppPurchaseName.backgroundColor = btn
        self.innAppPurchasePrice.textColor = txt
        self.innAppPurchasePrice.backgroundColor = btn
        self.innAppPurchaseTableCell.backgroundColor = btn
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

    func setCell(#innAppPurchaseName: String , innAppPurchasePrice:String){

        self.innAppPurchaseName.text = innAppPurchaseName
        self.innAppPurchasePrice.text = innAppPurchasePrice
        styleView()
        
    }
}