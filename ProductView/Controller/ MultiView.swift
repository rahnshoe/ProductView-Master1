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

  
    @IBOutlet weak var sleeveLengthSelector: NSPopUpButton!
    @IBOutlet weak var sleeveStyleSelector: NSPopUpButton!
    @IBOutlet weak var sleeveStyleLabel: NSTextField!
    @IBOutlet weak var sleeveLengthLabel: NSTextField!
    
    
    @IBOutlet weak var brandSelector: NSComboBox!
    @IBOutlet weak var styleSelector: NSComboBox!
    @IBOutlet weak var colorSelector: NSComboBox!
    @IBOutlet weak var sizeSelector: NSComboBox!
    
    @IBOutlet weak var sleeveLength: NSTextField!
    @IBOutlet weak var price: NSTextField!
    @IBOutlet weak var shipping: NSTextField!
    @IBOutlet weak var sku: NSTextField!

   

    @IBOutlet weak var sleeveStyle: NSTextField!
    @IBOutlet weak var msrp: NSTextField!
    @IBOutlet weak var ebayCategory: NSTextField!
    @IBOutlet weak var storeCategory: NSTextField!
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
        hideSleeve()
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
    
    
    func hideSleeve() {
        sleeveLengthSelector.isHidden = true
        sleeveLength.isHidden = true
        sleeveStyleSelector.isHidden = true
        sleeveStyle.isHidden = true
        sleeveLengthLabel.isHidden = true
        sleeveStyleLabel.isHidden = true
        
    }
    
    func unhideSleeve(){
        sleeveLengthSelector.isHidden = false
        sleeveLength.isHidden = false
        sleeveStyleSelector.isHidden = false
        sleeveStyle.isHidden = false
        sleeveLengthLabel.isHidden = false
        sleeveStyleLabel.isHidden = false
    }
    
    func readAndSetEbayCategoryCode() {
        if  result![0].ebayCategory == "53159" {
            unhideSleeve()
            ebayCategory.stringValue = "Blouse"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            ebayCategory.stringValue = "Bodysuit"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            ebayCategory.stringValue = "Cami"
            
        }else if result![0].ebayCategory == "63862"{
            unhideSleeve()
            ebayCategory.stringValue = "Coat"
            
        }else if result![0].ebayCategory == "63861"{
            unhideSleeve()
            ebayCategory.stringValue = "Dress"
            
        }else if result![0].ebayCategory == "63861"{
            unhideSleeve()
            ebayCategory.stringValue = "Gown"
            
        }else if result![0].ebayCategory == "155226"{
            unhideSleeve()
            ebayCategory.stringValue = "Hoodie"
            
        }else if result![0].ebayCategory == "63862"{
            unhideSleeve()
            ebayCategory.stringValue = "Jacket"
            
        }else if result![0].ebayCategory == "11554"{
            hideSleeve()
            ebayCategory.stringValue = "Jeans"
            
        }else if result![0].ebayCategory == "3009"{
            unhideSleeve()
            ebayCategory.stringValue = "Jumpsuit"
            
        }else if result![0].ebayCategory == "63863"{
            hideSleeve()
            ebayCategory.stringValue = "Legging"
            
        }else if result![0].ebayCategory == "63861"{
            unhideSleeve()
            ebayCategory.stringValue = "Maxi"
            
        }else if result![0].ebayCategory == "63864"{
            unhideSleeve()
            ebayCategory.stringValue = "Mini"
            
        }else if result![0].ebayCategory == "63863"{
            unhideSleeve()
            ebayCategory.stringValue = "Overall"
            
        }else if result![0].ebayCategory == "63863"{
            hideSleeve()
            ebayCategory.stringValue = "Pants"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            ebayCategory.stringValue = "Pullover"
            
        }else if result![0].ebayCategory == "3009"{
            unhideSleeve()
            ebayCategory.stringValue = "Romper"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            ebayCategory.stringValue = "Shirt"
            
        }else if result![0].ebayCategory == "11555"{
            hideSleeve()
            ebayCategory.stringValue = "Shorts"
            
        }else if result![0].ebayCategory == "63864"{
            hideSleeve()
            ebayCategory.stringValue = "Skirt"
            
        }else if result![0].ebayCategory == "63855"{
            unhideSleeve()
            ebayCategory.stringValue = "Sleepwear"
            
        }else if result![0].ebayCategory == "63866"{
            unhideSleeve()
            ebayCategory.stringValue = "Sweater"
            
        }else if result![0].ebayCategory == "155226"{
            unhideSleeve()
            ebayCategory.stringValue = "Sweatshirt"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            ebayCategory.stringValue = "Tank"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            ebayCategory.stringValue = "Tee"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            ebayCategory.stringValue = "Top"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            ebayCategory.stringValue = "T-shirt"
            
        }else if result![0].ebayCategory == "63863"{
            hideSleeve()
            ebayCategory.stringValue = "Trouser"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            ebayCategory.stringValue = "Tunic"
            
        }else if result![0].ebayCategory == "63862"{
            unhideSleeve()
            ebayCategory.stringValue = "Vest"
            
        }else if result![0].ebayCategory == "63861"{
            unhideSleeve()
            ebayCategory.stringValue = "Wrap"
            
        }else{
            return
        }
    }
    
    func setEbayConditionSelectorValue() {
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
    
    func shippingTranslateCodeForDisplay() {
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
            print("ship string value: \(shipping.stringValue)")
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
    }
    

    func zeroOut() {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
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
        weightDisplay.stringValue = ""
        inventoryCount.stringValue = ""
        msrp.stringValue = ""
        shipping.stringValue = ""
        overrideShipping.selectItem(at: 0)
        sku.stringValue = ""
        UPCField.stringValue = ""
        let tempItemDescription = result![0].itemDescription
        itemDescriptionField.stringValue = ""
        result![0].itemDescription = tempItemDescription
        let tempBrand = result![0].brand
        brandSelector.stringValue = ""
        result![0].brand = tempBrand
        let tempStyle = result![0].style
        styleSelector.stringValue = ""
        result![0].style = tempStyle
        let tempColor = result![0].color
        colorSelector.stringValue = ""
        result![0].color = tempColor
         let tempSize = result![0].size
        sizeSelector.stringValue = ""
        result![0].size = tempSize
        let tempSleeveStyle = result![0].sleeveStyle
        sleeveStyle.stringValue = ""
        result![0].sleeveStyle = tempSleeveStyle
        let tempSleeveLength = result![0].sleeveLength
        sleeveLength.stringValue = ""
        result![0].sleeveLength = tempSleeveLength
        ebayCategory.stringValue = ""
        storeCategory.stringValue = ""
        sizeType.stringValue = ""
        ebayConditionSelector.selectItem(at: 0)
        }
        try! realm.commitWrite()
    }
    
    @IBAction func reviewMode(_ sender: NSButtonCell) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
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
            weightDisplay.stringValue = ""
            inventoryCount.stringValue = ""
            msrp.stringValue = ""
            shipping.stringValue = ""
            overrideShipping.selectItem(at: 0)
            sku.stringValue = ""
            UPCField.stringValue = ""
            let tempItemDescription = result![0].itemDescription
            itemDescriptionField.stringValue = ""
            result![0].itemDescription = tempItemDescription
            let tempBrand = result![0].brand
            brandSelector.stringValue = ""
            result![0].brand = tempBrand
            let tempStyle = result![0].style
            styleSelector.stringValue = ""
            result![0].style = tempStyle
            let tempColor = result![0].color
            colorSelector.stringValue = ""
            result![0].color = tempColor
             let tempSize = result![0].size
            sizeSelector.stringValue = ""
            result![0].size = tempSize
            let tempSleeveStyle = result![0].sleeveStyle
            sleeveStyle.stringValue = ""
            result![0].sleeveStyle = tempSleeveStyle
            let tempSleeveLength = result![0].sleeveLength
            sleeveLength.stringValue = ""
            result![0].sleeveLength = tempSleeveLength
            ebayCategory.stringValue = ""
            storeCategory.stringValue = ""
            sizeType.stringValue = ""
            ebayConditionSelector.selectItem(at: 0)
            
        }else{
            
            print("off")
            reviewModeState = "off"
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
            weightDisplay.stringValue = ""
            inventoryCount.stringValue = ""
            msrp.stringValue = ""
            shipping.stringValue = ""
            overrideShipping.selectItem(at: 0)
            sku.stringValue = ""
            UPCField.stringValue = ""
            let tempItemDescription = result![0].itemDescription
            itemDescriptionField.stringValue = ""
            result![0].itemDescription = tempItemDescription
            let tempBrand = result![0].brand
            brandSelector.stringValue = ""
            result![0].brand = tempBrand
            let tempStyle = result![0].style
            styleSelector.stringValue = ""
            result![0].style = tempStyle
            let tempColor = result![0].color
            colorSelector.stringValue = ""
            result![0].color = tempColor
             let tempSize = result![0].size
            sizeSelector.stringValue = ""
            result![0].size = tempSize
            let tempSleeveStyle = result![0].sleeveStyle
            sleeveStyle.stringValue = ""
            result![0].sleeveStyle = tempSleeveStyle
            let tempSleeveLength = result![0].sleeveLength
            sleeveLength.stringValue = ""
            result![0].sleeveLength = tempSleeveLength
            ebayCategory.stringValue = ""
            storeCategory.stringValue = ""
            sizeType.stringValue = ""
            ebayConditionSelector.selectItem(at: 0)
            }
            try! realm.commitWrite()
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
        colorSelector.removeAllItems()
        styleSelector.removeAllItems()
        brandSelector.removeAllItems()
        sizeSelector.removeAllItems()
        sleeveStyleSelector.removeAllItems()
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
        colorSelector.addItems(withObjectValues: ["", "Beige", "Black", "Blue", "Brown", "Charcoal", "Copper", "Gold", "Gray", "Green", "Multicolored", "Natural", "Navy", "Orange", "Pink", "Purple", "Red", "Silver", "Taupe", "Turquoise", "White", "Wine", "Yellow"])
        styleSelector.addItems(withObjectValues: ["", "Blouse", "Bodysuit", "Cami", "Coat", "Dress", "Gown", "Hoodie", "Jacket", "Jeans", "Jumpsuit", "Legging" ,"Maxi", "Mini", "Overall", "Pants", "Pullover", "Romper", "Shirt", "Shorts", "Skirt", "Sleepwear", "Sweater", "Sweatshirt", "Tank", "Tee", "Top", "Trouser", "T-Shirt", "Tunic", "Vest", "Wrap"])
        brandSelector.addItems(withObjectValues: ["", "7 For All Mankind", "Adriano Goldschmied", "ASTR The Label", "Bar III", "Carbon Copy", "Current Air", "Dee Elle", "Free People", "Ginger by Stella & Ginger", "Guess", "Heartloom", "Hudson", "JOA", "Joe's Jeans", "Kendall + Kylie", "Leyden", "Line & Dot", "Lucky Brand", "Lucy Paris", "Maison Jules", "Moon River", "Nanette Lepore", "Paige", "Project 28","Rachel Roy", "Rachel Zoe", "Sanctuary", "Topson Downs", "Trina Turk", "True Vintage"])
        sizeSelector.addItems(withObjectValues: ["", "XXS", "XS", "S", "M", "L", "XL", "XXL", "3XL", "4XL", "5XL", "6XL", "0", "2", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22"])
        sleeveStyleSelector.addItems(withTitles: ["Short Sleeve", "Long Sleeve", "3/4 Sleeve", "Sleeveless"])
        sleeveLengthSelector.addItems(withTitles: ["", "Short Sleeve", "Long Sleeve", "3/4 Sleeve", "Sleeveless"])

        
    
    
        
        // Select an item at a specific index
        clearimageSelectedPopUpButtons()
        ebayConditionSelector.selectItem(at: 0)
        overrideShipping.selectItem(at: 0)
        //colorSelector.selectItem(at: 0)
        //styleSelector.selectItem(at: 0)
        //brandSelector.selectItem(at: 0)
       // sizeSelector.selectItem(at: 0)
        sleeveStyleSelector.selectItem(at: 0)
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
            weightDisplay.stringValue = ""
            inventoryCount.stringValue = ""
            msrp.stringValue = ""
            shipping.stringValue = ""
            overrideShipping.selectItem(at: 0)
            sku.stringValue = ""
            UPCField.stringValue = ""
            let tempItemDescription = result![0].itemDescription
            itemDescriptionField.stringValue = ""
            result![0].itemDescription = tempItemDescription
            let tempBrand = result![0].brand
            brandSelector.stringValue = ""
            result![0].brand = tempBrand
            let tempStyle = result![0].style
            styleSelector.stringValue = ""
            result![0].style = tempStyle
            let tempColor = result![0].color
            colorSelector.stringValue = ""
            result![0].color = tempColor
             let tempSize = result![0].size
            sizeSelector.stringValue = ""
            result![0].size = tempSize
            let tempSleeveStyle = result![0].sleeveStyle
            sleeveStyle.stringValue = ""
            result![0].sleeveStyle = tempSleeveStyle
            let tempSleeveLength = result![0].sleeveLength
            sleeveLength.stringValue = ""
            result![0].sleeveLength = tempSleeveLength
            ebayCategory.stringValue = ""
            storeCategory.stringValue = ""
            sizeType.stringValue = ""
            ebayConditionSelector.selectItem(at: 0)
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
            overrideShipping.selectItem(at: 0)
            weightDisplay.stringValue = ""
            inventoryCount.stringValue = ""
            msrp.stringValue = ""
            shipping.stringValue = ""
            overrideShipping.selectItem(at: 0)
            sku.stringValue = ""
            UPCField.stringValue = ""
            let tempItemDescription = result![0].itemDescription
            itemDescriptionField.stringValue = ""
            result![0].itemDescription = tempItemDescription
            let tempBrand = result![0].brand
            brandSelector.stringValue = ""
            result![0].brand = tempBrand
            let tempStyle = result![0].style
            styleSelector.stringValue = ""
            result![0].style = tempStyle
            let tempColor = result![0].color
            colorSelector.stringValue = ""
            result![0].color = tempColor
             let tempSize = result![0].size
            sizeSelector.stringValue = ""
            result![0].size = tempSize
            let tempSleeveStyle = result![0].sleeveStyle
            sleeveStyle.stringValue = ""
            result![0].sleeveStyle = tempSleeveStyle
            let tempSleeveLength = result![0].sleeveLength
            sleeveLength.stringValue = ""
            result![0].sleeveLength = tempSleeveLength
            ebayCategory.stringValue = ""
            storeCategory.stringValue = ""
            sizeType.stringValue = ""
            ebayConditionSelector.selectItem(at: 0)
            UPCField.stringValue = "not found"
            UPCField.textColor = NSColor.red
            itemDescriptionField.stringValue = "not found"
            itemDescriptionField.textColor = NSColor.red
            
            

        }
    }
    
    func clearimageSelectedPopUpButtons () {
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
    
    
    func saveImages() {
        
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
            
       // if results?.count != nil {
        if UPCSearchField.stringValue != "" && results?.count != nil && UPCSearchField.stringValue.count == 12 {
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
                    colorSelector.stringValue = String(result![0].color)
             
                    
                    //price.stringValue = String(result![0].price)
                    //shipping.stringValue = String(result![0].shipping)
                    sku.stringValue = String(result![0].sku)
                    brandSelector.stringValue = String(result![0].brand)
                    styleSelector.stringValue = String(result![0].style)
                    colorSelector.stringValue = String(result![0].color)
                    sizeSelector.stringValue = String(result![0].size)
                    image.stringValue = String(result![0].image)
                    msrp.stringValue = String(result![0].msrp)
                    sleeveStyle.stringValue = String(result![0].sleeveStyle)
                    sleeveLength.stringValue = String(result![0].sleeveLength)
                    
                    //ebayCategory.stringValue = String(result![0].ebayCategory)
                    readAndSetEbayCategoryCode()
                               
                    storeCategory.stringValue = String(result![0].storeCategory)
                    setEbayConditionSelectorValue()
                    sizeType.stringValue = String(result![0].sizeType)
                    ovrUPC = String(result![0].upc)
                    shippingTranslateCodeForDisplay()
                    
                    
                    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                    
                    if result![0].style == "Jeans" || result![0].style == "Legging" || result![0].style == "Pants" || result![0].style == "Shorts" || result![0].style == "Skirt" || result![0].style == "Trouser"{
                        hideSleeve()
                    }else{
                        unhideSleeve()
                    }
                    
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
                    UPCField.textColor = NSColor.black
                    itemDescriptionField.textColor = NSColor.black
                    updateimages()
                    inventoryCount.stringValue = String(result![0].inventoryCount)
                    clearimageSelectedPopUpButtons()
                    msrp.stringValue = String(result![0].msrp)
                    price.stringValue = String(result![0].price)
                    sku.stringValue = String(result![0].sku)
                    UPCField.stringValue = String(result![0].upc)
                    itemDescriptionField.stringValue = String(result![0].itemDescription)
                    shippingTranslateCodeForDisplay()
                    brandSelector.stringValue = String(result![0].brand)
                    styleSelector.stringValue = String(result![0].style)
                    colorSelector.stringValue = String(result![0].color)
                    sizeSelector.stringValue = String(result![0].size)
                    sleeveStyle.stringValue = String(result![0].sleeveStyle)
                    sleeveLength.stringValue = String(result![0].sleeveLength)
                    
                    //ebayCategory.stringValue = String(result![0].ebayCategory)
                    readAndSetEbayCategoryCode()
                    
                    storeCategory.stringValue = String(result![0].storeCategory)
       //             sizeType.stringValue = String(result![0].sizeType)
                   setEbayConditionSelectorValue ()
                    
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
                overrideShipping.selectItem(at: 0)
                weightDisplay.stringValue = ""
                inventoryCount.stringValue = ""
                msrp.stringValue = ""
                shipping.stringValue = ""
                overrideShipping.selectItem(at: 0)
                sku.stringValue = ""
                UPCField.stringValue = ""
                let tempItemDescription = result![0].itemDescription
                itemDescriptionField.stringValue = ""
                result![0].itemDescription = tempItemDescription
                let tempBrand = result![0].brand
                brandSelector.stringValue = ""
                result![0].brand = tempBrand
                let tempStyle = result![0].style
                styleSelector.stringValue = ""
                result![0].style = tempStyle
                let tempColor = result![0].color
                colorSelector.stringValue = ""
                result![0].color = tempColor
                 let tempSize = result![0].size
                sizeSelector.stringValue = ""
                result![0].size = tempSize
                let tempSleeveStyle = result![0].sleeveStyle
                sleeveStyle.stringValue = ""
                result![0].sleeveStyle = tempSleeveStyle
                let tempSleeveLength = result![0].sleeveLength
                sleeveLength.stringValue = ""
                result![0].sleeveLength = tempSleeveLength
                ebayCategory.stringValue = ""
                storeCategory.stringValue = ""
                sizeType.stringValue = ""
                ebayConditionSelector.selectItem(at: 0)
                print("error.localizedDescription2")
            }
            
        } else {
            print("error")
//         let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
//            let realm = try! Realm(configuration: config)
//            try! realm.write {
//            setupPopUpButtons()
//            image1.image = nil
//            image2.image = nil
//            image3.image = nil
//            image4.image = nil
//            image5.image = nil
//            image6.image = nil
//            image7.image = nil
//            image8.image = nil
//            image9.image = nil
//            image10.image = nil
//            image11.image = nil
//            image12.image = nil
//            image13.image = nil
//            image14.image = nil
//            image15.image = nil
//            overrideShipping.selectItem(at: 0)
//            weightDisplay.stringValue = ""
//            inventoryCount.stringValue = ""
//            msrp.stringValue = ""
//            shipping.stringValue = ""
//            overrideShipping.selectItem(at: 0)
//            sku.stringValue = ""
//            UPCField.stringValue = ""
//            let tempItemDescription = result![0].itemDescription
//            itemDescriptionField.stringValue = ""
//            result![0].itemDescription = tempItemDescription
//            let tempBrand = result![0].brand
//            brandSelector.stringValue = ""
//            result![0].brand = tempBrand
//            let tempStyle = result![0].style
//            styleSelector.stringValue = ""
//            result![0].style = tempStyle
//            let tempColor = result![0].color
//            colorSelector.stringValue = ""
//            result![0].color = tempColor
//             let tempSize = result![0].size
//            sizeSelector.stringValue = ""
//            result![0].size = tempSize
//            let tempSleeveStyle = result![0].sleeveStyle
//            sleeveStyle.stringValue = ""
//            result![0].sleeveStyle = tempSleeveStyle
//            let tempSleeveLength = result![0].sleeveLength
//            sleeveLength.stringValue = ""
//            result![0].sleeveLength = tempSleeveLength
//            ebayCategory.stringValue = ""
//            storeCategory.stringValue = ""
//            sizeType.stringValue = ""
//            ebayConditionSelector.selectItem(at: 0)
//           //itemDescriptionField.stringValue = "Enter Valid UPC in Search Bar"
//            }
//           // try! realm.commitWrite()
        }

    }
    
    
    @IBAction func sleeveLengthSelected(_ sender: NSPopUpButton) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            
            let previousSleeveLength = result![0].sleeveLength
            
            if sleeveLengthSelector.indexOfSelectedItem == 1 {
                result![0].sleeveLength = "Short Sleeve"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousSleeveLength, with: "Short Sleeve")
                sleeveLength.stringValue = result![0].sleeveLength
                itemDescriptionField.stringValue = result![0].itemDescription
                sleeveLengthSelector.selectItem(at: 0)
                
            }else if sleeveLengthSelector.indexOfSelectedItem == 2 {
                result![0].sleeveLength = "Long Sleeve"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousSleeveLength, with: "Long Sleeve")
                sleeveLength.stringValue = result![0].sleeveLength
                itemDescriptionField.stringValue = result![0].itemDescription
                sleeveLengthSelector.selectItem(at: 0)
                
            }else if sleeveLengthSelector.indexOfSelectedItem == 3 {
                result![0].sleeveLength = "3/4 Sleeve"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousSleeveLength, with: "3/4 Sleeve")
                sleeveLength.stringValue = result![0].sleeveLength
                itemDescriptionField.stringValue = result![0].itemDescription
                sleeveLengthSelector.selectItem(at: 0)
                
            }else if sleeveLengthSelector.indexOfSelectedItem == 4 {
                result![0].sleeveLength = "Sleeveless"
                result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousSleeveLength, with: "Sleeveless")
                sleeveLength.stringValue = result![0].sleeveLength
                itemDescriptionField.stringValue = result![0].itemDescription
                sleeveLengthSelector.selectItem(at: 0)
                
            }
        }
    }
    
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
    
    
    @IBAction func oversizeShipSelected(_ sender: NSPopUpButton) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
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
        result![0].shipping = ecomDashShipCode!
            shippingTranslateCodeForDisplay()
            
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
    
    
    @IBAction func itemDescriptionDidEdit(_ sender: NSTextField) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
               let realm = try! Realm(configuration: config)
               try! realm.write {
               let previousItemDescription = result![0].itemDescription
               result![0].itemDescription = itemDescriptionField.stringValue
               let newItemDescription = itemDescriptionField.stringValue
               result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousItemDescription, with: newItemDescription)
           }
    }
    
    @IBAction func img1Selected(_ sender: NSPopUpButton) {
        saveImages()
    }
    
    @IBAction func img2Selected(_ sender: NSPopUpButton) {
        saveImages()
    }
    
    @IBAction func img3Selected(_ sender: NSPopUpButton) {
        saveImages()
    }
    
    @IBAction func img4Selected(_ sender: NSPopUpButton) {
        saveImages()
    }
    
    @IBAction func img5Selected(_ sender: NSPopUpButton) {
        saveImages()
    }
    
    @IBAction func img6Selected(_ sender: NSPopUpButton) {
        saveImages()
    }
    
    @IBAction func img7Selected(_ sender: NSPopUpButton) {
        saveImages()
    }
    
    @IBAction func img8Selected(_ sender: NSPopUpButton) {
        saveImages()
    }
    
    @IBAction func img9Selected(_ sender: NSPopUpButton) {
        saveImages()
    }
    
    @IBAction func img10Selected(_ sender: NSPopUpButton) {
        saveImages()
    }
    
    @IBAction func img11Selected(_ sender: NSPopUpButton) {
        saveImages()
    }
    
    @IBAction func img12Selected(_ sender: NSPopUpButton) {
        saveImages()
    }
    
    @IBAction func img13Selected(_ sender: NSPopUpButton) {
        saveImages()
    }
    
    @IBAction func img14Selected(_ sender: NSPopUpButton) {
        saveImages()
    }
    
    @IBAction func img15Selected(_ sender: NSPopUpButton) {
        saveImages()
    }
    
    
    @IBAction func ebayConditionSelected(_ sender: NSPopUpButton) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            if ebayConditionSelector.indexOfSelectedItem == 1 {
                result![0].eBayConditionID = 1000
            }else if ebayConditionSelector.indexOfSelectedItem ==  2 {
                result![0].eBayConditionID = 1500
            }else if ebayConditionSelector.indexOfSelectedItem ==  3 {
                result![0].eBayConditionID = 1750
            }
        }
    }
    
    
    
    @IBAction func brandDidSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            let previousBrand = result![0].brand
            result![0].brand = brandSelector.stringValue
            let newBrand = brandSelector.stringValue
            result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousBrand, with: newBrand)
            itemDescriptionField.stringValue = result![0].itemDescription
            self.brandSelector.isEnabled = false
            self.brandSelector.isEnabled = true
        }
        
    }
    
    
    @IBAction func styleDidSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            let previousStyle = result![0].style
            result![0].style = styleSelector.stringValue
            let newStyle = styleSelector.stringValue
            result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStyle, with: newStyle)
            itemDescriptionField.stringValue = result![0].itemDescription
            
            //*********************************************************************************************************
            if styleSelector.indexOfSelectedItem == 1 {
                unhideSleeve()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Blouse"
                result![0].storeCategory = "29010495011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
                
            }else if styleSelector.indexOfSelectedItem == 2 {
                unhideSleeve()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Bodysuit"
                result![0].storeCategory = "29010495011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 3 {
                unhideSleeve()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Cami"
                result![0].storeCategory = "29010495011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 4 {
                unhideSleeve()
                result![0].ebayCategory = "63862"
                ebayCategory.stringValue = "Coat"
                result![0].storeCategory = "1"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 5 {
                unhideSleeve()
                result![0].ebayCategory = "63861"
                ebayCategory.stringValue = "Dress"
                result![0].storeCategory = "28973014011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 6 {
                unhideSleeve()
                result![0].ebayCategory = "63861"
                ebayCategory.stringValue = "Gown"
                result![0].storeCategory = "28973014011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 7 {
                unhideSleeve()
                result![0].ebayCategory = "155226"
                ebayCategory.stringValue = "Hoodie"
                result![0].storeCategory = "1"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 8 {
                unhideSleeve()
                result![0].ebayCategory = "63862"
                ebayCategory.stringValue = "Jacket"
                result![0].storeCategory = "1"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 9 {
                hideSleeve()
                result![0].ebayCategory = "11554"
                ebayCategory.stringValue = "Jeans"
                result![0].storeCategory = "31775381011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 10 {
                unhideSleeve()
                result![0].ebayCategory = "3009"
                ebayCategory.stringValue = "Jumpsuit"
                result![0].storeCategory = "1"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 11 {
                hideSleeve()
                result![0].ebayCategory = "63863"
                ebayCategory.stringValue = "Legging"
                result![0].storeCategory = "31775381011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 12 {
                unhideSleeve()
                result![0].ebayCategory = "63861"
                ebayCategory.stringValue = "Maxi"
                result![0].storeCategory = "28973014011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 13 {
                unhideSleeve()
                result![0].ebayCategory = "63864"
                ebayCategory.stringValue = "Mini"
                result![0].storeCategory = "33096451011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 14 {
                unhideSleeve()
                result![0].ebayCategory = "63863"
                ebayCategory.stringValue = "Overall"
                result![0].storeCategory = "31775381011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 15 {
                hideSleeve()
                result![0].ebayCategory = "63863"
                ebayCategory.stringValue = "Pants"
                result![0].storeCategory = "31775381011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 16 {
                unhideSleeve()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Pullover"
                result![0].storeCategory = "29010495011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 17 {
                unhideSleeve()
                result![0].ebayCategory = "3009"
                ebayCategory.stringValue = "Romper"
                result![0].storeCategory = "1"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 18 {
                unhideSleeve()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Shirt"
                result![0].storeCategory = "29010495011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 19 {
                hideSleeve()
                result![0].ebayCategory = "11555"
                ebayCategory.stringValue = "Shorts"
                result![0].storeCategory = "31775416011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 20 {
                hideSleeve()
                result![0].ebayCategory =  "63864"
                ebayCategory.stringValue = "Skirt"
                result![0].storeCategory = "33096451011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 21 {
                unhideSleeve()
                result![0].ebayCategory = "63855"
                ebayCategory.stringValue = "Sleepwear"
                result![0].storeCategory = "1"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 22 {
                unhideSleeve()
                result![0].ebayCategory = "63866"
                ebayCategory.stringValue = "Sweater"
                result![0].storeCategory = "29010495011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 23 {
                unhideSleeve()
                result![0].ebayCategory = "155226"
                ebayCategory.stringValue = "Sweatshirt"
                result![0].storeCategory = "1"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 24 {
                unhideSleeve()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Tank"
                result![0].storeCategory = "29010495011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 25 {
                unhideSleeve()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Tee"
                result![0].storeCategory = "29010495011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 26 {
                unhideSleeve()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Top"
                result![0].storeCategory = "29010495011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 27 {
                unhideSleeve()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "T-shirt"
                result![0].storeCategory = "29010495011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
                
            }else if styleSelector.indexOfSelectedItem == 28 {
                hideSleeve()
                result![0].ebayCategory = "63863"
                ebayCategory.stringValue = "Trouser"
                result![0].storeCategory = "31775381011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 29 {
                unhideSleeve()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Tunic"
                result![0].storeCategory = "29010495011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 30 {
                unhideSleeve()
                result![0].ebayCategory = "63862"
                ebayCategory.stringValue = "Vest"
                result![0].storeCategory = "1"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
                
            }else if styleSelector.indexOfSelectedItem == 31 {
                unhideSleeve()
                result![0].ebayCategory = "63861"
                ebayCategory.stringValue = "Wrap"
                result![0].storeCategory = "28973014011"
                storeCategory.stringValue = result![0].storeCategory
                self.styleSelector.isEnabled = false
                self.styleSelector.isEnabled = true
            }else{
                return
            }
            
            //*********************************************************************************************************
        }
    }
    
    
    @IBAction func colorDidSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            let previousColor = result![0].color
            result![0].color = colorSelector.stringValue
            let newColor = colorSelector.stringValue
            result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousColor, with: newColor)
            itemDescriptionField.stringValue = result![0].itemDescription
            self.colorSelector.isEnabled = false
            self.colorSelector.isEnabled = true
        }
    }
    
    
    @IBAction func sizeDidSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
               let realm = try! Realm(configuration: config)
               try! realm.write {
                   let previousSize = result![0].size
                   result![0].size = sizeSelector.stringValue
                   let newSize = sizeSelector.stringValue
                   result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousSize, with: newSize)
                   itemDescriptionField.stringValue = result![0].itemDescription
                self.sizeSelector.isEnabled = false
                self.sizeSelector.isEnabled = true
               }
    }
    
    
    @IBAction func priceDidSet(_ sender: NSTextField) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            result![0].price = price.doubleValue
        }
    }
    
    @IBAction func shippingDidSet(_ sender: NSTextField) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            result![0].shipping = shipping.integerValue
        }
    }
    
    
    @IBAction func skuDidset(_ sender: NSTextField) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            result![0].sku = sku.stringValue
        }
    }
    
    @IBAction func sleeveStyleDidSet(_ sender: NSTextField) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            result![0].sleeveStyle = sleeveStyle.stringValue
            self.sleeveStyleSelector.isEnabled = false
            self.sleeveStyleSelector.isEnabled = true
        }
    }
    
    @IBAction func sleeveLengthDIdSet(_ sender: NSTextField) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            result![0].sleeveLength = sleeveLength.stringValue
            self.sleeveLengthSelector.isEnabled = false
            self.sleeveLengthSelector.isEnabled = true
        }
    }
    
    @IBAction func ebayCategoryIDDidSet(_ sender: NSTextField) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            result![0].ebayCategory = ebayCategory.stringValue
        }
    }
    
    @IBAction func storeCategoryDidset(_ sender: NSTextField) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            result![0].storeCategory = storeCategory.stringValue
        }
    }
    
    @IBAction func sizeTypeDidSet(_ sender: NSTextField) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            result![0].sizeType = sizeType.stringValue
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
