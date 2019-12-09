//
//  MultiView.swift
//  ProductView
//
//  Created by chris rahn on 3/20/19.
//  Copyright © 2019 chris rahn. All rights reserved.
//

import Cocoa
import RealmSwift

var HRimageCode: Int?
var tempHRimageCode: Int?

class MultiView: NSViewController, ScaleData, ScaleStatus {
        
    var results: Results<Product>?
    var result: Results<Product>?
    var searchString: Int = 0
    var counter = 0
    var arrayOfURLs: [URL] = []
    var hdArrayOfURLs: [URL] = []
    
    var AltImgText1 = ""
    var AltImgText2 = ""
    var ovrUPC = ""
    var reviewModeState = "off"

    
    var scale = OhausScale()
  
    
    @IBOutlet weak var UPCSearchField: NSSearchField!
    @IBOutlet weak var UPCField: NSTextField!
    @IBOutlet weak var image15: NSButton!
    @IBOutlet weak var image14: NSButton!
    @IBOutlet weak var image13: NSButton!
    @IBOutlet weak var image12: NSButton!
    @IBOutlet weak var image11: NSButton!
    @IBOutlet weak var image10: NSButton!
    @IBOutlet weak var image9: NSButton!
    @IBOutlet weak var image8: NSButton!
    @IBOutlet weak var image7: NSButton!
    @IBOutlet weak var image6: NSButton!
    @IBOutlet weak var image5: NSButton!
    @IBOutlet weak var image4: NSButton!
    @IBOutlet weak var image3: NSButton!
    @IBOutlet weak var image2: NSButton!
    @IBOutlet weak var image1: NSButton!
    
    @IBOutlet weak var itemDescriptionField: NSTextField!
    @IBOutlet weak var colorField: NSTextField!
    
    
    
  
    
    @IBOutlet weak var ImgSelectPopUpbutton1: NSPopUpButton!
    @IBOutlet weak var ImgSelectPopUpbutton2: NSPopUpButton!
    @IBOutlet weak var ImgSelectPopUpbutton3: NSPopUpButton!
    @IBOutlet weak var ImgSelectPopUpbutton4: NSPopUpButton!
    @IBOutlet weak var ImgSelectPopUpbutton5: NSPopUpButton!
    @IBOutlet weak var ImgSelectPopUpbutton6: NSPopUpButton!
    @IBOutlet weak var ImgSelectPopUpbutton7: NSPopUpButton!
    @IBOutlet weak var ImgSelectPopUpbutton8: NSPopUpButton!
    @IBOutlet weak var ImgSelectPopUpbutton9: NSPopUpButton!
    @IBOutlet weak var ImgSelectPopUpbutton10: NSPopUpButton!
    @IBOutlet weak var ImgSelectPopUpbutton11: NSPopUpButton!
    @IBOutlet weak var ImgSelectPopUpbutton12: NSPopUpButton!
    @IBOutlet weak var ImgSelectPopUpbutton13: NSPopUpButton!
    @IBOutlet weak var ImgSelectPopUpbutton14: NSPopUpButton!
    @IBOutlet weak var ImgSelectPopUpbutton15: NSPopUpButton!
    
    @IBOutlet weak var sleeveLength: NSTextField!
    

    @IBOutlet weak var price: NSTextField!
    @IBOutlet weak var shipping: NSTextField!
    @IBOutlet weak var sku: NSTextField!
    @IBOutlet weak var brand: NSTextField!
    @IBOutlet weak var style: NSTextField!
    @IBOutlet weak var color: NSTextField!
    @IBOutlet weak var size: NSTextField!
    @IBOutlet weak var sleeveStyle: NSTextField!
    @IBOutlet weak var msrp: NSTextField!
    @IBOutlet weak var ebayCategory: NSTextField!
    @IBOutlet weak var storeCategory: NSTextField!
    @IBOutlet weak var eBayConditionID: NSTextField!
    @IBOutlet weak var sizeType: NSTextField!
    @IBOutlet weak var image: NSTextField!
    @IBOutlet weak var OriginalQty: NSTextField!
    @IBOutlet weak var inventoryCount: NSTextField!
    @IBOutlet weak var qtyReceived: NSTextField!
    
    
    
    @IBOutlet weak var imageOverride1TxtField: NSTextField!
    @IBOutlet weak var imageOverride2TxtField: NSTextField!
    
    @IBOutlet weak var emptyFlag: NSTextField!
    @IBOutlet weak var scaleStatus: NSTextField!
    @IBOutlet weak var weightDisplay: NSTextField!
    
    

