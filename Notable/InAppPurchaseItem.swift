//
//  InAppPurchase.swift
//  Notable
//
//  Created by abdullah cengiz on 22/12/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation

class InAppPurchaseItem {

    var inAppPurchaseItemId:Int!
    var inAppPurchaseItemPrice:Float!
    var inAppPurchaseItemName:String
    var inAppPurchaseStoreIdentifier: String!

    init(inAppPurchaseItemId: Int, inAppPurchaseItemName: String, inAppPurchaseItemPrice: Float, inAppPurchaseStoreIdentifier:String){

        self.inAppPurchaseItemId = inAppPurchaseItemId
        self.inAppPurchaseItemName = inAppPurchaseItemName
        self.inAppPurchaseItemPrice = inAppPurchaseItemPrice
        self.inAppPurchaseStoreIdentifier = inAppPurchaseStoreIdentifier
        
    }
}
