//
//  MainPageViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 18/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController,GADBannerViewDelegate {

    //for reklam container
    @IBOutlet var reklamContainer: UIView!


    //for hall of fame
    @IBOutlet var goldMedalImage: UIImageView!
    @IBOutlet var silverMedalImage: UIImageView!
    @IBOutlet var bronzeMedalImage: UIImageView!
    @IBOutlet var goldMedalName: UILabel!
    @IBOutlet var goldMedalPoint: UILabel!
    @IBOutlet var silverMedalName: UILabel!
    @IBOutlet var silverMedalPoint: UILabel!
    @IBOutlet var bronzeMedalName: UILabel!
    @IBOutlet var bronzeMedalPoint: UILabel!


    @IBOutlet weak var scoreNumber: UILabel!
    @IBOutlet var newGameLabel: UILabel!
    @IBOutlet var separator: UIView!
    @IBOutlet var newGameButton: UIButton!
    @IBOutlet var newGameContainer: UIView!
    @IBOutlet var lessonsButton: UIButton!
    @IBOutlet var practiceButton: UIButton!
    @IBOutlet var chooseCategoriesButton: UIButton!
    @IBOutlet var practiceLessonsContainer: UIView!

    var arrayOfPoints: [Point] = [Point]()
    var navBar:UINavigationBar!
    var gameQuestions: [Question]!
    
    let newGameButtonTag = 1
    let practiceButtonTag = 2
    let lessonsButtonTag = 3
    let categoriesButtonTag = 4
    
    var width:NSNumber!, height:NSNumber!
    var sound:Sound!

    var coreDataHelper: CoreDataHelper!

    @IBOutlet var navItem: UINavigationItem!


    override func viewDidLoad() {
        super.viewDidLoad()
        println("in MainPageViewController")

        
        width = NSUserDefaults.standardUserDefaults().objectForKey("width") as NSNumber
        height = NSUserDefaults.standardUserDefaults().objectForKey("height") as NSNumber
        
        println("screenWidth= \(width) screenHeight= \(height)")
        
        //prepareUI()
        prepareNavigationBar()
        
    
        
        //for new game container
        newGameContainer.layer.cornerRadius = 4.0
        practiceLessonsContainer.layer.cornerRadius = 4.0
        chooseCategoriesButton.layer.cornerRadius = 4.0
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)


        prepareAdvertisement()

        // Do any additional setup after loading the view.
    
    }


    func prepareAdvertisement(){

        var adHeight:CGFloat = CGFloat(height)

        var origin = CGPointMake(0.0,
            0.0); // place at bottom of view



        adHeight = (adHeight*100)/1136

        var size = GADAdSizeFullWidthPortraitWithHeight(adHeight) // set size to 50
        var adB = GADBannerView(adSize: size, origin: origin) // create the banner
        adB.adUnitID = "ca-app-pub-5033527814399651/5039778123" //"ca-app-pub-XXXXXXXX/XXXXXXX"

        reklamContainer.setTranslatesAutoresizingMaskIntoConstraints(false)
        adB.setTranslatesAutoresizingMaskIntoConstraints(false)

        adB.delegate = self // ??
        adB.rootViewController = self // ??

        reklamContainer.addSubview(adB) // ??



        reklamContainer.addConstraint(NSLayoutConstraint(item:adB, attribute:NSLayoutAttribute.Height,relatedBy:NSLayoutRelation.Equal, toItem: reklamContainer,attribute:NSLayoutAttribute.Height, multiplier:1, constant:0))

        reklamContainer.addConstraint(NSLayoutConstraint(item:adB, attribute:NSLayoutAttribute.Width,relatedBy:NSLayoutRelation.Equal, toItem: reklamContainer,attribute:NSLayoutAttribute.Width, multiplier:1, constant:0))


        reklamContainer.addConstraint(NSLayoutConstraint(item:adB, attribute:NSLayoutAttribute.CenterX,relatedBy:NSLayoutRelation.Equal, toItem:reklamContainer,attribute:NSLayoutAttribute.CenterX, multiplier:1, constant:0))

        reklamContainer.addConstraint(NSLayoutConstraint(item:adB, attribute:NSLayoutAttribute.CenterY,relatedBy:NSLayoutRelation.Equal, toItem:reklamContainer,attribute:NSLayoutAttribute.CenterY, multiplier:1, constant:0))

        /*
        reklamContainer.addConstraint(NSLayoutConstraint(item:adB, attribute:NSLayoutAttribute.BottomMargin,relatedBy:NSLayoutRelation.Equal, toItem:reklamContainer,attribute:NSLayoutAttribute.Bottom, multiplier:0, constant:0))

        reklamContainer.addConstraint(NSLayoutConstraint(item:adB, attribute:NSLayoutAttribute.LeadingMargin,relatedBy:NSLayoutRelation.Equal, toItem:reklamContainer,attribute:NSLayoutAttribute.Leading, multiplier:0, constant:0))
        */


        var request = GADRequest() // create request
        request.testDevices = [ GAD_SIMULATOR_ID ]; // set it to "test" request
        adB.loadRequest(request) // actually load it (?)


    }

  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        styleView()
        sound = Sound()
        setUpPoints()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.title = "MainPage"
        
        
        //controlReklamStatus
        let reklam: Int = NSUserDefaults.standardUserDefaults().objectForKey("reklam") as Int

        if(reklam==0){
            
            reklamContainer.hidden = true
        }
   
        //CHANGE THE MAINPAGE TRANSITION HERE**********

         var zeroHighScore: Int = NSUserDefaults.standardUserDefaults().objectForKey("zeroHighScore") as Int
        
        println(zeroHighScore)
        if(zeroHighScore == 1){
            
            resetHighScores()
        }
    
    //getting the LatestScore
        var pointLabel: Int = NSUserDefaults.standardUserDefaults().objectForKey("pointLabel") as Int
        self.scoreNumber.text  = String(pointLabel)
        
        var nameText: Int = NSUserDefaults.standardUserDefaults().objectForKey("highscoreName") as Int
        //self.userName.text  = String(pointLabel)
    }

    func resetHighScores(){
        
                
        setUpPoints()
        }
    
    
    func prepareNavigationBar(){
        
        //for settings button
        let image = UIImage(named: "settings_button") as UIImage?
        let uiButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        uiButton.frame = CGRectMake(0, 0, 30, 30)
        uiButton.setBackgroundImage(image, forState: UIControlState.Normal)
        uiButton.setTitle("", forState: UIControlState.Normal);
        uiButton.addTarget(self, action:"settingsButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(customView: uiButton), animated: true)
        self.navigationItem.hidesBackButton=true
    }
    
    func styleView() {
        var bg:UIColor = UIColor.whiteColor()
        var btn:UIColor = UIColor.whiteColor()
        var txt:UIColor = UIColor.blackColor()
        Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)
        
        //Background- and ButtonColors
        self.view.backgroundColor = bg
        self.separator.backgroundColor = bg
        self.newGameContainer.backgroundColor = btn
        self.lessonsButton.backgroundColor = btn
        self.practiceButton.backgroundColor = btn
        self.chooseCategoriesButton.backgroundColor = btn
        //TextColor
        self.lessonsButton.setTitleColor(txt, forState: UIControlState.Normal)
        self.practiceButton.setTitleColor(txt, forState: UIControlState.Normal)
        self.chooseCategoriesButton.setTitleColor(txt, forState: UIControlState.Normal)
        self.newGameLabel.textColor = txt
    }
    
        @IBAction func settingsButtonAction(sender:UIButton) {
        println("Button Action From Code")
        self.performSegueWithIdentifier("goToSettings", sender: "settings")
    }
    
    func setUpPoints(){


        
        arrayOfPoints.removeAll(keepCapacity: false)
        
        var highscoreNumberGold: Int = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumberGold") as Int
        var highscoreNumberSilver: Int = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumberSilver") as Int
        var highscoreNumberBronze: Int = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumberBronze") as Int

        var highscoreNameGold: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNameGold")
        var highscoreNameSilver: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNameSilver")
        var highscoreNameBronze: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNameBronze")
        
        var pointLabel: Int = NSUserDefaults.standardUserDefaults().objectForKey("pointLabel") as Int

        self.scoreNumber.text  = String(pointLabel)
        
        println(highscoreNameGold)
        println(highscoreNameGold! as String)
        
        var point1 = Point(userName: highscoreNameGold! as String, point: String(highscoreNumberGold), madelsImage: "Gold.png")
        var point2 = Point(userName: highscoreNameSilver! as String, point: String(highscoreNumberSilver), madelsImage: "Silver.png")
        var point3 = Point(userName: highscoreNameBronze! as String, point: String(highscoreNumberBronze), madelsImage: "Bronze.png")
        var txt2:UIColor = UIColor.grayColor()

        if((highscoreNumberGold as Int) == 0){
            point1 = Point(userName: "No record" as String, point: "", madelsImage: "medal_no.png")
            arrayOfPoints.append(point1)

            goldMedalName.text = "No record"
            goldMedalPoint.text = "0p"
            goldMedalImage.image = UIImage(named: "medal_no.png")

        } else {
            
            arrayOfPoints.append(point1)

            goldMedalName.text = point1.userName
            goldMedalPoint.text = point1.point
            goldMedalImage.image = UIImage(named: point1.madelsImage)
        }
        
        if((highscoreNumberSilver as Int) == 0){
            point2 = Point(userName: "No record" as String, point: "", madelsImage: "medal_no.png")

            silverMedalName.text = "No record"
            silverMedalPoint.text = "0p"
            silverMedalImage.image = UIImage(named: "medal_no.png")

            arrayOfPoints.append(point2)
            
        } else {
            
            arrayOfPoints.append(point2)

            silverMedalName.text = point2.userName
            silverMedalPoint.text = point2.point
            silverMedalImage.image = UIImage(named: point2.madelsImage)
            
        }
        if((highscoreNumberBronze as Int) == 0){
            point3 = Point(userName: "No record" as String, point: "", madelsImage: "medal_no.png")

            bronzeMedalName.text = "No record"
            bronzeMedalPoint.text = "0p"
            bronzeMedalImage.image = UIImage(named: "medal_no.png")

            arrayOfPoints.append(point3)

        } else {

            bronzeMedalName.text = point3.userName
            bronzeMedalPoint.text = point3.point
            bronzeMedalImage.image = UIImage(named: point3.madelsImage)
            
            arrayOfPoints.append(point3)
        }

    }

    @IBAction func goToCategories(sender: AnyObject) {
        
        println("categories!!!!")
        self.performSegueWithIdentifier("goToCategories", sender: "categories")
    }

    
    @IBAction func goToLessonsAction(sender: AnyObject) {
        
        println("lessons!!!!")
        self.performSegueWithIdentifier("goToLessons", sender: "lessons")

    }
    
    
    @IBAction func practiceAction(sender: AnyObject) {
        
        println("practice!!!!")
        self.performSegueWithIdentifier("goToPractice", sender: "practices")
    }
    
    
    @IBAction func newGameAction(sender: AnyObject) {
        
        //println("newGame!!!!")
        //println("will control categories!!!!")
        coreDataHelper = CoreDataHelper()
        var selectedCategories:[Category] = coreDataHelper.getCategories() as [Category]
        println("NumberOfSelectedCategories  = \(selectedCategories.count)")

        if(selectedCategories.count == 0){

            JLToast.makeText("Please add some categories").show()
        }
        else{

            gameQuestions  = coreDataHelper.getQuestionsOfCategories(selectedCategories) as [Question]

            println("number of game questions  = \(gameQuestions.count)")

            if(gameQuestions.count<10){

                JLToast.makeText("Please add more categories").show()

            }
            else{

                self.performSegueWithIdentifier("goToNewGame", sender: "newGame")
                //self.performSegueWithIdentifier("goToNewGame", sender: nil)
                
                sound.playSound(sound.confirmSound)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if(sender? as String == "newGame"){
            let newGameViewController = (segue.destinationViewController as NewGameViewController)
            var newGame = newGameViewController.initTrivQuiz()
            newGame.questions = gameQuestions
        }
    }

    }
