//
//  MasterNavigationController.swift
//  Notable
//
//  Created by Frida Samuelsson on 12/11/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation
import UIKit

class MasterNC:UINavigationController {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if let font = UIFont(name: "Roboto-Light", size: 20) {
            self.navigationBar.titleTextAttributes =
                [NSFontAttributeName: font,
                    NSForegroundColorAttributeName: UIColor.blackColor()]
        } else {
            self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        }
        
        self.navigationBar.barTintColor = UIColor.whiteColor()
    }
}