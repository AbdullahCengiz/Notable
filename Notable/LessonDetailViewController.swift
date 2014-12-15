//
//  LessonDetailViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 11/12/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import UIKit
import QuartzCore


class LessonDetailViewController: UIViewController {

    //for height and width
    let width = NSUserDefaults.standardUserDefaults().objectForKey("width") as CGFloat
    let height = NSUserDefaults.standardUserDefaults().objectForKey("height") as CGFloat

    @IBOutlet var navItem: UINavigationItem!

    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!

    // for constraints
    @IBOutlet var nextButtonHeight: NSLayoutConstraint!
    @IBOutlet var previousButtonHeight: NSLayoutConstraint!

    var newLesson:TrivLesson!

    var questionIndexLabel:UILabel!

    func initTrivLesson() -> TrivLesson{


        newLesson = TrivLesson(viewController:self)

        return newLesson
        
    }






    override func viewDidLoad() {
        super.viewDidLoad()

        println("number of questions in lesson is \(newLesson.questions!.count)")


    }


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        prepareNavigationBar()

        initUI()
        //styleView()

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func initUI(){


        var nextButtonCircleHeight = (((((NSUserDefaults.standardUserDefaults().objectForKey("height") as CGFloat)*1008)/1136))*224)/1008

        var previousButtonCircleHeight = (((((NSUserDefaults.standardUserDefaults().objectForKey("height") as CGFloat)*1008)/1136))*160)/1008


        nextButtonHeight.constant = nextButtonCircleHeight
        previousButtonHeight.constant = previousButtonCircleHeight

        nextButton.layer.cornerRadius  = nextButtonCircleHeight/2
        previousButton.layer.cornerRadius  = previousButtonCircleHeight/2

        previousButton.sizeToFit()
        nextButton.sizeToFit()



        /*
        previousButton.layer.cornerRadius  = previousButton.frame.size.height/4
        nextButton.layer.cornerRadius  = nextButton.frame.size.height/4
        */

    }

    func prepareNavigationBar(){

        //for menubutton
        let menuImage = UIImage(named: "menu_btn") as UIImage?
        let menuButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        menuButton.frame = CGRectMake(0, 0, 25, 25)
        menuButton.setBackgroundImage(menuImage, forState: UIControlState.Normal)
        menuButton.setTitle("", forState: UIControlState.Normal);
        menuButton.addTarget(self, action:"backButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        navItem.setLeftBarButtonItem(UIBarButtonItem(customView: menuButton), animated: true)
        navItem.hidesBackButton=true


        //for settings button
        questionIndexLabel = UILabel()
        questionIndexLabel.textColor = UIColor.blackColor()
        questionIndexLabel.frame  = CGRectMake(0, 0, 90, 30)
        questionIndexLabel.textAlignment = NSTextAlignment.Center
        navItem.setRightBarButtonItem(UIBarButtonItem(customView: questionIndexLabel), animated: true)

        questionIndexLabel.text = "\(newLesson.currentQuestion+1) of \(newLesson.questions.count)"

        
    }

    @IBAction func backButtonAction(sender:UIButton) {
        //////println("Button Action From Code")

        var pauseScreen:NGPause = self.storyboard!.instantiateViewControllerWithIdentifier("PausedGameViewController") as NGPause
        self.title="Choose Lesson"
        pauseScreen.delegate = self
        self.presentViewController(pauseScreen, animated: true, completion: nil)
        
    }


    @IBAction func nextAction(sender: AnyObject) {

        if(newLesson.currentQuestion < newLesson.questions.count-1){

            newLesson.currentQuestion++

        }

        questionIndexLabel.text = "\(newLesson.currentQuestion+1) of \(newLesson.questions.count)"

    }


    @IBAction func prevAction(sender: AnyObject) {

        if(newLesson.currentQuestion >= 1){

            newLesson.currentQuestion--
            
        }

        questionIndexLabel.text = "\(newLesson.currentQuestion+1) of \(newLesson.questions.count)"

    }



}
