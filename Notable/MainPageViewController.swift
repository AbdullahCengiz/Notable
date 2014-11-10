//
//  MainPageViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 18/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource {
    
    @IBOutlet var newGameButton: UIButton!
    @IBOutlet var pointsTableView: UITableView!
    @IBOutlet var newGameContainer: UIView!
    
    @IBOutlet var lessonsButton: UIButton!
    @IBOutlet var practiceButton: UIButton!
    @IBOutlet var chooseCategoriesButton: UIButton!
    @IBOutlet var practiceLessonsContainer: UIView!
    var arrayOfPoints: [Point] = [Point]()
    var navBar:UINavigationBar!
    
    let newGameButtonTag = 1
    let practiceButtonTag = 2
    let lessonsButtonTag = 3
    let categoriesButtonTag = 4
    
    var width:NSNumber!, height:NSNumber!
    

    @IBOutlet var navItem: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        println("in MainPageViewController")
        
        
        navBar = self.navigationController?.navigationBar
        
        self.pointsTableView.delegate = self
        self.pointsTableView.dataSource = self
        
        width = NSUserDefaults.standardUserDefaults().objectForKey("width") as NSNumber
        height = NSUserDefaults.standardUserDefaults().objectForKey("height") as NSNumber

        println("screenWidth= \(width) screenHeight= \(height)")
        
        //prepareUI()
        prepareNavigationBar()
        setUpPoints()
        
        navBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 20),
            NSForegroundColorAttributeName: UIColor.blackColor()]
        navBar.barTintColor = UIColor.whiteColor()
        
        //for new game container
        newGameContainer.layer.cornerRadius=4.0
        practiceLessonsContainer.layer.cornerRadius=4.0
        chooseCategoriesButton.layer.cornerRadius = 4.0
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        
        
       
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        

        
        
           }
    
    
    func prepareUI(){
        
        
        NSLayoutConstraint.deactivateConstraints(self.view.constraints())
        
        //Do not use CGRectMake() when you create your instance of UIView
        newGameContainer = UIView()
        newGameContainer.backgroundColor = UIColor.whiteColor()
        view.addSubview(newGameContainer)
        
        //Don't forget this line
        newGameContainer.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        
        //for newGameContainer
        var constX = NSLayoutConstraint(item: newGameContainer, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.view.addConstraint(constX)
        var constY = NSLayoutConstraint(item: newGameContainer, attribute: NSLayoutAttribute.TopMargin, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 64 + (height*48)/1136)
        self.view.addConstraint(constY)
        //set "toItem: nil" when defining Width
        var constW = NSLayoutConstraint(item: newGameContainer, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: (width*576)/640)
        newGameContainer.addConstraint(constW)
        //view.addConstraint(constW) also work
        //set "toItem: nil" when defining Height
        var constH = NSLayoutConstraint(item: newGameContainer, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: (height*158)/1136)
        newGameContainer.addConstraint(constH)
        newGameContainer.layer.cornerRadius = 4
        
        
        //add label to new game container
        
        var newGameLabel = UILabel()
        newGameLabel.textAlignment = NSTextAlignment.Center
        newGameLabel.text = "New Game"
        let font = UIFont(name: "System", size: 50.0)
        newGameLabel.font = font
        newGameContainer.addSubview(newGameLabel)
        newGameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
       
        var constNewGameLabelX = NSLayoutConstraint(item: newGameLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: newGameContainer, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        newGameContainer.addConstraint(constNewGameLabelX)
        var constNewGameLabelY = NSLayoutConstraint(item: newGameLabel, attribute: NSLayoutAttribute.TopMargin, relatedBy: NSLayoutRelation.Equal, toItem: newGameContainer, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 0)
        newGameContainer.addConstraint(constNewGameLabelY)

        
        var constNewGameLabelW = NSLayoutConstraint(item: newGameLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: (width*576)/640)
        newGameLabel.addConstraint(constNewGameLabelW)
        //view.addConstraint(constW) also work
        //set "toItem: nil" when defining Height
        var constNewGameLabelH = NSLayoutConstraint(item: newGameLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: (height*35)/1136)
        newGameLabel.addConstraint(constNewGameLabelH)
        
        newGameLabel.textColor = UIColor.blackColor()
        newGameContainer.backgroundColor = UIColor.whiteColor()
        
        
        var constNewGameLabelTopMargin = NSLayoutConstraint(item: newGameLabel, attribute: NSLayoutAttribute.TopMargin, relatedBy: NSLayoutRelation.Equal, toItem: newGameContainer, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: (height*40)/1136)
        self.view.addConstraint(constNewGameLabelTopMargin)

    }

    

    func prepareNavigationBar(){
        
        //for settings button
        let image = UIImage(named: "settings") as UIImage?
        let uiButton    = UIButton.buttonWithType(UIButtonType.System) as UIButton
        uiButton.frame  = CGRectMake(0, 0, 30, 30)
        uiButton.setBackgroundImage(image, forState: UIControlState.Normal)
        uiButton.setTitle("", forState: UIControlState.Normal);
        uiButton.addTarget(self, action:"settingsButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        navItem.setRightBarButtonItem(UIBarButtonItem(customView: uiButton), animated: true)
        navItem.hidesBackButton=true
        
        //for logo
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image:logo)
        imageView.frame = CGRectMake(0, 0, 30, 30)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        navItem.titleView = imageView

        
    }
    
    
    
    
    
    
    @IBAction func settingsButtonAction(sender:UIButton)
    {
        println("Button Action From Code")
        self.performSegueWithIdentifier("goToSettings", sender: nil)
    }
    
    
    func setUpPoints(){
        
        var point1 = Point(userName: "Alexander", point: "110p", madelsImage: "gold.gif")
        var point2 = Point(userName: "Alexander", point: "120p", madelsImage: "silver.gif")
        var point3 = Point(userName: "Alexander", point: "130p", madelsImage: "bronze.gif")
        var point4 = Point(userName: "Alexander", point: "140p", madelsImage: "star.gif")
        var point5 = Point(userName: "Alexander", point: "150p", madelsImage: "star.gif")
        
        
        arrayOfPoints.append(point1)
        arrayOfPoints.append(point2)
        arrayOfPoints.append(point3)
        arrayOfPoints.append(point4)
        arrayOfPoints.append(point5)
       
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfPoints.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let pointCell :PointTableCell = self.pointsTableView.dequeueReusableCellWithIdentifier("pointCell") as PointTableCell
        
        let currentPoint = arrayOfPoints[indexPath.row]
        pointCell.setCell(currentPoint.userName, pointLabel: currentPoint.point, image: currentPoint.madelsImage)
        return pointCell
        
    }
    
    
    @IBAction func goToCategories(sender: AnyObject) {
        
        println("categories!!!!")
        self.performSegueWithIdentifier("goToCategories", sender: nil)
        
    }
    
    
    
    
    @IBAction func goToLessonsAction(sender: AnyObject) {
        
        println("lessons!!!!")
        self.performSegueWithIdentifier("goToLessons", sender: nil)
        
    }
    
    
    
    @IBAction func practiceAction(sender: AnyObject) {
        
        println("practice!!!!")
        self.performSegueWithIdentifier("goToPractice", sender: nil)
        
    }
    
    
    @IBAction func newGameAction(sender: AnyObject) {
        
        println("newGame!!!!")
        self.performSegueWithIdentifier("goToNewGame", sender: nil)
        
    }
    
    
}
