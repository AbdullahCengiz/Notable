//
//  LessonsViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 24/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit

import UIKit

//frida samuelsson

class LessonsViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource {

    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var lessonsTableView: UITableView!


    var loadedArrayOfLessons: [Lesson] = [Lesson]()
    var cdHelper : CoreDataHelper!
    var lessonQuestions:[LessonQuestion]!


    var delegate:AnyObject?
    var navBar:UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar = self.navigationController?.navigationBar
        // Do any additional setup after loading the view.

        self.lessonsTableView.delegate = self
        self.lessonsTableView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false

        lessonsTableView.layer.cornerRadius = 4.0
        lessonsTableView.separatorColor = UIColor.blackColor()

        cdHelper = CoreDataHelper()

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
        loadCategories()
    }

    func styleView() {
        var bg:UIColor = UIColor.whiteColor()
        var btn:UIColor = UIColor.whiteColor()
        var txt:UIColor = UIColor.blackColor()
        Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)

        self.view.backgroundColor = bg

    }

    func prepareNavigationBar(){

        let image       = UIImage(named: "backbutton") as UIImage?
        let uiButton    = UIButton.buttonWithType(UIButtonType.System) as UIButton
        uiButton.frame  = CGRectMake(0, 0, 25, 25)
        uiButton.setBackgroundImage(image, forState: UIControlState.Normal)
        uiButton.setTitle("", forState: UIControlState.Normal);
        uiButton.addTarget(self, action:"backButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        navItem.setLeftBarButtonItem(UIBarButtonItem(customView: uiButton), animated: true)
        navItem.hidesBackButton=true

    }



    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedArrayOfLessons.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let lessonCell :LessonTableCell = self.lessonsTableView.dequeueReusableCellWithIdentifier("lessonCell") as LessonTableCell

        let currentLesson = loadedArrayOfLessons[indexPath.row]
        
        lessonCell.setCell(lessonNameLabel:currentLesson.lessonName!,lessonHint:currentLesson.lessonHint!)

        return lessonCell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        let lessonCell :LessonTableCell = lessonsTableView.cellForRowAtIndexPath(indexPath) as LessonTableCell

        if(indexPath.row != loadedArrayOfLessons.count-1){



            var selectedLesson : Lesson = loadedArrayOfLessons[indexPath.row]

            var selectedLessonName :String = lessonCell.lessonNameLabel.text as String!

            var selectedLessons:[Lesson] = []

            selectedLessons.append(selectedLesson)

            lessonQuestions  = cdHelper.getQuestionsOfLesson(lessonId: selectedLesson.lessonId!) as [LessonQuestion]

            println("number of questions of lesson : \(lessonQuestions.count) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")

            self.performSegueWithIdentifier("goToLessonDetail", sender: "lesson")
            
            //lessonsTableView.reloadData()
            
        }
        else {

             //go to store
             self.performSegueWithIdentifier("goToInAppPurchase", sender: "store")

        }
        
        
    }

    @IBAction func backButtonAction(sender:UIButton) {

        self.navigationController?.popViewControllerAnimated(true)

    }


    func loadCategories(){

        loadedArrayOfLessons.removeAll(keepCapacity: false)

        if let loadLessonResult  = cdHelper?.loadData("lesson") {
            loadedArrayOfLessons  = loadLessonResult.data as [Lesson]

            //create lesson variable for store page selection line
            var lesson5 = Lesson(lessonId: 4, lessonName: "Click here to get more lessons!", lessonHint: "Check it out")
            loadedArrayOfLessons.append(lesson5)

        }
    }



    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if(sender? as String == "lesson"){
            var lessonDetailViewController = (segue.destinationViewController as LessonDetailViewController)
            var newLesson = lessonDetailViewController.initTrivLesson(lessonDetailViewController)

            var sortedDict = sorted(lessonQuestions){a,b in return a.questionId! < b.questionId!}

            for count in sortedDict {

                println(count.questionId!)
                
            }

            newLesson.questions = sortedDict
        }

    }

    
    
    
}


