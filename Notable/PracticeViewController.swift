//
//  PracticeViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 24/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit

//frida samuelsson

class PracticeViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource {
    @IBOutlet var navItem: UINavigationItem!
    var loadedArrayOfCategories: [Category] = [Category]()
    var cdHelper : CoreDataHelper!
    var gameQuestions: [Question]!

    @IBOutlet var categoriesTableView: UITableView!
    

    
    var delegate:AnyObject?
    var navBar:UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar = self.navigationController?.navigationBar
        // Do any additional setup after loading the view.

        self.categoriesTableView.delegate = self
        self.categoriesTableView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false

        categoriesTableView.layer.cornerRadius = 4.0
        categoriesTableView.separatorColor = UIColor.blackColor()

        cdHelper = CoreDataHelper()

        loadCategories()
        
        initUI()
    }
    
    func initUI() {
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareNavigationBar()
                styleView()
    }
    
    func styleView() {
        var bg:UIColor = UIColor.whiteColor()
        var btn:UIColor = UIColor.whiteColor()
        var txt:UIColor = UIColor.blackColor()
        Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)
        
        self.view.backgroundColor = bg
        
    }

    func prepareNavigationBar(){
        
        //for menubutton
        let menuImage = UIImage(named: "menu_btn") as UIImage?
        let menuButton    = UIButton.buttonWithType(UIButtonType.System) as UIButton
        menuButton.frame  = CGRectMake(0, 0, 25, 25)
        menuButton.setBackgroundImage(menuImage, forState: UIControlState.Normal)
        menuButton.setTitle("", forState: UIControlState.Normal);
        menuButton.addTarget(self, action:"backButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        navItem.setLeftBarButtonItem(UIBarButtonItem(customView: menuButton), animated: true)
        navItem.hidesBackButton=true


        
    }



    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedArrayOfCategories.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let categoryCell :CategoryTableCell = self.categoriesTableView.dequeueReusableCellWithIdentifier("categoryCell") as CategoryTableCell

        let currentCategory = loadedArrayOfCategories[indexPath.row]

        categoryCell.setCell(currentCategory.categoryName!)

        return categoryCell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        let categoryCell :CategoryTableCell = categoriesTableView.cellForRowAtIndexPath(indexPath) as CategoryTableCell

        var selectedCategory : Category = loadedArrayOfCategories[indexPath.row]

        var selectedCategoryName :String = categoryCell.categoryNameLabel.text as String!

        var selectedCategories:[Category] = []

        selectedCategories.append(selectedCategory)

        gameQuestions  = cdHelper.getQuestionsOfCategories(selectedCategories) as [Question]

        self.performSegueWithIdentifier("practiceToNewGame", sender: "newGame")

        //println("selectedCategory = \(selectedCategoryName)")

        categoriesTableView.reloadData()

    }

    @IBAction func backButtonAction(sender:UIButton) {
        println("Button Action From Code")
        var pauseScreen: NGPause = self.storyboard!.instantiateViewControllerWithIdentifier("PausedGameViewController") as NGPause
        pauseScreen.delegate = self
        self.title = "newPractice"
        self.presentViewController(pauseScreen, animated: true, completion: nil)
    }


    func loadCategories(){

        loadedArrayOfCategories.removeAll(keepCapacity: false)

        if let loadCategoryResult  = cdHelper?.loadData("category") {
            loadedArrayOfCategories  = loadCategoryResult.data as [Category]
            
        }
    }



    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if(sender? as String == "newGame"){

            let newGameViewController = (segue.destinationViewController as NewGameViewController)
            var newGame = newGameViewController.initTrivQuiz()
            newGame.questions = gameQuestions
            newGame.gameType = "practice"
        }
    }



    

}


   