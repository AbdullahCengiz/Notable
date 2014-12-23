//
//  ReklamViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 18/12/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import UIKit

class ReklamViewController: UIViewController,GADBannerViewDelegate {
    var navBar:UINavigationBar!

    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var bannerView: UIView!
    @IBOutlet var removeReklamButton: UIButton!
    @IBOutlet var goToResultPageButton: UIButton!

    //get screenWidth and height from NSUserDefaults
    let width = NSUserDefaults.standardUserDefaults().objectForKey("width") as CGFloat
    let height = NSUserDefaults.standardUserDefaults().objectForKey("height") as CGFloat


    override func viewDidLoad() {
        super.viewDidLoad()

        navBar = self.navigationController?.navigationBar
        prepareNavigationBar()

        initUI()

        countDown()

        prepareAdvertisement()

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


    func prepareAdvertisement(){

        var adHeight:CGFloat = CGFloat(height)

        var origin = CGPointMake(0.0,
            0.0); // place at bottom of view



        adHeight = (adHeight*300)/1136

        var size = GADAdSizeFullWidthPortraitWithHeight(adHeight) // set size to 50
        var adB = GADBannerView(adSize: size, origin: origin) // create the banner
        adB.adUnitID = "ca-app-pub-5033527814399651/5039778123" //"ca-app-pub-XXXXXXXX/XXXXXXX"

        bannerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        adB.setTranslatesAutoresizingMaskIntoConstraints(false)

        adB.delegate = self // ??
        adB.rootViewController = self // ??

        bannerView.addSubview(adB) // ??



        bannerView.addConstraint(NSLayoutConstraint(item:adB, attribute:NSLayoutAttribute.Height,relatedBy:NSLayoutRelation.Equal, toItem: bannerView,attribute:NSLayoutAttribute.Height, multiplier:1, constant:0))

        bannerView.addConstraint(NSLayoutConstraint(item:adB, attribute:NSLayoutAttribute.Width,relatedBy:NSLayoutRelation.Equal, toItem: bannerView,attribute:NSLayoutAttribute.Width, multiplier:1, constant:0))


        bannerView.addConstraint(NSLayoutConstraint(item:adB, attribute:NSLayoutAttribute.CenterX,relatedBy:NSLayoutRelation.Equal, toItem:bannerView,attribute:NSLayoutAttribute.CenterX, multiplier:1, constant:0))

        bannerView.addConstraint(NSLayoutConstraint(item:adB, attribute:NSLayoutAttribute.CenterY,relatedBy:NSLayoutRelation.Equal, toItem:bannerView,attribute:NSLayoutAttribute.CenterY, multiplier:1, constant:0))

        /*
        reklamContainer.addConstraint(NSLayoutConstraint(item:adB, attribute:NSLayoutAttribute.BottomMargin,relatedBy:NSLayoutRelation.Equal, toItem:reklamContainer,attribute:NSLayoutAttribute.Bottom, multiplier:0, constant:0))

        reklamContainer.addConstraint(NSLayoutConstraint(item:adB, attribute:NSLayoutAttribute.LeadingMargin,relatedBy:NSLayoutRelation.Equal, toItem:reklamContainer,attribute:NSLayoutAttribute.Leading, multiplier:0, constant:0))
        */


        var request = GADRequest() // create request
        request.testDevices = [ GAD_SIMULATOR_ID ]; // set it to "test" request
        adB.loadRequest(request) // actually load it (?)
        
        
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


    }