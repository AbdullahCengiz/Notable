//
//  ReklamViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 18/12/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation
import UIKit

class ReklamViewController: UIViewController,GADBannerViewDelegate,GADInterstitialDelegate {
    var navBar:UINavigationBar!

    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var bannerView: UIView!
    @IBOutlet var removeReklamButton: UIButton!
    @IBOutlet var goToResultPageButton: UIButton!

    //get screenWidth and height from NSUserDefaults
    let width = NSUserDefaults.standardUserDefaults().objectForKey("width") as CGFloat
    let height = NSUserDefaults.standardUserDefaults().objectForKey("height") as CGFloat

    var interstitial:GADInterstitial?


    override func viewDidLoad() {
        super.viewDidLoad()

        navBar = self.navigationController?.navigationBar
        prepareNavigationBar()
        initUI()
        countDown()

        //create progress
        HUDController.sharedController.contentView = HUDContentView.ProgressView()
        HUDController.sharedController.show()

        // for full screen ad
        interstitial = createAndLoadInterstitial()

    }

    func createAndLoadInterstitial()->GADInterstitial {
        var interstitial = GADInterstitial()
        interstitial.delegate = self
        interstitial.adUnitID = "ca-app-pub-1132977094802404/4595528171"
        interstitial.loadRequest(GADRequest())

        return interstitial
    }

    func interstitialDidReceiveAd(ad: GADInterstitial!) {
        HUDController.sharedController.hideAnimated()
        displayInterstitial()

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initUI(){

        bannerView.layer.cornerRadius = 4
        removeReklamButton.layer.cornerRadius = 4
        goToResultPageButton.layer.cornerRadius = 4
        goToResultPageButton.enabled = false

    }

    func countDown(){

        for counter in  0..<6 {

            var passingVariables:[AnyObject] = [5-counter]

            let delay = 0.5

            var timer:NSTimer!


            switch counter {
            case 0:
                timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector: Selector("decreaseCount:"), userInfo: passingVariables, repeats: false)
            case 1:
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("decreaseCount:"), userInfo: passingVariables, repeats: false)
            case 2:
                timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("decreaseCount:"), userInfo: passingVariables, repeats: false)
            case 3:
                timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("decreaseCount:"), userInfo: passingVariables, repeats: false)
            case 4:
                timer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: Selector("decreaseCount:"), userInfo: passingVariables, repeats: false)
            case 5:
                timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("decreaseCount:"), userInfo: passingVariables, repeats: false)
            default:
                println("in timer default")


            }

        }

    }


    @objc func decreaseCount(timer: NSTimer){

        var passingVariables:[AnyObject] = timer.userInfo as [AnyObject]

        println("index = \(passingVariables[0] as Int)")

        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT

        if(passingVariables[0] as Int != 0){
            removeReklamButton.setTitle("Remove Advertisement \(passingVariables[0] as Int)", forState: UIControlState.allZeros)
        }
        else{
            removeReklamButton.setTitle("Remove Advertisement", forState: UIControlState.allZeros)
            goToResultPageButton.enabled = true
        }


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
        uiButton.hidden = true

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

        self.removeReklamButton.backgroundColor = btn
        self.removeReklamButton.setTitleColor(txt, forState: UIControlState.Normal)

        self.goToResultPageButton.backgroundColor = btn
        self.goToResultPageButton.setTitleColor(txt, forState: UIControlState.Normal)

        //change navigation bar color
        self.navigationController!.navigationBar.barTintColor = btn

        //change navigation item title color
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: txt]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
    }



    @IBAction func goToStore(sender: AnyObject) {

        self.performSegueWithIdentifier("goToInAppPurchase", sender: nil)

    }


    @IBAction func goToResultPage(sender: AnyObject) {

        var scoreScreen: NGScore = newGameVC.storyboard!.instantiateViewControllerWithIdentifier("HighScoreViewController") as NGScore
        scoreScreen.delegate = newGameVC
        newGameVC.presentViewController(scoreScreen, animated: true, completion: nil)

    }


    @objc  func displayInterstitial() {
        if let isReady = interstitial?.isReady {
            println("is ready!!!!! ")
            interstitial?.presentFromRootViewController(self)
        }
        else{

            println("is not ready !!!!! ")
        }
    }

    //Interstitial delegate
    func interstitial(ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError!) {
        println("interstitialDidFailToReceiveAdWithError:\(error.localizedDescription)")
        HUDController.sharedController.hideAnimated()
        //interstitial = createAndLoadInterstitial()
    }
    
    func interstitialWillDismissScreen(ad: GADInterstitial!) {
        //interstitial = createAndLoadInterstitial()
        println("ad dismissed")
    }
    
    
}