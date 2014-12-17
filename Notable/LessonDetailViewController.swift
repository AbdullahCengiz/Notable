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

    //for noteview and textview

    @IBOutlet var textViewArea: UIView!
    @IBOutlet var noteViewArea: UIView!

    //for clef images
    @IBOutlet var gClef: UIImageView!
    @IBOutlet var fClef: UIImageView!

    //for container definitions

    @IBOutlet var pictureContainer: UIView!
    @IBOutlet var textContainer: UIView!
    @IBOutlet var lineContainer: UIView!
    @IBOutlet var clefContainer: UIView!

    //for uilabels
    @IBOutlet var questionTitleText: UILabel!
    @IBOutlet var questionText: UILabel!

    //for questionPicture
    @IBOutlet var questionPicture: UIImageView!

    // for noteView
    @IBOutlet var noteView: UIView!

    // for play button
    @IBOutlet var playButton: UIButton!



    var newLesson:TrivLesson!

    var questionIndexLabel:UILabel!

    func initTrivLesson(viewController:LessonDetailViewController) -> TrivLesson{

        newLesson = TrivLesson(viewController: viewController)
        return newLesson
        
    }






    override func viewDidLoad() {
        super.viewDidLoad()

        println("number of questions in lesson is \(newLesson.questions!.count)")

        newLesson.initLesson()
        newLesson.prepareQuestion(newLesson.currentQuestion)


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

        textViewArea.layer.cornerRadius = 4
        noteViewArea.layer.cornerRadius = 4 

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

        newLesson.trivLessonNoteView.clearAllScrollNotes()
        newLesson.prepareQuestion(newLesson.currentQuestion)

    }


    @IBAction func prevAction(sender: AnyObject) {

        if(newLesson.currentQuestion >= 1){

            newLesson.currentQuestion--
            
        }

        questionIndexLabel.text = "\(newLesson.currentQuestion+1) of \(newLesson.questions.count)"

        newLesson.trivLessonNoteView.clearAllScrollNotes()
        newLesson.prepareQuestion(newLesson.currentQuestion)

    }

    func roundCorners(#view:UIView, corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        view.layer.mask = mask
    }




    @IBAction func playButtonAction(sender: AnyObject) {

        newLesson.trivLessonNoteView.clearAllScrollNotes()

        newLesson.prepareQuestion(newLesson.currentQuestion)

    }

}
