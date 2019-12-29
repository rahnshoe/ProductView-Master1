//
//  Product.swift
//  NSTableView1
//
//  Created by Chris Rahn on 2/13/2019.
//  Copyright © 2018 Chris Rahn All rights reserved.
//

import Cocoa
import RealmSwift

class Product: Object, Codable {
    @objc dynamic var sku: String = ""
    @objc dynamic var upc: Int = 0
    @objc dynamic var itemDescription: String = ""
    @objc dynamic var brand: String = ""
    @objc dynamic var originalQty: Int = 0
    @objc dynamic var inventoryCount: Int = 0
    @objc dynamic var msrp: String = ""
    @objc dynamic var color: String = ""
    @objc dynamic var size: String = ""
    @objc dynamic var sizeType: String = ""
    @objc dynamic var vendorName: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var code: String = ""
    @objc dynamic var imageSlot1: String = ""
    @objc dynamic var imageSlot2: String = ""
    @objc dynamic var imageSlot3: String = ""
    @objc dynamic var imageSlot4: String = ""
    @objc dynamic var price: String = ""
    @objc dynamic var shipping: Int = 0
    @objc dynamic var style: String = ""
    @objc dynamic var sleeveStyle: String = ""
    @objc dynamic var sleeveLength: String = ""
    @objc dynamic var ebayCategory: String = ""
    @objc dynamic var storeCategory: String = ""
    @objc dynamic var eBayConditionID: Int = 0
    
    
    override static func primaryKey() -> String? {
        return "upc"
    }
    }