    func displayWeight(weight: String) {
        print(weight)
        self.weightDisplay.stringValue = weight
    }

    func displayScaleStatus(status: String) {
       self.scaleStatus.stringValue = status
  }
   
    override func viewDidLoad() {
        setupPopUpButtons()
        //weightDisplay.stringValue = globalWeight
        scale.scaleDelegate = self
        scale.scaleStatusDelegate = self
        scale.scaleBegin()
        counter = 0
        
//        // Add an item to the list
//        myPopUpbutton.addItem(withTitle: "Pop up buttons rock")


       
        
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func reviewMode(_ sender: NSButtonCell) {
        if sender.state == .on{
        print("on")
            reviewModeState = "on"
            image1.image = nil
            image2.image = nil
            image3.image = nil
            image4.image = nil
            image5.image = nil
            image6.image = nil
            image7.image = nil
            image8.image = nil
            image9.image = nil
            image10.image = nil
            image11.image = nil
            image12.image = nil
            image13.image = nil
            image14.image = nil
            image15.image = nil
        }else{
            print("off")
            reviewModeState = "off"
            
        }
    }
    

    
    func setupPopUpButtons (){
        
        // Remove all items from the list
        ImgSelectPopUpbutton1.removeAllItems()
        ImgSelectPopUpbutton1.removeAllItems()
        ImgSelectPopUpbutton2.removeAllItems()
        ImgSelectPopUpbutton3.removeAllItems()
        ImgSelectPopUpbutton4.removeAllItems()
        ImgSelectPopUpbutton5.removeAllItems()
        ImgSelectPopUpbutton6.removeAllItems()
        ImgSelectPopUpbutton7.removeAllItems()
        ImgSelectPopUpbutton8.removeAllItems()
        ImgSelectPopUpbutton9.removeAllItems()
        ImgSelectPopUpbutton10.removeAllItems()
        ImgSelectPopUpbutton11.removeAllItems()
        ImgSelectPopUpbutton12.removeAllItems()
        ImgSelectPopUpbutton13.removeAllItems()
        ImgSelectPopUpbutton14.removeAllItems()
        ImgSelectPopUpbutton15.removeAllItems()
        
        // Add an array of items to the list
        ImgSelectPopUpbutton1.addItems(withTitles: ["", "Image 1", "Image 2", "Image 3", "Image 4"])
        ImgSelectPopUpbutton2.addItems(withTitles: ["", "Image 1", "Image 2", "Image 3", "Image 4"])
        ImgSelectPopUpbutton3.addItems(withTitles: ["", "Image 1", "Image 2", "Image 3", "Image 4"])
        ImgSelectPopUpbutton4.addItems(withTitles: ["", "Image 1", "Image 2", "Image 3", "Image 4"])
        ImgSelectPopUpbutton5.addItems(withTitles: ["", "Image 1", "Image 2", "Image 3", "Image 4"])
        ImgSelectPopUpbutton6.addItems(withTitles: ["", "Image 1", "Image 2", "Image 3", "Image 4"])
        ImgSelectPopUpbutton7.addItems(withTitles: ["", "Image 1", "Image 2", "Image 3", "Image 4"])
        ImgSelectPopUpbutton8.addItems(withTitles: ["", "Image 1", "Image 2", "Image 3", "Image 4"])
        ImgSelectPopUpbutton9.addItems(withTitles: ["", "Image 1", "Image 2", "Image 3", "Image 4"])
        ImgSelectPopUpbutton10.addItems(withTitles: ["", "Image 1", "Image 2", "Image 3", "Image 4"])
        ImgSelectPopUpbutton11.addItems(withTitles: ["", "Image 1", "Image 2", "Image 3", "Image 4"])
        ImgSelectPopUpbutton12.addItems(withTitles: ["", "Image 1", "Image 2", "Image 3", "Image 4"])
        ImgSelectPopUpbutton13.addItems(withTitles: ["", "Image 1", "Image 2", "Image 3", "Image 4"])
        ImgSelectPopUpbutton14.addItems(withTitles: ["", "Image 1", "Image 2", "Image 3", "Image 4"])
        ImgSelectPopUpbutton15.addItems(withTitles: ["", "Image 1", "Image 2", "Image 3", "Image 4"])
        

        // Select an item at a specific index
        ImgSelectPopUpbutton1.selectItem(at: 0)
        ImgSelectPopUpbutton2.selectItem(at: 0)
        ImgSelectPopUpbutton3.selectItem(at: 0)
        ImgSelectPopUpbutton4.selectItem(at: 0)
        ImgSelectPopUpbutton5.selectItem(at: 0)
        ImgSelectPopUpbutton6.selectItem(at: 0)
        ImgSelectPopUpbutton7.selectItem(at: 0)
        ImgSelectPopUpbutton8.selectItem(at: 0)
        ImgSelectPopUpbutton9.selectItem(at: 0)
        ImgSelectPopUpbutton10.selectItem(at: 0)
        ImgSelectPopUpbutton11.selectItem(at: 0)
        ImgSelectPopUpbutton12.selectItem(at: 0)
        ImgSelectPopUpbutton13.selectItem(at: 0)
        ImgSelectPopUpbutton14.selectItem(at: 0)
        ImgSelectPopUpbutton15.selectItem(at: 0)
    }
    
    func storeImageInSlot1(arrayNum: Int) {
        print(String(describing: hdArrayOfURLs[arrayNum]))
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            let path0 =  String(describing: hdArrayOfURLs[arrayNum])
            let searchfieldChangeValue = UPCSearchField.stringValue
            let upcValue = Int(searchfieldChangeValue)
            realm.create(Product.self, value: ["upc": upcValue!, "imageSlot1": path0], update: .modified)
        }
    }
    
