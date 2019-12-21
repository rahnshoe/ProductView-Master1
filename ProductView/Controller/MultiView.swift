//
//  MultiView.swift
//  ProductView
//
//  Created by chris rahn on 3/20/19.
//  Copyright © 2019 chris rahn. All rights reserved.
//


import Cocoa
import RealmSwift

var hiRezImgURLbegin = "https://slimages.macysassets.com/is/image/MCY/products/1/optimized/"
var hiRezImgURLEnd = "_fpx.tif?op_sharpen=1&wid=1230&hei=1500&fit=fit,1&$filterxlrg$"
var lowImgURLbegin = "https://slimages.macys.com/is/image/MCY/"
var lowImgURLEnd = ""
var HRimageCode: Int?
var tempHRimageCode: Int?
var reviewModeState = "off"

var HRZurl1: String?
var HRZurl2: String?
var HRZurl3: String?
var HRZurl4: String?
var HRZimg1Selected = false
var HRZimg2Selected = false
var HRZimg3Selected = false
var HRZimg4Selected = false


//var hiRezImgURLbegin = "https://slimages.macysassets.com/is/image/MCY/products/1/optimized/"
//var hiRezImgURLEnd = "_fpx.tif?op_sharpen=1&wid=1230&hei=1500&fit=fit,1&$filterxlrg$"
//var lowImgURLbegin = "https://slimages.macys.com/is/image/MCY/"
//var lowImgURLEnd = ""
//


class MultiView: NSViewController, ScaleData, ScaleStatus {
    
  
 
    var calculatedOunces: Float?
        
    var results: Results<Product>?
    var result: Results<Product>?
    var searchString: Int = 0
    var counter = 0
    var arrayOfURLs: [URL] = []
    var hdArrayOfURLs: [URL] = []
    
    var AltImgText1 = ""
    var AltImgText2 = ""
    var ovrUPC = ""
    //var reviewModeState = "off"
    var inventoryCheckInModeState: String?
 

    
    var scale = OhausScale()
    
    let shipCodeFree = 999308
    let shipCode3_99 = 912391
    let shipCode4_99 = 1001736
    let shipCode5_99 = 912401
    let shipCode6_99 = 851453
    let shipCode7_99 = 851436
    let shipCode8_99 = 851450
    let shipCope9_99 = 912425
    let shipcode13_99 = 1001772
    let shipCode18_99 = 851451
    var ecomDashShipCode: Int?
    
  
    
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
    @IBOutlet weak var colorPicker: NSPopUpButton!
    @IBOutlet weak var stylePicker: NSPopUpButtonCell!
    
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
    @IBOutlet weak var ebayConditionSelector: NSPopUpButton!
    @IBOutlet weak var overrideShipping: NSPopUpButton!
    @IBOutlet weak var brandSelector: NSPopUpButton!
    @IBOutlet weak var sizeSelector: NSPopUpButton!
    @IBOutlet weak var sleeveLengthSelector: NSPopUpButton!
//    @IBOutlet weak var sleeveStyleSelector: NSPopUpButton!
    
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
    
    

    func displayWeight(weight: String, lbs: Int, ounces: Int, ounceFraction: Int) {
        print(weight)
        self.weightDisplay.stringValue = weight
        print("multiView Lbs: \(lbs) ounces: \(ounces).\(ounceFraction)")
        
       calculatedOunces = Float((lbs*16) + ounces) + ((Float(ounceFraction))/1000) + Float(1)
       print("calculatedOunces: \(String(describing: calculatedOunces))")
        shippingCalculator()
        
    }
    
    
   

    func displayScaleStatus(status: String) {
       self.scaleStatus.stringValue = status
  }
   
