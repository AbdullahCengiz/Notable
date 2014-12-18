//
//  ReklamViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 18/12/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import UIKit

class ReklamViewController: UIViewController {
    var navBar:UINavigationBar!

    @IBOutlet var navItem: UINavigationItem!



    override func viewDidLoad() {
        super.viewDidLoad()

        navBar = self.navigationController?.navigationBar
        prepareNavigationBar()

        /*
        storeViewImageContainer.layer.cornerRadius  = 4.0
        animateBtn.layer.cornerRadius  = 4.0
        */

        //get saved theme

    }

    //***HERE IS THE HIDE REKLAM ANIMATION ***



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func prepareNavigationBar(){

        //for back button
        let image = UIImage(named: "backbutton") as UIImage?
        let uiButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        uiButton.frame = CGRectMake(0, 0, 25, 25)
        uiButton.setBackgroundImage(image, forState: UIControlState.Normal)
        uiButton.setTitle("", forState: UIControlState.Normal);
        uiButton.addTarget(self, action:"backButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        navItem.setLeftBarButtonItem(UIBarButtonItem(customView: uiButton), animated: true)
        navItem.hidesBackButton=true
    }


    @IBAction func backButtonAction(sender:UIButton) {
        println("Button Action From Code")
        self.navigationController?.popViewControllerAnimated(true)
    }


    func setColor(#backgroundColor:UIColor){

        self.view.backgroundColor = backgroundColor
    }


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        styleView()

    }

    func styleView() {

        var bg:UIColor = UIColor.whiteColor()
        var btn:UIColor = UIColor.whiteColor()
        var txt:UIColor = UIColor.blackColor()
        Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)

        self.view.backgroundColor = bg
        /*
        self.storeViewImageContainer.backgroundColor = btn
        self.animateBtn.backgroundColor = btn
        self.animateBtn.setTitleColor(txt, forState: UIControlState.Normal)
        */

    }

    }