    func storeImageInSlot2(arrayNum: Int) {
        print(String(describing: hdArrayOfURLs[arrayNum]))
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            let path0 =  String(describing: hdArrayOfURLs[arrayNum])
            let searchfieldChangeValue = UPCSearchField.stringValue
            let upcValue = Int(searchfieldChangeValue)
            realm.create(Product.self, value: ["upc": upcValue!, "imageSlot2": path0], update: .modified)
        }
    }
    
    func storeImageInSlot3(arrayNum: Int) {
        print(String(describing: hdArrayOfURLs[arrayNum]))
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            let path0 =  String(describing: hdArrayOfURLs[arrayNum])
            let searchfieldChangeValue = UPCSearchField.stringValue
            let upcValue = Int(searchfieldChangeValue)
            realm.create(Product.self, value: ["upc": upcValue!, "imageSlot3": path0], update: .modified)
        }
    }
    
    func storeImageInSlot4(arrayNum: Int) {
        print(String(describing: hdArrayOfURLs[arrayNum]))
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            let path0 =  String(describing: hdArrayOfURLs[arrayNum])
            let searchfieldChangeValue = UPCSearchField.stringValue
            let upcValue = Int(searchfieldChangeValue)
            realm.create(Product.self, value: ["upc": upcValue!, "imageSlot4": path0], update: .modified)
        }
    }




    
    
    @IBAction func saveImages(_ sender: NSButton) {
       
        
        // Get the index of the currently selected item
        let selectedIndex1 = ImgSelectPopUpbutton1.indexOfSelectedItem
        let selectedIndex2 = ImgSelectPopUpbutton2.indexOfSelectedItem
        let selectedIndex3 = ImgSelectPopUpbutton3.indexOfSelectedItem
        let selectedIndex4 = ImgSelectPopUpbutton4.indexOfSelectedItem
        let selectedIndex5 = ImgSelectPopUpbutton5.indexOfSelectedItem
        let selectedIndex6 = ImgSelectPopUpbutton6.indexOfSelectedItem
        let selectedIndex7 = ImgSelectPopUpbutton7.indexOfSelectedItem
        let selectedIndex8 = ImgSelectPopUpbutton8.indexOfSelectedItem
        let selectedIndex9 = ImgSelectPopUpbutton9.indexOfSelectedItem
        let selectedIndex10 = ImgSelectPopUpbutton10.indexOfSelectedItem
        let selectedIndex11 = ImgSelectPopUpbutton11.indexOfSelectedItem
        let selectedIndex12 = ImgSelectPopUpbutton12.indexOfSelectedItem
        let selectedIndex13 = ImgSelectPopUpbutton13.indexOfSelectedItem
        let selectedIndex14 = ImgSelectPopUpbutton14.indexOfSelectedItem
        let selectedIndex15 = ImgSelectPopUpbutton15.indexOfSelectedItem
        

        switch selectedIndex1 {
        case 1:
            storeImageInSlot1(arrayNum: 0)
        case 2:
            storeImageInSlot2(arrayNum: 0)
        case 3:
            storeImageInSlot3(arrayNum: 0)
        case 4:
            storeImageInSlot4(arrayNum: 0)
        default:
            print("nope")
        }
        switch selectedIndex2 {
        case 1:
            storeImageInSlot1(arrayNum: 1)
        case 2:
            storeImageInSlot2(arrayNum: 1)
        case 3:
            storeImageInSlot3(arrayNum: 1)
        case 4:
            storeImageInSlot4(arrayNum: 1)
        default:
            print("nope")

        }
        switch selectedIndex3 {
        case 1:
            storeImageInSlot1(arrayNum: 2)
        case 2:
            storeImageInSlot2(arrayNum: 2)
        case 3:
            storeImageInSlot3(arrayNum: 2)
        case 4:
            storeImageInSlot4(arrayNum: 2)
        default:
           print("nope")

        }
        switch selectedIndex4 {
        case 1:
            storeImageInSlot1(arrayNum: 3)
        case 2:
            storeImageInSlot2(arrayNum: 3)
        case 3:
            storeImageInSlot3(arrayNum: 3)
        case 4:
            storeImageInSlot4(arrayNum: 3)
        default:
             print("nope")

        }
        
        switch selectedIndex5 {
        case 1:
            storeImageInSlot1(arrayNum: 4)
        case 2:
            storeImageInSlot2(arrayNum: 4)
        case 3:
            storeImageInSlot3(arrayNum: 4)
        case 4:
            storeImageInSlot4(arrayNum: 4)
        default:
            print("nope")

        }
        
        switch selectedIndex6 {
        case 1:
            storeImageInSlot1(arrayNum: 5)
        case 2:
            storeImageInSlot2(arrayNum: 5)
        case 3:
            storeImageInSlot3(arrayNum: 5)
        case 4:
            storeImageInSlot4(arrayNum: 5)
        default:
            print("nope")

        }
        
        switch selectedIndex7 {
        case 1:
            storeImageInSlot1(arrayNum: 6)
        case 2:
            storeImageInSlot2(arrayNum: 6)
        case 3:
            storeImageInSlot3(arrayNum: 6)
        case 4:
            storeImageInSlot4(arrayNum: 6)
        default:
            print("nope")

        }
        
        switch selectedIndex8 {
        case 1:
            storeImageInSlot1(arrayNum: 7)
        case 2:
            storeImageInSlot2(arrayNum: 7)
        case 3:
            storeImageInSlot3(arrayNum: 7)
        case 4:
            storeImageInSlot4(arrayNum: 7)
        default:
            print("nope")

        }
        
        switch selectedIndex9 {
        case 1:
            storeImageInSlot1(arrayNum: 8)
        case 2:
            storeImageInSlot2(arrayNum: 8)
        case 3:
            storeImageInSlot3(arrayNum: 8)
        case 4:
            storeImageInSlot4(arrayNum: 8)
        default:
            print("nope")

        }
        
        switch selectedIndex10 {
        case 1:
            storeImageInSlot1(arrayNum: 9)
        case 2:
            storeImageInSlot2(arrayNum: 9)
        case 3:
            storeImageInSlot3(arrayNum: 9)
        case 4:
            storeImageInSlot4(arrayNum: 9)
        default:
            print("nope")
        }
        
        switch selectedIndex11 {
        case 1:
            storeImageInSlot1(arrayNum: 10)
        case 2:
            storeImageInSlot2(arrayNum: 10)
        case 3:
            storeImageInSlot3(arrayNum: 10)
        case 4:
            storeImageInSlot4(arrayNum: 10)
        default:
            print("nope")

        }
        switch selectedIndex12 {
        case 1:
            storeImageInSlot1(arrayNum: 11)
        case 2:
            storeImageInSlot2(arrayNum: 11)
        case 3:
            storeImageInSlot3(arrayNum: 11)
        case 4:
            storeImageInSlot4(arrayNum: 11)
        default:
            print("nope")

        }
        switch selectedIndex13 {
        case 1:
            storeImageInSlot1(arrayNum: 12)
        case 2:
            storeImageInSlot2(arrayNum: 12)
        case 3:
            storeImageInSlot3(arrayNum: 12)
        case 4:
            storeImageInSlot4(arrayNum: 12)
        default:
            print("nope")

        }
        switch selectedIndex14 {
        case 1:
            storeImageInSlot1(arrayNum: 13)
        case 2:
            storeImageInSlot2(arrayNum: 13)
        case 3:
            storeImageInSlot3(arrayNum: 13)
        case 4:
            storeImageInSlot4(arrayNum: 13)
        default:
            print("nope")

        }
        switch selectedIndex15 {
        case 1:
            storeImageInSlot1(arrayNum: 14)
        case 2:
            storeImageInSlot2(arrayNum: 14)
        case 3:
            storeImageInSlot3(arrayNum: 14)
        case 4:
            storeImageInSlot4(arrayNum: 14)
        default:
            print("nope")

        }
    }
    
    
    @IBAction func SearchBar(_ sender: Any) {

         arrayOfURLs = []
        hdArrayOfURLs = []
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        results = realm.objects(Product.self)
    
        
        print(results?.count as Any)
        if results?.count != nil {
            searchString = UPCSearchField!.integerValue
            print("Search String")
            print(searchString)
            let predicate = NSPredicate(format: "upc == %@", NSNumber (value: searchString))
            result = results!.filter(predicate)
            print("result")
            print(result.self)
            
            
            if (result?.count)! > 0 {
                
                UPCField.textColor = NSColor.black
                itemDescriptionField.textColor = NSColor.black
                setupPopUpButtons()
                imageOverride1TxtField.stringValue = ""
                imageOverride2TxtField.stringValue = ""
                UPCField.stringValue = String(result![0].upc)
                OriginalQty.stringValue = String(result![0].originalQty)
                inventoryCount.stringValue = String(result![0].inventoryCount)
                itemDescriptionField.stringValue = result![0].itemDescription
                colorField.stringValue = String(result![0].color)
                price.stringValue = String(result![0].price)
                shipping.stringValue = String(result![0].shipping)
                sku.stringValue = String(result![0].sku)
                brand.stringValue = String(result![0].brand)
                style.stringValue = String(result![0].style)
                color.stringValue = String(result![0].color)
                size.stringValue = String(result![0].size)
                image.stringValue = String(result![0].image)
                msrp.stringValue = String(result![0].msrp)
                sleeveStyle.stringValue = String(result![0].sleeveStyle)
                sleeveLength.stringValue = String(result![0].sleeveLength)
                ebayCategory.stringValue = String(result![0].ebayCategory)
                storeCategory.stringValue = String(result![0].storeCategory)
                eBayConditionID.stringValue = String(result![0].eBayConditionID)
                sizeType.stringValue = String(result![0].sizeType)
                ovrUPC = String(result![0].upc)
                
                
                if result![0].imageSlot8.isEmpty {
                    print("Nothing to see here")
                    emptyFlag.stringValue = "Nothing to see here"
                } else {
                    emptyFlag.stringValue = ""
                }

                let string = itemDescriptionField.stringValue
                if let range3 = string.range(of: "shirt", options: .caseInsensitive) {
                    // match
                    print("match shirt")
                    style.stringValue = "shirt"
                    ebayCategory.stringValue = "53159"
                    storeCategory.stringValue = "29010495011"
                } else {
                
                if let range3 = string.range(of: "tank", options: .caseInsensitive) {
                    // match
                    print("match tank")
                    style.stringValue = "tank"
                    ebayCategory.stringValue = "53159"
                    storeCategory.stringValue = "29010495011"
                } else {
                if let range3 = string.range(of: "cami", options: .caseInsensitive) {
                        // match
                        print("match cami")
                        style.stringValue = "cami"
                        ebayCategory.stringValue = "53159"
                        storeCategory.stringValue = "29010495011"
                    } else {
                if let range3 = string.range(of: "top", options: .caseInsensitive) {
                        // match
                        print("match top")
                        style.stringValue = "top"
                        ebayCategory.stringValue = "53159"
                        storeCategory.stringValue = "29010495011"
                    } else {
                if let range3 = string.range(of: "blouse", options: .caseInsensitive) {
                        // match
                        print("match blouse")
                        style.stringValue = "blouse"
                        ebayCategory.stringValue = "53159"
                        storeCategory.stringValue = "29010495011"
                    } else {
                if let range3 = string.range(of: "sweater", options: .caseInsensitive) {
                        // match
                        print("match sweater")
                        style.stringValue = "sweater"
                        ebayCategory.stringValue = "63866"
                        storeCategory.stringValue = "29010495011"
                    } else {
                if let range3 = string.range(of: "skirt", options: .caseInsensitive) {
                        // match
                        print("match skirt")
                        style.stringValue = "skirt"
                        ebayCategory.stringValue = "63864"
                        storeCategory.stringValue = "33096451011"
                    } else {
                if let range3 = string.range(of: "shorts", options: .caseInsensitive) {
                        // match
                        print("match shorts")
                        style.stringValue = "shorts"
                        ebayCategory.stringValue = "11555"
                        storeCategory.stringValue = "31775416011"
                    } else {
                if let range3 = string.range(of: "pants", options: .caseInsensitive) {
                        // match
                        print("match pants")
                        style.stringValue = "pants"
                        ebayCategory.stringValue = "63863"
                        storeCategory.stringValue = "31775381011"
                    } else {
                if let range3 = string.range(of: "jumpsuit", options: .caseInsensitive) {
                        // match
                        print("match jumpsuit")
                        style.stringValue = "jumpsuit"
                        ebayCategory.stringValue = "3009"
                        storeCategory.stringValue = "1"
                    } else {
               if let range3 = string.range(of: "romper", options: .caseInsensitive) {
                        // match
                        print("match romper")
                        style.stringValue = "romper"
                        ebayCategory.stringValue = "3009"
                        storeCategory.stringValue = "1"
                    } else {
                if let range3 = string.range(of: "jeans", options: .caseInsensitive) {
                    // match
                    print("match jeans")
                    style.stringValue = "jeans"
                    ebayCategory.stringValue = "11554"
                    storeCategory.stringValue = "31775381011"
                } else {
                if let range3 = string.range(of: "sleepwear", options: .caseInsensitive) {
                        // match
                        print("match sleepwear")
                        style.stringValue = "sleepwear"
                        ebayCategory.stringValue = "63855"
                        storeCategory.stringValue = "1"
                    } else {
                if let range3 = string.range(of: "dress", options: .caseInsensitive) {
                        // match
                        print("match dress")
                        style.stringValue = "dress"
                        ebayCategory.stringValue = "63861"
                        storeCategory.stringValue = "28973014011"
                    } else {
                if let range3 = string.range(of: "coat", options: .caseInsensitive) {
                        // match
                        print("match coat")
                        style.stringValue = "coat"
                        ebayCategory.stringValue = "63862"
                        storeCategory.stringValue = "1"
                    } else {
                if let range3 = string.range(of: "jacket", options: .caseInsensitive) {
                        // match
                        print("match jacket")
                        style.stringValue = "jacket"
                        ebayCategory.stringValue = "63862"
                        storeCategory.stringValue = "1"
                    } else {
                if let range3 = string.range(of: "vest", options: .caseInsensitive) {
                        // match
                        print("match vest")
                        style.stringValue = "vest"
                        ebayCategory.stringValue = "63862"
                        storeCategory.stringValue = "1"
                    } else {
                if let range3 = string.range(of: "hoodie", options: .caseInsensitive) {
                        // match
                        print("match hoodie")
                        style.stringValue = "hoodie"
                        ebayCategory.stringValue = "155226"
                        storeCategory.stringValue = "1"
                    } else {
                if let range3 = string.range(of: "sweatshirt", options: .caseInsensitive) {
                        // match
                        print("match sweatshirt")
                        style.stringValue = "sweatshirt"
                        ebayCategory.stringValue = "155226"
                        storeCategory.stringValue = "1"
                    } else {
                if let range3 = string.range(of: "bodysuit", options: .caseInsensitive) {
                        // match
                        print("match bodysuit")
                        style.stringValue = "bodysuit"
                        ebayCategory.stringValue = "53159"
                        storeCategory.stringValue = "29010495011"
                    } else {
                    // no match
                    print("no match")
                
                    }
                    }
                    }
                    }
                    }
                    }
                    }
                    }
                    }
                    }
                    }
                    }
                    }
                    }
                    }
                    }
                    }
                    }
                    }
                    }
          
                let url = URL(string: result![0].image)
                print(result![0].image)
                
                let image0 = result![0].image
                print("image is \(image0)")
                let hiRezImgURLbegin = "https://slimages.macysassets.com/is/image/MCY/products/1/optimized/"
                let hiRezImgURLEnd = "_fpx.tif?op_sharpen=1&wid=1230&hei=1500&fit=fit,1&$filterxlrg$"
                let lowImgURLbegin = "https://slimages.macys.com/is/image/MCY/"
                let lowImgURLEnd = ""
                // print(lowImgURLEnd)
                
                let start = image0.index(image0.startIndex, offsetBy: 39)
                let end = image0.index(image0.endIndex, offsetBy: 0)
                let range = start..<end
                let imageCode = Int(image0[range])!-7
                HRimageCode = imageCode
                print("image code is \(imageCode)")
                
                //iterate and set image display
                let images = [image1, image2, image3, image4,image5, image6, image7, image8, image9, image10, image11, image12, image13, image14, image15]
                var incrementer = 0
                
                if reviewModeState == "off" {
                    repeat {
                        for i in images {
                            let url1 = URL(string: "\(lowImgURLbegin)\(imageCode + incrementer )\(lowImgURLEnd)")
                            let hdurl1 = URL(string: "\(hiRezImgURLbegin)\(imageCode + incrementer )\(hiRezImgURLEnd)")
                            // print(url1)
                            arrayOfURLs.append(url1!)
                            hdArrayOfURLs.append(hdurl1!)
                            //print(hdArrayOfURLs)
                            do {
                                let data = try Data(contentsOf: url1!)
                                //let hddata = try Data(contentsOf: hdurl1!)
                                i!.image = NSImage(data: data)
                                // i!.image = NSImage(data: hddata)
                                incrementer += 1
                            } catch {
                                print("error!")
                            }
                        }
                    }while incrementer <= 7
                } else {
                    print("review mode on")
                    updateimages()
                }
                
            } else {
                
                
                print("error.localizedDescription")
                setupPopUpButtons()
                image1.image = nil
                image2.image = nil
                image3.image = nil
                image4.image = nil
                image5.image = nil
                image6.image = nil
                image7.image = nil
                image8.image = nil
                image9.image = nil
                image10.image = nil
                image11.image = nil
                image12.image = nil
                image13.image = nil
                image14.image = nil
                image15.image = nil
                UPCField.stringValue = "not found"
                msrp.stringValue = ""
                price.stringValue = ""
                shipping.stringValue = ""
                sku.stringValue = ""
                brand.stringValue = ""
                style.stringValue = ""
                color.stringValue = ""
                size.stringValue = ""
                sleeveStyle.stringValue = ""
                sleeveLength.stringValue = ""
                ebayCategory.stringValue = ""
                eBayConditionID.stringValue = ""
                sizeType.stringValue = ""
                storeCategory.stringValue = ""
                UPCField.textColor = NSColor.red
                itemDescriptionField.stringValue = "not found"
                itemDescriptionField.textColor = NSColor.red
                OriginalQty.stringValue = ""
                inventoryCount.stringValue = ""
                //prodImage.image = nil
                //image8.image = nil
                
            }
            
            
        } else {
           UPCField.stringValue = "No Realm File!"
        }

    }
    
    
    @IBAction func addToInventory(_ sender: NSButton) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
                   let realm = try! Realm(configuration: config)
                   try! realm.write {
        inventoryCount.stringValue = String(qtyReceived.intValue + inventoryCount.intValue)
        result![0].inventoryCount = inventoryCount.integerValue
        self.qtyReceived.stringValue = ""
    }
    }
    @IBAction func updateImages(_ sender: NSButton) {
        updateimages()
    }
    
    func updateimages(){
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        
        image1.image = nil
        image2.image = nil
        image3.image = nil
        image4.image = nil

        let url1 = URL(string: (result![0].imageSlot1))
        let url2 = URL(string: (result![0].imageSlot2))
        let url3 = URL(string: (result![0].imageSlot3))
        let url4 = URL(string: (result![0].imageSlot4))
        
        do {
            if url1 != nil {
            let data1 = try Data(contentsOf: url1!)
            image1.image = NSImage(data: data1)
            }else{
                image1.image = nil
                return
            }
            if url2 != nil {
            let data2 = try Data(contentsOf: url2!)
            image2.image = NSImage(data: data2)
            }else{
                image2.image = nil
                return
            }
            if url3 != nil {
            let data3 = try Data(contentsOf: url3!)
            image3.image = NSImage(data: data3)
            }else{
                image3.image = nil
                return
            }
            if url4 != nil {
            let data4 = try Data(contentsOf: url4!)
            image4.image = NSImage(data: data4)
            }else{
                image4.image = nil
                return
            }
            image5.image = nil
            image6.image = nil
            image7.image = nil
            image8.image = nil
            image9.image = nil
            image10.image = nil
            image11.image = nil
            image12.image = nil
            image13.image = nil
            image14.image = nil
            image15.image = nil
            
            
        } catch {
            print("error!")
        }
        
    }
    
    @IBAction func writeURLstoDB(_ sender: NSButton) {
        writeURLstoDB()
    }
    
    func writeURLstoDB(){
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
         result![0].imageSlot1 = imageOverride1TxtField.stringValue
         result![0].imageSlot2 = imageOverride2TxtField.stringValue
        }
    }
    
    
    @IBAction func saveButton(_ sender: NSButton) {
        saveDataFields()
    }
    
    //write updated objects to realm
    func saveDataFields() {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            //result![0].upc = UPCField.integerValue
            result![0].price = price.doubleValue
            result![0].shipping = shipping.integerValue
            result![0].sku = sku.stringValue
            result![0].brand = brand.stringValue
            result![0].itemDescription = itemDescriptionField.stringValue
            result![0].style = style.stringValue
            result![0].color = colorField.stringValue
            result![0].size = size.stringValue
            result![0].sizeType = sizeType.stringValue
            result![0].image = image.stringValue
            result![0].msrp = msrp.stringValue
            result![0].sleeveStyle = sleeveStyle.stringValue
            result![0].sleeveLength = sleeveLength.stringValue
            result![0].ebayCategory = ebayCategory.stringValue
            result![0].storeCategory = storeCategory.stringValue
            result![0].eBayConditionID = eBayConditionID.integerValue
            result![0].sizeType = sizeType.stringValue
           // result![0].inventoryCount = inventoryCount.integerValue
            }
        
        print(result![0].itemDescription)
    }
    
    
    
    
    @IBAction func override(_ sender: NSButton) {
        performSegue(withIdentifier: "OVERRIDEIMGSEGUE", sender: self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        switch segue.identifier {
         case "OVERRIDEIMGSEGUE":
        var vc = segue.destinationController as! OverrideIMG
        AltImgText1 = String(describing: hdArrayOfURLs[7])
        AltImgText2 = String(describing: hdArrayOfURLs[8])
        vc.altImg1 = AltImgText1
        vc.altImg2 = AltImgText2
        vc.upcValue = ovrUPC
       
       // case "HighRezImageViewController":
         //   var vc = segue.destinationController as! HighRezImageViewController
          // print("dope")
        default: break
        }
    }
    

    //Display HD image @IBaction triggers
    
    @IBAction func Image1HighRezOpen(_ sender: NSButton) {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode!
        performSegue(withIdentifier: "SegueHD", sender: self)
    }
    
    @IBAction func Image2HighRezOpen(_ sender: NSButton) {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode! + 1
        performSegue(withIdentifier: "SegueHD", sender: self)
    }
    
    @IBAction func Image3HighRezOpen(_ sender: NSButton) {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode! + 2
        performSegue(withIdentifier: "SegueHD", sender: self)
    }
    
    @IBAction func Image4HighRezOpen(_ sender: NSButton) {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode! + 3
        performSegue(withIdentifier: "SegueHD", sender: self)
    }
    
    @IBAction func Image5HighRezOpen(_ sender: NSButton) {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode! + 4
        performSegue(withIdentifier: "SegueHD", sender: self)
    }
    
    @IBAction func Image6HighRezOpen(_ sender: NSButton) {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode! + 5
        performSegue(withIdentifier: "SegueHD", sender: self)
    }
    
    @IBAction func Image7HighRezOpen(_ sender: NSButton) {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode! + 6
        performSegue(withIdentifier: "SegueHD", sender: self)
      }
    
    @IBAction func Image8HighRezOpen(_ sender: NSButton) {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode! + 7
        performSegue(withIdentifier: "SegueHD", sender: self)
    }

  @IBAction func Image9HighRezOpen(_ sender: NSButton) {
      tempHRimageCode = HRimageCode
      HRimageCode = HRimageCode! + 8
      performSegue(withIdentifier: "SegueHD", sender: self)
  }
  
    @IBAction func Image10HighRezOpen(_ sender: NSButton) {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode! + 9
        performSegue(withIdentifier: "SegueHD", sender: self)
    }
    
    @IBAction func Image11HighRezOpen(_ sender: NSButton) {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode! + 10
        performSegue(withIdentifier: "SegueHD", sender: self)
    }
    
    @IBAction func Image12HighRezOpen(_ sender: NSButton) {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode! + 11
        performSegue(withIdentifier: "SegueHD", sender: self)
    }
    
    @IBAction func Image13HighRezOpen(_ sender: NSButton) {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode! + 12
        performSegue(withIdentifier: "SegueHD", sender: self)
    }
    
    @IBAction func Image14HighRezOpen(_ sender: NSButton) {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode! + 13
        performSegue(withIdentifier: "SegueHD", sender: self)
    }
    @IBAction func Image15HighRezOpen(_ sender: NSButton) {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode! + 14
        performSegue(withIdentifier: "SegueHD", sender: self)
    }
    }



