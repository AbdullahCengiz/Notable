//
//  MainPageViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 18/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource {



    @IBOutlet weak var scoreNumber: UILabel!
    @IBOutlet var newGameLabel: UILabel!
    @IBOutlet var separator: UIView!
    @IBOutlet var newGameButton: UIButton!
    @IBOutlet var pointsTableView: UITableView!
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
        
        self.pointsTableView.delegate = self
        self.pointsTableView.dataSource = self
        
        width = NSUserDefaults.standardUserDefaults().objectForKey("width") as NSNumber
        height = NSUserDefaults.standardUserDefaults().objectForKey("height") as NSNumber
        
        println("screenWidth= \(width) screenHeight= \(height)")
        
        //prepareUI()
        prepareNavigationBar()
        setUpPoints()
    
        
        //for new game container
        newGameContainer.layer.cornerRadius = 4.0
        practiceLessonsContainer.layer.cornerRadius = 4.0
        chooseCategoriesButton.layer.cornerRadius = 4.0
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        // Do any additional setup after loading the view.
    
    }
    @IBOutlet var reklamContainerMainPage: UIView!
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        styleView()
        sound = Sound()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.title = "MainPage"
        
        
        //controlReklamStatus
        let reklam: Int = NSUserDefaults.standardUserDefaults().objectForKey("reklam") as Int

        if(reklam==0){
            
            reklamContainerMainPage.hidden = true
            
            //CHANGE THE MAINPAGE TRANSITION HERE**********
        
            
        }
        
         var zeroHighScore: Int = NSUserDefaults.standardUserDefaults().objectForKey("zeroHighScore") as Int
        
        println(zeroHighScore)
        if(zeroHighScore == 1){
            
            resetHighScores()
            
        }
    
    //getting the LatestScore
         var pointLabel: Int = NSUserDefaults.standardUserDefaults().objectForKey("pointLabel") as Int
        self.scoreNumber.text  = String(pointLabel)
        
        
    }


    
    
    func resetHighScores(){
        
        arrayOfPoints.removeAll(keepCapacity: false)
        
        self.pointsTableView.reloadData()
        
    }
    
    
    func prepareNavigationBar(){
        
        //for settings button
        let image = UIImage(named: "settings_button") as UIImage?
        let uiButton    = UIButton.buttonWithType(UIButtonType.System) as UIButton
        uiButton.frame  = CGRectMake(0, 0, 30, 30)
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
        self.pointsTableView.reloadData()
        self.pointsTableView.separatorColor = btn
        //TextColor
        self.lessonsButton.setTitleColor(txt, forState: UIControlState.Normal)
        self.practiceButton.setTitleColor(txt, forState: UIControlState.Normal)
        self.chooseCategoriesButton.setTitleColor(txt, forState: UIControlState.Normal)
        self.newGameLabel.textColor = txt
        
    }
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    @IBAction func settingsButtonAction(sender:UIButton) {
        println("Button Action From Code")
        self.performSegueWithIdentifier("goToSettings", sender: "settings")
    }
    
    
    func setUpPoints(){
        
        var point1 = Point(userName: "Alexander", point: "110p", madelsImage: "Gold.png")
        var point2 = Point(userName: "Alexander", point: "120p", madelsImage: "Silver.png")
        var point3 = Point(userName: "Alexander", point: "130p", madelsImage: "Bronze.png")
    
        arrayOfPoints.append(point1)
        arrayOfPoints.append(point2)
        arrayOfPoints.append(point3)
        
        
        }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfPoints.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let pointCell: PointTableCell = self.pointsTableView.dequeueReusableCellWithIdentifier("pointCell") as PointTableCell
        
        
        let currentPoint = arrayOfPoints[indexPath.row]
        pointCell.setCell(currentPoint.userName, pointLabel: currentPoint.point, image: currentPoint.madelsImage)
        return pointCell
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: PointTableCell, forRowAtIndexPath indexPath: NSIndexPath) {
        var bg:UIColor = UIColor.whiteColor()
        var btn:UIColor = UIColor.whiteColor()
        var txt: UIColor = UIColor.yellowColor()
        Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)
        
        cell.cellBackground.backgroundColor = bg
       // cell.separatorColor.backgroundColor = btn
        
        cell.nameLabel.textColor = txt
        cell.pointLabel.textColor = txt

        
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
            newGameViewController.questions = gameQuestions
        }

    }




        
}