    override func viewDidLoad() {
        setupPopUpButtons()
        scale.scaleDelegate = self
        scale.scaleStatusDelegate = self
        //scale.scaleBegin()
        counter = 0
        
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func shippingCalculator() {
        print(calculatedOunces!)
    
              
              if calculatedOunces! <= 4{
                  shipping.stringValue = "3.99"
                ecomDashShipCode = shipCode3_99
                  
              }else if calculatedOunces! <= 8{
                  shipping.stringValue = "4.99"
                  ecomDashShipCode = shipCode4_99
                  
              }else if calculatedOunces! <= 12{
                  shipping.stringValue = "5.99"
                  ecomDashShipCode = shipCode5_99
                  
              }else if calculatedOunces! < 16 {
                   shipping.stringValue = "6.99"
                  ecomDashShipCode = shipCode6_99
                   
              }else if calculatedOunces! >= 16 {
                  shipping.stringValue = "6.99"
                  ecomDashShipCode = shipCode6_99
        }
              
//              }else if overrideShipping.selectedItem = 1 {
//                        shipping.stringValue = "7.99"
//                        ecomDashShipCode = shipCode7_99
                    
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
            overrideShipping.selectItem(at: 0)
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
        ebayConditionSelector.removeAllItems()
        overrideShipping.removeAllItems()
        colorPicker.removeAllItems()
        stylePicker.removeAllItems()
        brandSelector.removeAllItems()
        sizeSelector.removeAllItems()
        //sleeveStyleSelector.removeAllItems()
        sleeveLengthSelector.removeAllItems()
        
    
        
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
        ebayConditionSelector.addItems(withTitles: ["", "New", "New Other", "New W/ Defects"])
        overrideShipping.addItems(withTitles: ["", "7.99", "8.99", "9.99", "13.99", "18.99", "Free"])
        colorPicker.addItems(withTitles: ["", "Beige", "Black", "Blue", "Brown", "Charcoal", "Copper", "Gold", "Gray", "Green", "Multicolored", "Natural", "Navy", "Orange", "Pink", "Purple", "Red", "Silver", "Taupe", "Turquoise", "White", "Wine", "Yellow"])
        stylePicker.addItems(withTitles: ["", "Blouse", "Bodysuit", "Cami", "Coat", "Dress", "Gown", "Hoodie", "Jacket", "Jeans", "Jumpsuit", "Legging" ,"Maxi", "Mini", "Overall", "Pants", "Pullover", "Romper", "Shirt", "Shorts", "Skirt", "Sleepwear", "Sweater", "Sweatshirt", "Tank", "Tee", "Top", "Trouser", "T-Shirt", "Tunic", "Vest", "Wrap"])
        brandSelector.addItems(withTitles: ["", "7 For All Mankind", "Adriano Goldschmied", "ASTR The Label", "Bar III", "Carbon Copy", "Current Air", "Dee Elle", "Free People", "Ginger by Stella & Ginger", "Guess", "Heartloom", "Hudson", "JOA", "Joe's Jeans", "Kendall + Kylie", "Leyden", "Line & Dot", "Lucky Brand", "Lucy Paris", "Maison Jules", "Moon River", "Nanette Lepore", "Paige", "Project 28","Rachel Roy", "Rachel Zoe", "Sanctuary", "Topson Downs", "Trina Turk", "True Vintage"])
        sizeSelector.addItems(withTitles: ["", "XXS", "XS", "S", "M", "L", "XL", "XXL", "3XL", "4XL", "5XL", "6XL", "0", "2", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22"])
        //sleeveStyleSelector.addItems(withTitles: ["Short Sleeve", "Long Sleeve", "3/4 Sleeve", "Sleeveless"])
        sleeveLengthSelector.addItems(withTitles: ["", "Short Sleeve", "Long Sleeve", "3/4 Sleeve", "Sleeveless"])

        
    
    
        
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
        ebayConditionSelector.selectItem(at: 0)
        overrideShipping.selectItem(at: 0)
        colorPicker.selectItem(at: 0)
        stylePicker.selectItem(at: 0)
        brandSelector.selectItem(at: 0)
        sizeSelector.selectItem(at: 0)
        //sleeveStyleSelector.selectItem(at: 0)
        sleeveLengthSelector.selectItem(at: 0)
        
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

    func setAlternateImagetoALL() {
               image1.image = image1.alternateImage
               image2.image = image2.alternateImage
               image3.image = image3.alternateImage
               image4.image = image4.alternateImage
               image5.image = image5.alternateImage
               image6.image = image6.alternateImage
               image7.image = image7.alternateImage
               image8.image = image8.alternateImage
               image9.image = image9.alternateImage
               image10.image = image10.alternateImage
               image11.image = image11.alternateImage
               image12.image = image12.alternateImage
               image13.image = image13.alternateImage
               image14.image = image14.alternateImage
               image15.image = image15.alternateImage
    }

    @IBAction func SetNoImages(_ sender: NSButton) {
        if sender.state == .on{
            //********** save flag to no image column in DB*********
       setAlternateImagetoALL()
            
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
                //let path0 =  String(describing: hdArrayOfURLs[0])
                let path0 = "******************************"
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
                realm.create(Product.self, value: ["upc": upcValue!, "imageSlot1": path0], update: .modified)
                realm.create(Product.self, value: ["upc": upcValue!, "imageSlot2": path0], update: .modified)
                realm.create(Product.self, value: ["upc": upcValue!, "imageSlot3": path0], update: .modified)
                realm.create(Product.self, value: ["upc": upcValue!, "imageSlot4": path0], update: .modified)
            }
        }else{
            sender.state = .off
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
        }

        
        
    }
    
    @IBAction func inventoryCheckInMode(_ sender: NSButton) {
        if sender.state == .on{
        inventoryCheckInModeState =  "on"
        qtyReceived.stringValue = "1"
            qtyReceived.backgroundColor = NSColor.yellow
        }else{
             qtyReceived.backgroundColor = NSColor.white
            qtyReceived.stringValue = ""
            weightDisplay.stringValue = ""
            
            
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
           
            sizeType.stringValue = ""
            storeCategory.stringValue = ""
            UPCField.textColor = NSColor.red
            itemDescriptionField.stringValue = "not found"
            itemDescriptionField.textColor = NSColor.red
            OriginalQty.stringValue = ""
            inventoryCount.stringValue = ""
            ebayConditionSelector.selectItem(at: 0)
            overrideShipping.selectItem(at: 0)
            UPCSearchField.stringValue = ""
            UPCField.stringValue = ""
            itemDescriptionField.stringValue = ""
            

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
    
    @IBAction func addWomens(_ sender: NSButton) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        results = realm.objects(Product.self)
        try! realm.write {
        
        // print(results?.count as Any)
        if results?.count != nil {
            searchString = UPCSearchField!.integerValue
            //print("Search String")
            // print(searchString)
            let predicate = NSPredicate(format: "upc == %@", NSNumber (value: searchString))
            result = results!.filter(predicate)
            print("result")
            print(result.self)
            //print("ID \(result![0].itemDescription)")
            var ID = result![0].vendorName
            if ID.contains("Bar III"){
                print("I found Bar III")
                ID = ID.replacingOccurrences(of: "Bar III", with: "Bar III")
                print(ID)
                result![0].brand = ID
            }else if ID.contains("FREE PEOPLE/URBAN OUTFITTERS") {
                print("I found Free People")
                ID = ID.replacingOccurrences(of: "FREE PEOPLE/URBAN OUTFITTERS", with: "Free People")
                result![0].brand = ID
                var sentanceToCapitalize =  result![0].brand + " Womens " + result![0].itemDescription + " " + result![0].color + " " + result![0].size
                result![0].itemDescription = sentanceToCapitalize.localizedCapitalized
                
            }
            
        }
    }
    }
    
    @IBAction func SearchBar(_ sender: Any) {
        
        arrayOfURLs = []
        hdArrayOfURLs = []
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        results = realm.objects(Product.self)
            
        if results?.count != nil {
            searchString = UPCSearchField!.integerValue
            //print("Search String")
            //print(searchString)
            let predicate = NSPredicate(format: "upc == %@", NSNumber (value: searchString))
            result = results!.filter(predicate)
           // print("result: \(result)")
            
            if (result?.count)! > 0 {
                
                let imageCode = Int(result![0].code)
                HRimageCode = Int(result![0].code)!
                print(result![0].image)
            
                if result![0].image.contains("macy") {
                    HRimageCode = Int(result![0].code)!
                    hiRezImgURLbegin = "https://slimages.macysassets.com/is/image/MCY/products/1/optimized/"
                    hiRezImgURLEnd = "_fpx.tif?op_sharpen=1&wid=1230&hei=1500&fit=fit,1&$filterxlrg$"
                    lowImgURLbegin = "https://slimages.macys.com/is/image/MCY/"
                    lowImgURLEnd = ""
                    
                }else if result![0].image.contains("bloom") {
                    HRimageCode = Int(result![0].code)!
                    hiRezImgURLbegin = "https://images.bloomingdalesassets.com/is/image/BLM/products/3/optimized/"
                    hiRezImgURLEnd = "_fpx.tif?op_sharpen=1&wid=1200&fit=fit,1&$filtersm$"
                    lowImgURLbegin = "https://images.bloomingdales.com/is/image/BLM/"
                    lowImgURLEnd = ""
                } else if result![0].image == "" {
                    setAlternateImagetoALL()
                    return
                }
    
                

                if reviewModeState == "off" {
                    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                    weightDisplay.stringValue = ""
                    shipping.stringValue = ""
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
                    //price.stringValue = String(result![0].price)
                    //shipping.stringValue = String(result![0].shipping)
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
           
                    
                    sizeType.stringValue = String(result![0].sizeType)
                    ovrUPC = String(result![0].upc)
                    
                    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                    
                    //iterate and set image display
                    DispatchQueue.global(qos: .userInitiated).async {
                   // DispatchQueue.main.async {
                    
                        let images = [self.image1, self.image2, self.image3, self.image4,self.image5, self.image6, self.image7, self.image8, self.image9, self.image10, self.image11, self.image12, self.image13, self.image14, self.image15]
                    var incrementer = 0
                    
                    repeat {
                        for i in images {
                            let url1 = URL(string: "\(lowImgURLbegin)\(imageCode! + incrementer )\(lowImgURLEnd)")
                            let hdUrl1 = URL(string: "\(hiRezImgURLbegin)\(imageCode! + incrementer )\(hiRezImgURLEnd)")
                            incrementer += 1
                            print(url1)
                            //HRimageCode = URL(string: "\(hiRezImgURLbegin)\(imageCode! + incrementer )\(hiRezImgURLEnd)")
                            self.arrayOfURLs.append(url1!)
                            self.hdArrayOfURLs.append(hdUrl1!)
                            do {
                                let data = try Data(contentsOf: url1!)
                                DispatchQueue.main.async {
                                i!.image = NSImage(data: data)
                                //print(incrementer)
                                //print("\(incrementer) time(s) around")
                                }
                            } catch {
                              DispatchQueue.main.async {
                                print("error!")
                                i!.image = self.image1.alternateImage
                            }
                            }
                        }
                    }while incrementer <= 7
                    }
                    
                    
                    
                    
                } else {
                    //******** ReviewModeSate is ON *********
                    print("review mode on")
                    updateimages()
                    price.stringValue = String(result![0].price)
                    let shippingDisplayValue = result![0].shipping
                    if shippingDisplayValue == 912391 {
                        shipping.stringValue = "3.99"
                    }else if shippingDisplayValue == 1001736 {
                         shipping.stringValue = "4.99"
                        }else if shippingDisplayValue == 912401 {
                        shipping.stringValue = "5.99"
                        }else if shippingDisplayValue == 851453{
                        shipping.stringValue = "6.99"
                        }else if shippingDisplayValue == 851436{
                        shipping.stringValue = "7.99"
                        }else if shippingDisplayValue == 851450 {
                        shipping.stringValue = "8.99"
                        }else if shippingDisplayValue == 912425 {
                        shipping.stringValue = "9.99"
                        }else if shippingDisplayValue == 1001772 {
                        shipping.stringValue = "13.99"
                        }else if shippingDisplayValue == 851451{
                        shipping.stringValue = "18.99"
                        }else if shippingDisplayValue == 999308 {
                        shipping.stringValue = "free"
                    }
                    let ebayConditionSelectorValue = result![0].eBayConditionID
                                       if ebayConditionSelectorValue == 1000 {
                                           ebayConditionSelector.selectItem(at: 1)
                                       }else if ebayConditionSelectorValue == 1500 {
                                            ebayConditionSelector.selectItem(at: 2)
                                           }else if ebayConditionSelectorValue == 1750 {
                                           ebayConditionSelector.selectItem(at: 3)
                                       }else{
                                           ebayConditionSelector.selectItem(at: 0)
                                       }
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
                //eBayConditionID.stringValue = ""
                sizeType.stringValue = ""
                storeCategory.stringValue = ""
                UPCField.textColor = NSColor.red
                itemDescriptionField.stringValue = "not found"
                itemDescriptionField.textColor = NSColor.red
                OriginalQty.stringValue = ""
                inventoryCount.stringValue = ""
                ebayConditionSelector.selectItem(at: 0)
                overrideShipping.selectItem(at: 0)
                //prodImage.image = nil
                //image8.image = nil
                
            }
            
            
        } else {
           UPCField.stringValue = "No Realm File!"
        }

    }
    
    @IBAction func colorSelected(_ sender: NSPopUpButton) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
           
            let previousColor = result![0].color
            
            if colorPicker.indexOfSelectedItem == 1 {
                result![0].color = "Beige"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Beige")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 2 {
                result![0].color = "Black"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Black")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 3 {
                result![0].color = "Blue"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Blue")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 4 {
                result![0].color = "Brown"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Brown")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 5 {
                result![0].color = "Charcoal"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Charcoal")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 6 {
                result![0].color = "Copper"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Copper")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 7 {
                result![0].color = "Gold"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Gold")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 8 {
                result![0].color = "Gray"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Gray")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 9 {
                result![0].color = "Green"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Green")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 10 {
                result![0].color = "Multicolored"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Multicolored")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 11 {
                result![0].color = "Natural"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Natural")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 12 {
                result![0].color = "Navy"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Navy")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 13 {
                result![0].color = "Orange"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Orange")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 14 {
                result![0].color = "Pink"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Pink")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 15 {
                result![0].color = "Purple"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Purple")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 16 {
                result![0].color = "Red"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Red")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 17 {
                result![0].color = "Silver"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Silver")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 18 {
                result![0].color = "Taupe"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Taupe")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 19 {
                result![0].color = "Turquoise"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Turquoise")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 20 {
                result![0].color = "White"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "White")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 21 {
                result![0].color = "Wine"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Wine")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else if colorPicker.indexOfSelectedItem == 22 {
                result![0].color = "Yellow"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: "Yellow")
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
                colorPicker.selectItem(at: 0)
                
            }else{
                return
            }
             
            if result![0].itemDescription.contains("**COLOR**"){
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: "**COLOR**", with: result![0].color)
                color.stringValue = result![0].color
                itemDescriptionField.stringValue = result![0].itemDescription
            }else{
                return
                
            }
            }
    
       }
    
    @IBAction func colorManualOverride(_ sender: NSTextField) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
        let previousColor = result![0].color
        print(previousColor)
        result![0].color = color.stringValue
        let newColor = color.stringValue
        result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: newColor)
        itemDescriptionField.stringValue = result![0].itemDescription
        colorPicker.selectItem(at: 0)
            
    }
    }
    
    @IBAction func styleSelected(_ sender: NSPopUpButtonCell) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
               let realm = try! Realm(configuration: config)
               try! realm.write {
                
                 let previousStyle = result![0].style
                
                if stylePicker.indexOfSelectedItem == 1 {
                    result![0].style = "Blouse"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Blouse")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "53159"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "29010495011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 2 {
                    result![0].style = "Bodysuit"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Bodysuit")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "53159"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "29010495011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 3 {
                    result![0].style = "Cami"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Cami")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "53159"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "29010495011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 4 {
                    result![0].style = "Coat"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Coat")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "63862"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "1"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 5 {
                    result![0].style = "Dress"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Dress")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "63861"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "28973014011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 6 {
                    result![0].style = "Gown"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Gown")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "63861"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "28973014011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 7 {
                    result![0].style = "Hoodie"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Hoodie")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "155226"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "1"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 8 {
                    result![0].style = "Jacket"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Jacket")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "63862"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "1"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 9 {
                    result![0].style = "Jeans"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Jeans")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "11554"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "31775381011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 10 {
                    result![0].style = "Jumpsuit"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Jumpsuit")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "3009"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "1"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 11 {
                    result![0].style = "Legging"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Legging")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "63863"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "31775381011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 12 {
                    result![0].style = "Maxi"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Maxi")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "63861"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "28973014011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 13 {
                    result![0].style = "Mini"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Mini")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "63864"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "33096451011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 14 {
                    result![0].style = "Overall"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Overall")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "63863"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "31775381011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 15 {
                    result![0].style = "Pants"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Pants")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "63863"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "31775381011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 16 {
                    result![0].style = "Pullover"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Pullover")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "53159"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "29010495011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 17 {
                    result![0].style = "Romper"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Romper")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "3009"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "1"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 18 {
                    result![0].style = "Shirt"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Shirt")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "53159"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "29010495011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 19 {
                    result![0].style = "Shorts"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Shorts")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "11555"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "31775416011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 20 {
                    result![0].style = "Skirt"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Skirt")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory =  "63864"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "33096451011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 21 {
                    result![0].style = "Sleepwear"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Sleepwear")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "63855"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "1"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 22 {
                    result![0].style = "Sweater"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Sweater")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "63866"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "29010495011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 23 {
                    result![0].style = "Sweatshirt"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Sweatshirt")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "155226"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "1"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 24 {
                    result![0].style = "Tank"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Tank")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "53159"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "29010495011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 25 {
                    result![0].style = "Tee"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Tee")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "53159"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "29010495011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 26 {
                    result![0].style = "Top"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Top")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "53159"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "29010495011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 27 {
                    result![0].style = "T-shirt"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "T-shirt")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "53159"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "29010495011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 28 {
                    result![0].style = "Trouser"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Trouser")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "63863"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "31775381011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 29 {
                    result![0].style = "Tunic"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Tunic")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "53159"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "29010495011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 30 {
                    result![0].style = "Vest"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Vest")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "63862"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "1"
                    storeCategory.stringValue = result![0].storeCategory
                    
                    stylePicker.selectItem(at: 0)
                    
                }else if stylePicker.indexOfSelectedItem == 31 {
                    result![0].style = "Wrap"
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: "Wrap")
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                    result![0].ebayCategory = "63861"
                    ebayCategory.stringValue = result![0].ebayCategory
                    result![0].storeCategory = "28973014011"
                    storeCategory.stringValue = result![0].storeCategory
                    stylePicker.selectItem(at: 0)
                }else{
                    return
                }
                    
                if result![0].itemDescription.contains("**STYLE**"){
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: "**STYLE**", with: result![0].style)
                    style.stringValue = result![0].style
                    itemDescriptionField.stringValue = result![0].itemDescription
                }else{
                    return
                       
                   }
                   }
    }
    
    @IBAction func styleManualOverride(_ sender: NSTextField) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
        let previousStyle = result![0].style
        print(previousStyle)
        result![0].style = style.stringValue
        let newStyle = style.stringValue
        result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: newStyle)
        itemDescriptionField.stringValue = result![0].itemDescription
        stylePicker.selectItem(at: 0)
    }
    }
    
    
    @IBAction func brandSelected(_ sender: NSPopUpButton) {

        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
         
          let previousBrand = result![0].brand
         
            if brandSelector.indexOfSelectedItem == 1 {
                result![0].brand = "7 For All Mankind"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "7 For All Mankind")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 2 {
                result![0].brand = "Adriano Goldschmied"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Adriano Goldschmied")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 3 {
                result![0].brand = "ASTR The Label"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "ASTR The Label")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 4 {
                result![0].brand = "Bar III"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Bar III")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 5 {
                result![0].brand = "Carbon Copy"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Carbon Copy")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 6 {
                result![0].brand = "Current Air"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Current Air")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 7 {
                result![0].brand = "Dee Elle"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Dee Elle")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 8 {
                result![0].brand = "Free People"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Free People")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 9 {
                result![0].brand = "Ginger By Stella"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Ginger By Stella")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 10 {
                result![0].brand = "Guess"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Guess")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 11 {
                result![0].brand = "Heartloom"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Heartloom")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 12 {
                result![0].brand = "Hudson"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Hudson")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 13 {
                result![0].brand = "JOA"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "JOA")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 14 {
                result![0].brand = "Joe's Jeans"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Joe's Jeans")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 15 {
                result![0].brand = "Kendall + Kylie"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Kendall + Kylie")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 16 {
                result![0].brand = "Leyden"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Leyden")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 17 {
                result![0].brand = "Line & Dot"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Line & Dot")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 18 {
                result![0].brand = "Lucky Brand"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Lucky Brand")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 19 {
                result![0].brand = "Lucy Paris"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Lucy Paris")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 20 {
                result![0].brand = "Maison Jules"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Maison Jules")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 21 {
                result![0].brand = "Moon River"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Moon River")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 22 {
                result![0].brand = "Nanette Lepore"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Nanette Lepore")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 23 {
                result![0].brand = "Paige"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Paige")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 24 {
                result![0].brand = "Project 28"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Project 28")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 25 {
               result![0].brand = "Rachel Roy"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Rachel Roy")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 26 {
                result![0].brand = "Rachel Zoe"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Rachel Zoe")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 27 {
                result![0].brand = "Sanctuary"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Sanctuary")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 28 {
                result![0].brand = "Topson Downs"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Topson Downs")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 29 {
                result![0].brand = "Trina Turk"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "Trina Turk")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
            }else if brandSelector.indexOfSelectedItem == 30 {
                result![0].brand = "True Vintage"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: "True Vintage")
                brand.stringValue = result![0].brand
                itemDescriptionField.stringValue = result![0].itemDescription
                brandSelector.selectItem(at: 0)
                
                }else{
                    return
                }
                 
                if result![0].itemDescription.contains("**BRAND**"){
                    result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: "**BRAND**", with: result![0].brand)
                    brand.stringValue = result![0].brand
                    itemDescriptionField.stringValue = result![0].itemDescription
                }else{
                    return
                    
            }
        }
    }
    
    
    @IBAction func brandManualOverride(_ sender: NSTextField) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
        let previousBrand = result![0].brand
        result![0].brand = brand.stringValue
        let newBrand = brand.stringValue
        result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: newBrand)
        itemDescriptionField.stringValue = result![0].itemDescription
        brandSelector.selectItem(at: 0)
    }
    }
    
    
    
    @IBAction func sizeSelected(_ sender: NSPopUpButton) {
        
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            
            let previousSize = result![0].size
            
            if sizeSelector.indexOfSelectedItem == 1 {
                result![0].size = "XXS"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "XXS")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 2 {
                result![0].size = "XS"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "XS")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 3 {
                result![0].size = "S"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "S")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 4 {
                result![0].size = "M"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "M")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 5 {
                result![0].size = "L"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "L")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 6 {
                result![0].size = "XL"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "XL")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 7 {
                result![0].size = "XXL"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "XXL")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 8 {
                result![0].size = "3XL"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "3XL")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 9 {
                result![0].size = "4XL"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "4XL")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 10 {
                result![0].size = "5XL"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "5XL")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 11 {
                result![0].size = "6XL"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "6XL")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 12 {
                result![0].size = "0"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "0")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 13 {
                result![0].size = "2"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "2")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 14 {
                result![0].size = "4"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "4")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 15 {
                result![0].size = "6"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "6")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 16 {
                result![0].size = "8"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "8")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 17 {
                result![0].size = "10"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "10")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 18 {
                result![0].size = "12"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "12")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 19 {
                result![0].size = "14"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "14")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 20 {
                result![0].size = "16"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "16")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 21 {
                result![0].size = "18"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "18")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 22 {
                result![0].size = "20"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "20")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
                
            } else if sizeSelector.indexOfSelectedItem == 23 {
                result![0].size = "22"
                result![0].itemDescription = result![0].itemDescription.replacingLastOccurrenceOfString(previousSize, with: "22")
                size.stringValue = result![0].size
                itemDescriptionField.stringValue = result![0].itemDescription
                sizeSelector.selectItem(at: 0)
            }
        }
    }
    
    
    @IBAction func sizeManualOverride(_ sender: NSTextField) {
          let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
          let realm = try! Realm(configuration: config)
          try! realm.write {
          let previousSize = result![0].size
          result![0].size = size.stringValue
          let newSize = size.stringValue
          result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousSize, with: newSize)
          itemDescriptionField.stringValue = result![0].itemDescription
          sizeSelector.selectItem(at: 0)
      }
      }
    
    
//    func updateitemDescription() {
//        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
//                          let realm = try! Realm(configuration: config)
//                          try! realm.write {
//      //  let brandPlusWomens = result![0].brand + " Womens "
//      //  let itemDescriptionPlusColor = result![0].itemDescription + " " + result![0].color + " "
//     //   let wholeEnchilada = brandPlusWomens + itemDescriptionPlusColor + result![0].size
//       // result![0].itemDescription = wholeEnchilada
//
//        result![0].itemDescription = result![0].brand + " Womens " + result![0].itemDescription + " " + result![0].color + " " + result![0].size
//        }
//    }
    
    @IBAction func addToInventory(_ sender: NSButton) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
                   let realm = try! Realm(configuration: config)
                   try! realm.write {
        inventoryCount.stringValue = String(qtyReceived.intValue + inventoryCount.intValue)
        result![0].inventoryCount = inventoryCount.integerValue
        self.qtyReceived.stringValue = "1"
    
        
        if inventoryCheckInModeState == "on" {
             result![0].shipping = ecomDashShipCode!
        let overrideShippingIndex = overrideShipping.indexOfSelectedItem
            
            if overrideShippingIndex == 0 {
                return
                 }else if overrideShippingIndex == 1 {
                      ecomDashShipCode = 851436
                  }else if overrideShippingIndex == 2 {
                      ecomDashShipCode = 851450
                  }else if overrideShippingIndex == 3 {
                      ecomDashShipCode = 912425
                  }else if overrideShippingIndex == 4 {
                      ecomDashShipCode = 1001772
                  }else if overrideShippingIndex == 5 {
                      ecomDashShipCode = 851451
                  }else if overrideShippingIndex == 6 {
                      ecomDashShipCode = 999308
                  }
               result![0].shipping = ecomDashShipCode!
        }
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
        

        
        let url1a = result![0].imageSlot1
//        let url2a = result![0].imageSlot2
//        let url3a = result![0].imageSlot3
//        let url4a = result![0].imageSlot4
        
        if url1a == "******************************" {
            image1.image = image1.alternateImage
            image2.image = image2.alternateImage
            image3.image = image3.alternateImage
            image4.image = image4.alternateImage
        }else{
            
            
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
            let selectedIndex1 = ebayConditionSelector.indexOfSelectedItem
            if selectedIndex1 == 0 {
                result![0].eBayConditionID = 1000
            }else if selectedIndex1 == 1 {
                    result![0].eBayConditionID = 1500
            }else{
                    result![0].eBayConditionID = 1750
                }
            
            let overrideShippingIndex = overrideShipping.indexOfSelectedItem
            if overrideShippingIndex == 1 {
                ecomDashShipCode = 851436
            }else if overrideShippingIndex == 2 {
                ecomDashShipCode = 851450
            }else if overrideShippingIndex == 3 {
                ecomDashShipCode = 912425
            }else if overrideShippingIndex == 4 {
                ecomDashShipCode = 1001772
            }else if overrideShippingIndex == 5 {
                ecomDashShipCode = 851451
            }else if overrideShippingIndex == 6 {
                ecomDashShipCode = 999308
            }
                
            
            //result![0].upc = UPCField.integerValue
            result![0].price = price.doubleValue
            result![0].shipping = ecomDashShipCode!
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
            //result![0].eBayConditionID = selectedIndex1
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
        if HRimageCode != nil {
       // tempHRimageCode = HRimageCode
        print("state is: \(reviewModeState)")
        HRZurl1 = result![0].imageSlot1
        HRZimg1Selected = true
        performSegue(withIdentifier: "SegueHD", sender: self)
        }else{
            return
        }
    }
    
    @IBAction func Image2HighRezOpen(_ sender: NSButton) {
        if HRimageCode != nil {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode! + 1
        HRZurl2 = result![0].imageSlot2
        HRZimg2Selected = true
        performSegue(withIdentifier: "SegueHD", sender: self)
    }
    }
    
    @IBAction func Image3HighRezOpen(_ sender: NSButton) {
        if HRimageCode != nil {
        tempHRimageCode = HRimageCode
        HRimageCode = HRimageCode! + 2
        HRZurl3 = result![0].imageSlot3
        HRZimg3Selected = true
        performSegue(withIdentifier: "SegueHD", sender: self)
    }
    }
    
    @IBAction func Image4HighRezOpen(_ sender: NSButton) {
        if HRimageCode != nil {
            tempHRimageCode = HRimageCode
            HRimageCode = HRimageCode! + 3
            HRZurl4 = result![0].imageSlot4
            HRZimg4Selected = true
            performSegue(withIdentifier: "SegueHD", sender: self)
        }
    }
    
    @IBAction func Image5HighRezOpen(_ sender: NSButton) {
        if HRimageCode != nil {
            tempHRimageCode = HRimageCode
            HRimageCode = HRimageCode! + 4
            performSegue(withIdentifier: "SegueHD", sender: self)
        }
    }
    
    @IBAction func Image6HighRezOpen(_ sender: NSButton) {
        if HRimageCode != nil {
            tempHRimageCode = HRimageCode
            HRimageCode = HRimageCode! + 5
            performSegue(withIdentifier: "SegueHD", sender: self)
        }
    }
    
    @IBAction func Image7HighRezOpen(_ sender: NSButton) {
        if HRimageCode != nil {
            tempHRimageCode = HRimageCode
            HRimageCode = HRimageCode! + 6
            performSegue(withIdentifier: "SegueHD", sender: self)
        }
    }
    @IBAction func Image8HighRezOpen(_ sender: NSButton) {
        if HRimageCode != nil {
            tempHRimageCode = HRimageCode
            HRimageCode = HRimageCode! + 7
            performSegue(withIdentifier: "SegueHD", sender: self)
        }
    }
    
    @IBAction func Image9HighRezOpen(_ sender: NSButton) {
        if HRimageCode != nil {
            tempHRimageCode = HRimageCode
            HRimageCode = HRimageCode! + 8
            performSegue(withIdentifier: "SegueHD", sender: self)
        }
    }
    @IBAction func Image10HighRezOpen(_ sender: NSButton) {
        if HRimageCode != nil {
            tempHRimageCode = HRimageCode
            HRimageCode = HRimageCode! + 9
            performSegue(withIdentifier: "SegueHD", sender: self)
        }
    }
    @IBAction func Image11HighRezOpen(_ sender: NSButton) {
        if HRimageCode != nil {
            tempHRimageCode = HRimageCode
            HRimageCode = HRimageCode! + 10
            performSegue(withIdentifier: "SegueHD", sender: self)
        }
    }
    @IBAction func Image12HighRezOpen(_ sender: NSButton) {
        if HRimageCode != nil {
            tempHRimageCode = HRimageCode
            HRimageCode = HRimageCode! + 11
            performSegue(withIdentifier: "SegueHD", sender: self)
        }
    }
    @IBAction func Image13HighRezOpen(_ sender: NSButton) {
        if HRimageCode != nil {
            tempHRimageCode = HRimageCode
            HRimageCode = HRimageCode! + 12
            performSegue(withIdentifier: "SegueHD", sender: self)
        }
    }
    
    @IBAction func Image14HighRezOpen(_ sender: NSButton) {
        if HRimageCode != nil {
            tempHRimageCode = HRimageCode
            HRimageCode = HRimageCode! + 13
            performSegue(withIdentifier: "SegueHD", sender: self)
        }
    }
    @IBAction func Image15HighRezOpen(_ sender: NSButton) {
        if HRimageCode != nil {
            tempHRimageCode = HRimageCode
            HRimageCode = HRimageCode! + 14
            performSegue(withIdentifier: "SegueHD", sender: self)
        }
    }
    }


//extension String
//{
//    func replacingLastOccurrenceOfString(_ searchString: String,
//            with replacementString: String,
//            caseInsensitive: Bool = true) -> String
//    {
//        let options: String.CompareOptions
//        if caseInsensitive {
//            options = [.backwards, .caseInsensitive]
//        } else {
//            options = [.backwards]
//        }
//
//        if let range = self.range(of: searchString,
//                options: options,
//                range: nil,
//                locale: nil) {
//
//            return self.replacingCharacters(in: range, with: replacementString)
//        }
//        return self
//    }
//}

//extension String
//{
//    func stringByReplacingFirstOccurrenceOfString(target: String, withString replaceString: String) -> String {
//        if let range = self.range(of: target) {
//            return self.replacingCharacters(in: range, with: replaceString)
//        }
//        return self
//    }
//}

extension String
{
    func replacingLastOccurrenceOfString(_ searchString: String,
            with replacementString: String,
            caseInsensitive: Bool = true) -> String
    {
        let options: String.CompareOptions
        if caseInsensitive {
            options = [.backwards, .caseInsensitive]
        } else {
            options = [.backwards]
        }

        if let range = self.range(of: searchString,
                options: options,
                range: nil,
                locale: nil) {

            return self.replacingCharacters(in: range, with: replacementString)
        }
        return self
    }
}
