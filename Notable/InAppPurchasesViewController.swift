//
//  InAppPurchasesViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 20/12/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import UIKit
import SpriteKit

class InAppPurchaseViewController: UIViewController,SKProductsRequestDelegate,SKPaymentTransactionObserver,UITableViewDelegate,UITableViewDataSource {

    var selectedInAppPurchase:InAppPurchaseItem?
    var selectedInAppItemIdentifier:String?

    @IBOutlet var navItem: UINavigationItem!
    var arrayOfInAppPurchases: [InAppPurchaseItem] = [InAppPurchaseItem]()

    var selectedInAppPurchaseId = -1

    var backButton:UIButton!

    @IBOutlet var inAppPurchaseTableView: UITableView!

    var delegate:AnyObject?
    var navBar:UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar = self.navigationController?.navigationBar
        // Do any additional setup after loading the view.

        self.inAppPurchaseTableView.delegate = self
        self.inAppPurchaseTableView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false


        inAppPurchaseTableView.separatorColor = UIColor.blackColor()
        initUI()

        prepareInAppPurchases()

    }

    func initUI() {

        inAppPurchaseTableView.layer.cornerRadius = 4.0

    }

    func prepareInAppPurchases(){

        arrayOfInAppPurchases.removeAll(keepCapacity: false)

        var removeAd: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("removeAd")
        var lesson4: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("lesson4")


        var inAppPurchaseItem1:InAppPurchaseItem = InAppPurchaseItem(inAppPurchaseItemId: 0, inAppPurchaseItemName: "Remove Advertisements", inAppPurchaseItemPrice: 7.00, inAppPurchaseStoreIdentifier:"com.trivato.notable.removeads")

        var inAppPurchaseItem2:InAppPurchaseItem = InAppPurchaseItem(inAppPurchaseItemId: 1, inAppPurchaseItemName: "Lesson: Basic Music Symbols", inAppPurchaseItemPrice: 7.00, inAppPurchaseStoreIdentifier:"com.trivato.notable.lesson4")

        if(removeAd as Int == 0){

            arrayOfInAppPurchases.append(inAppPurchaseItem1)

        }

        if(lesson4 as Int == 0){

            arrayOfInAppPurchases.append(inAppPurchaseItem2)

        }

        inAppPurchaseTableView.reloadData()

        HUDController.sharedController.hideAnimated()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        prepareNavigationBar()
        styleView()
    }

    func styleView() {
        var bg:UIColor = UIColor.whiteColor()
        var btn:UIColor = UIColor.whiteColor()
        var txt:UIColor = UIColor.blackColor()
        Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)

        self.view.backgroundColor = bg

        //change navigation bar color
        self.navigationController!.navigationBar.barTintColor = btn

        //change navigation item title color
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: txt]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict

        //for settings button
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

    }

    func prepareNavigationBar(){

        //for settings button
        var selectedTheme: Int = NSUserDefaults.standardUserDefaults().objectForKey("selectedTheme") as Int

        var image:UIImage?
        //for back button
        if(selectedTheme == 0){

            image = UIImage(named: "backbutton_light") as UIImage?

        }
        else{

            image = UIImage(named: "backbutton_dark") as UIImage?
            
        }


        //for backButton
        backButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        backButton.frame  = CGRectMake(0, 0, 25, 25)
        backButton.setBackgroundImage(image, forState: UIControlState.Normal)
        backButton.setTitle("", forState: UIControlState.Normal);
        backButton.addTarget(self, action:"backButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        navItem.setLeftBarButtonItem(UIBarButtonItem(customView: backButton), animated: true)
        navItem.hidesBackButton=true



    }



    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfInAppPurchases.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let inAppPurchaseCell :InAppPurchaseTableCell = self.inAppPurchaseTableView.dequeueReusableCellWithIdentifier("inAppPurchaseCell") as InAppPurchaseTableCell

        let currentInAppPurchase = arrayOfInAppPurchases[indexPath.row]

        inAppPurchaseCell.setCell(innAppPurchaseName: currentInAppPurchase.inAppPurchaseItemName, innAppPurchasePrice: "\(currentInAppPurchase.inAppPurchaseItemPrice) SEK")

        return inAppPurchaseCell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        let inAppPurchaseTableCell :InAppPurchaseTableCell = inAppPurchaseTableView.cellForRowAtIndexPath(indexPath) as InAppPurchaseTableCell

        selectedInAppPurchase = arrayOfInAppPurchases[indexPath.row]

        //create progress
        HUDController.sharedController.contentView = HUDContentView.ProgressView()
        HUDController.sharedController.show()


        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            // do some task
            dispatch_async(dispatch_get_main_queue()) {
                self.buyConsumable(inAppPurchaseItem: self.selectedInAppPurchase!)
                self.selectedInAppItemIdentifier = self.selectedInAppPurchase!.inAppPurchaseStoreIdentifier
                self.selectedInAppPurchaseId = self.selectedInAppPurchase!.inAppPurchaseItemId

                }
            }

    }

    func buyConsumable(#inAppPurchaseItem:InAppPurchaseItem){
        println("About to fetch the products");
        // We check that we are allow to make the purchase.
        if (SKPaymentQueue.canMakePayments())
        {
            var productID:NSSet = NSSet(object: inAppPurchaseItem.inAppPurchaseStoreIdentifier);
            var productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID);
            productsRequest.delegate = self;
            productsRequest.start();
            println("Fething Products");
        }else{
            println("can't make purchases");
            decideShoppingStatus(false)
        }
    }


    @IBAction func backButtonAction(sender:UIButton) {
        println("Button Action From Code")
        self.navigationController?.popViewControllerAnimated(true)
    }

    // Helper Methods

    func buyProduct(product: SKProduct){
        println("Sending the Payment Request to Apple");
        var payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addPayment(payment);
    }


    // Delegate Methods for IAP

    func productsRequest (request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        println("got the request from Apple")
        var count : Int = response.products.count

        println("count = \(count)")

        if (count>0) {
            var validProducts = response.products
            var validProduct: SKProduct = response.products[0] as SKProduct
            if (validProduct.productIdentifier == selectedInAppItemIdentifier) {
                println("count>0")
                println(validProduct.localizedTitle)
                println(validProduct.localizedDescription)
                println(validProduct.price)
                buyProduct(validProduct)

            } else {
                println("count>0 else" )
                println(validProduct.productIdentifier)
            }
        } else {
            println("nothing")
        }
    }


    func request(request: SKRequest!, didFailWithError error: NSError!) {
        decideShoppingStatus(false)
        println("La vaina fallo");
    }

    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!)    {
        println("Received Payment Transaction Response from Apple");

        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{


                println("state: \(trans.transactionState) !!!!!!!!!!!!!!")


                switch trans.transactionState {
                case .Purchased:
                    println("Product Purchased");
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as SKPaymentTransaction)

                    decideShoppingStatus(true)
                    //removeReklam()
                    break;
                case .Failed:
                    println("Purchased Failed");
                    decideShoppingStatus(false)
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as SKPaymentTransaction)

                    break;
                case .Failed:
                    println("Purchased Failed");
                    decideShoppingStatus(false)
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as SKPaymentTransaction)

                    break;
                    // case .Restored:
                    //[self restoreTransaction:transaction];
                default:
                    println("in default !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    decideShoppingStatus(false)
                    break;
                }
            }
        }
        
    }


    func decideShoppingStatus(status:Bool){

        if(!status){
            if(selectedInAppPurchaseId == 0){

                NSUserDefaults.standardUserDefaults().setObject(0, forKey: "removeAd")
                NSUserDefaults.standardUserDefaults().synchronize()

            }
            else{

                NSUserDefaults.standardUserDefaults().setObject(0, forKey: "lesson4")
                NSUserDefaults.standardUserDefaults().synchronize()
                
            }

        }
        else{

            if(selectedInAppPurchaseId == 0){

                NSUserDefaults.standardUserDefaults().setObject(1, forKey: "removeAd")
                NSUserDefaults.standardUserDefaults().synchronize()

            }
            else{

                NSUserDefaults.standardUserDefaults().setObject(1, forKey: "lesson4")
                NSUserDefaults.standardUserDefaults().synchronize()

            }

        }

        prepareInAppPurchases()


    }



}