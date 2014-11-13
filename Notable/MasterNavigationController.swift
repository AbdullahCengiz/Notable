//
//  MasterNavigationController.swift
//  Notable
//
//  Created by Frida Samuelsson on 12/11/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation
import UIKit

class MasterNC:UINavigationController, UINavigationControllerDelegate {
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
        self.delegate = self;
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        updateTitle()
    }
    
    func updateTitle() {
        //for logo
        println(self.visibleViewController.navigationItem.title)
        if self.visibleViewController.navigationItem.title == nil {
            let logo = UIImage(named: "logo_small.png")
            let imageView = UIImageView(image:logo)
             imageView.frame = CGRectMake(0, 0, 44, 44)
            self.visibleViewController.navigationItem.titleView = imageView
          
        }
    }
    
    func popToViewControllerOfClass(targetClass:AnyObject!) {
        for vc in self.viewControllers {
            if object_getClassName(vc) == object_getClassName(targetClass) {
                self.popToViewController(vc as UIViewController, animated: true)
                break
            }
        }
    }

/*-(void)popToViewControllerOfClass:(Class)class {
for (UIViewController *aViewController in [self viewControllers]) {
if ([aViewController isKindOfClass:class]) {
reloadDataOnAppear = YES;
[self popToViewController:aViewController animated:NO];
}
}
}*/

}