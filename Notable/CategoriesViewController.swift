//
//  CategoriesViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 24/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource  {
    @IBOutlet var navItem: UINavigationItem!

    var arrayOfCategories: [Category] = [Category]()
    var loadedArrayOfCategories: [Category] = [Category]()

    var checkBoxButton:UIButton  = UIButton.buttonWithType(UIButtonType.System) as UIButton

    // for initial status of checkAll button
    var isAllOfCategoriesChecked: Bool = true

    var cdHelper: CoreDataHelper?

    //for backButton
    var backButton:UIButton!

    //for screen dimensions
    var width = NSUserDefaults.standardUserDefaults().objectForKey("width") as CGFloat
    var height = NSUserDefaults.standardUserDefaults().objectForKey("height") as CGFloat

    @IBOutlet var categoriesTableView: UITableView!

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
        self.categoriesTableView.backgroundColor = bg

        var selectedTheme: Int = NSUserDefaults.standardUserDefaults().objectForKey("selectedTheme") as Int

        var image:UIImage?
        //for back button
        if(selectedTheme == 0){

            image = UIImage(named: "backbutton_light") as UIImage?

        }
        else{

            image = UIImage(named: "backbutton_dark") as UIImage?

        }

        backButton.setBackgroundImage(image, forState: UIControlState.Normal)

        categoriesTableView.reloadData()
    }

    func prepareNavigationBar(){

        var selectedTheme: Int = NSUserDefaults.standardUserDefaults().objectForKey("selectedTheme") as Int

        var image:UIImage?
        //for back button
        if(selectedTheme == 0){

            image = UIImage(named: "backbutton_light") as UIImage?

        }
        else{

            image = UIImage(named: "backbutton_dark") as UIImage?

        }


        //for back button
        backButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        backButton.frame  = CGRectMake(0, 0, 25, 25)
        backButton.setBackgroundImage(image, forState: UIControlState.Normal)
        backButton.setTitle("", forState: UIControlState.Normal);
        backButton.addTarget(self, action:"backButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        navItem.setLeftBarButtonItem(UIBarButtonItem(customView: backButton), animated: true)
        navItem.hidesBackButton=true


        //for settings button
        var checkBoxImage:UIImage?
        //for back button
        if(selectedTheme == 0){

            checkBoxImage = UIImage(named: "checkbox_unchecked_light") as UIImage?

        }
        else{

            checkBoxImage = UIImage(named: "checkbox_unchecked_dark") as UIImage?

        }

        checkBoxButton.frame  = CGRectMake(0, 0, 30, 30)
        checkBoxButton.setBackgroundImage(checkBoxImage, forState: UIControlState.Normal)
        checkBoxButton.setTitle("", forState: UIControlState.Normal);
        checkBoxButton.tag=0 // if tag=0 button is unticked

        // if all of categories are ticked
        if(isAllOfCategoriesChecked){

            var selectedTheme: Int = NSUserDefaults.standardUserDefaults().objectForKey("selectedTheme") as Int

            var image:UIImage?
            //for back button
            if(selectedTheme == 0){

                image = UIImage(named: "checkbox_checked_light") as UIImage?

            }
            else{

                image = UIImage(named: "checkbox_checked_dark") as UIImage?

            }

            checkBoxButton.setBackgroundImage(image, forState: UIControlState.Normal)
            checkBoxButton.tag=1 // if tag=1 button is ticked

        }

        checkBoxButton.addTarget(self, action:"checkAllButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        navItem.setRightBarButtonItem(UIBarButtonItem(customView: checkBoxButton), animated: true)
        navItem.hidesBackButton=true
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedArrayOfCategories.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let categoryCell :CategoryTableCell = self.categoriesTableView.dequeueReusableCellWithIdentifier("categoryCell") as CategoryTableCell

        let currentCategory = loadedArrayOfCategories[indexPath.row]

        if(currentCategory.status!){
            categoryCell.tickImage.hidden=false

        }else{
            categoryCell.tickImage.hidden = true
        }

        categoryCell.setCell(currentCategory.categoryName!)
        return categoryCell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        let categoryCell :CategoryTableCell = categoriesTableView.cellForRowAtIndexPath(indexPath) as CategoryTableCell

        var selectedCategory : Category = loadedArrayOfCategories[indexPath.row]

        if(selectedCategory.status!){
            selectedCategory.status = false

            dispatch_async(dispatch_get_main_queue()) {

                var selectedTheme: Int = NSUserDefaults.standardUserDefaults().objectForKey("selectedTheme") as Int

                var image:UIImage?
                //for back button
                if(selectedTheme == 0){

                    image = UIImage(named: "checkbox_unchecked_light") as UIImage?

                }
                else{

                    image = UIImage(named: "checkbox_unchecked_dark") as UIImage?

                }

                self.checkBoxButton.setBackgroundImage(image, forState: UIControlState.Normal)
            }

        }else{
            selectedCategory.status = true
        }

        var selectedCategoryName :String = categoryCell.categoryNameLabel.text as String!

        updateCategory(categoryId:selectedCategory.categoryId!, status:selectedCategory.status!)

        categoriesTableView.reloadData()
    }

    @IBAction func backButtonAction(sender:UIButton) {
        println("Button Action From Code")
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func  checkAllButtonAction(sender:UIButton) {

        if(sender.tag == 0){


            var selectedTheme: Int = NSUserDefaults.standardUserDefaults().objectForKey("selectedTheme") as Int

            var image:UIImage?

            //for back button
            if(selectedTheme == 0){

                image = UIImage(named: "checkbox_checked_light") as UIImage?

            }
            else{

                image = UIImage(named: "checkbox_checked_dark") as UIImage?

            }


            sender.setBackgroundImage(image, forState: UIControlState.Normal)
            sender.tag = 1

            // tick all categories
            for category in loadedArrayOfCategories {

                category.status=true

                updateCategory(categoryId: category.categoryId!, status: category.status!)
            }
        } else {

            var selectedTheme: Int = NSUserDefaults.standardUserDefaults().objectForKey("selectedTheme") as Int

            var image:UIImage?
            //for back button
            if(selectedTheme == 0){

                image = UIImage(named: "checkbox_unchecked_light") as UIImage?

            }
            else{

                image = UIImage(named: "checkbox_unchecked_dark") as UIImage?

            }

            sender.setBackgroundImage(image, forState: UIControlState.Normal)
            sender.tag = 0

            // untick all categories
            for category in loadedArrayOfCategories {

                category.status=false

                updateCategory(categoryId: category.categoryId!, status: category.status!)
            }
        }
        // reload categories tableview
        categoriesTableView.reloadData()
    }

    func updateCategory(#categoryId: Int , status: Bool){

        println("categoryId: \(categoryId)  status: \(status)")
        
        cdHelper?.updateCategory(categoryId: categoryId, status: status)
        
        loadCategories()
    }
    
    
    func loadCategories(){
        
        loadedArrayOfCategories.removeAll(keepCapacity: false)
        
        if let loadCategoryResult  = cdHelper?.loadData("category") {
            loadedArrayOfCategories  = loadCategoryResult.data as [Category]
            isAllOfCategoriesChecked  = loadCategoryResult.checkStatus as Bool
            println("isAllCategoriesChecked: \(isAllOfCategoriesChecked)")
        }
    }
}