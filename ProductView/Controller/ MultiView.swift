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
    var percentageOffMsrp: Float?
 
    var scale = OhausScale()
    
    var prodCountArray: [Int] = []
    var stringArray: [String] = []
    var upcArray: [Int] = []
    
    
    
    
//    let shipCodeFree = 999308
//    let shipCode3_99 = 912391
//    let shipCode4_99 = 1001736
//    let shipCode5_99 = 912401
//    let shipCode6_99 = 851453
//    let shipCode7_99 = 851436
//    let shipCode8_99 = 851450
//    let shipCope9_99 = 912425
//    let shipcode13_99 = 1001772
//    let shipCode18_99 = 851451
//    var ecomDashShipCode: Int?
//
  
    
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
    @IBOutlet weak var noImagesCheckBox: NSButtonCell!
    
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
    @IBOutlet weak var productSelector: NSPopUpButton!
    
     
    @IBOutlet weak var percentageOffMsrpSelector: NSComboBox!
     @IBOutlet weak var sizeTypeSelector: NSPopUpButton!
    @IBOutlet weak var sleeveLengthLabel: NSTextField!
    @IBOutlet weak var styleLabel: NSTextField!
    @IBOutlet weak var necklineLabel: NSTextField!
    @IBOutlet weak var waistLabel: NSTextField!
    @IBOutlet weak var inseamLabel: NSTextField!
    @IBOutlet weak var riseLabel: NSTextField!
    
    @IBOutlet weak var shippingSelector: NSComboBox!
    @IBOutlet weak var brandSelector: NSComboBox!
    @IBOutlet weak var typeSelector: NSComboBox!
    @IBOutlet weak var colorSelector: NSComboBox!
    @IBOutlet weak var sizeSelector: NSComboBox!
    @IBOutlet weak var sleeveLengthSelector: NSComboBox!
    @IBOutlet weak var storeCategorySelector: NSComboBox!
    @IBOutlet weak var styleSelector: NSComboBox!
    @IBOutlet weak var necklineSelector: NSComboBox!
    @IBOutlet weak var materialSelector: NSComboBox!
    @IBOutlet weak var occasionSelector: NSComboBox!
    @IBOutlet weak var patternSelector: NSComboBox!
    @IBOutlet weak var waistSelector: NSComboBox!
    @IBOutlet weak var inseamSelector: NSComboBox!
    @IBOutlet weak var riseSelector: NSComboBox!
    
    @IBOutlet weak var price: NSTextField!
    @IBOutlet weak var sku: NSTextField!

   


    @IBOutlet weak var msrp: NSTextField!
    @IBOutlet weak var ebayCategory: NSTextField!
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
        
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        results = realm.objects(Product.self)
        var prodCount = 0
        if results != nil{
            for _ in results! {
                prodCount = prodCount + 1
                prodCountArray.append(prodCount)
            }
            stringArray = prodCountArray.map { String($0) }
            stringArray.insert("", at: 0)
            //print(stringArray)
        }
        
        hideSleeve()
        hideWaist()
        setupPopUpButtons()
        scale.scaleDelegate = self
        scale.scaleStatusDelegate = self
        _ = scale.scaleBegin()
        counter = 0
        
        
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func shippingCalculator() {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
        print(calculatedOunces!)
    
              
              if calculatedOunces! <= 4{
                  //shipping.stringValue = "3.99"
                shippingSelector.selectItem(at: 1)
                result![0].shipping = 912391
                  
              }else if calculatedOunces! <= 8{
             //     shipping.stringValue = "4.99"
                 shippingSelector.selectItem(at: 2)
                 result![0].shipping = 1001736
                  
              }else if calculatedOunces! <= 12{
             //     shipping.stringValue = "5.99"
                 shippingSelector.selectItem(at: 3)
                 result![0].shipping = 912401
                  
              }else if calculatedOunces! < 16 {
            //       shipping.stringValue = "6.99"
                 shippingSelector.selectItem(at: 4)
                 result![0].shipping = 851453
                   
              }else if calculatedOunces! >= 16 {
           //       shipping.stringValue = "6.99"
                 shippingSelector.selectItem(at: 4)
                 result![0].shipping = 851453
        }
              
//              }else if overrideShipping.selectedItem = 1 {
//                        shipping.stringValue = "7.99"
//                        ecomDashShipCode = shipCode7_99
                    
    }
    }
    
    func hideSleeve() {
        sleeveLengthSelector.isHidden = true
        sleeveLengthLabel.isHidden = true
        styleSelector.isHidden = true
        necklineSelector.isHidden = true
        styleLabel.isHidden = true
        necklineLabel.isHidden = true
        
    }
    
    func unhideSleeve(){
        sleeveLengthSelector.isHidden = false
        sleeveLengthLabel.isHidden = false
        styleSelector.isHidden = false
        necklineSelector.isHidden = false
        styleLabel.isHidden = false
        necklineLabel.isHidden = false
    }
    
    
    func hideWaist(){
        waistSelector.isHidden = true
        waistLabel.isHidden = true
        inseamSelector.isHidden = true
        inseamLabel.isHidden = true
        riseSelector.isHidden = true
        riseLabel.isHidden = true
    }
    
    func unHideWaist(){
        waistSelector.isHidden = false
        waistLabel.isHidden = false
        inseamSelector.isHidden = false
        inseamLabel.isHidden = false
        riseSelector.isHidden = false
        riseLabel.isHidden = false
    }
    
    func readAndSetEbayCategoryCode() {
        if  result![0].ebayCategory == "53159" {
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Blouse"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Bodysuit"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Cami"
            
        }else if result![0].ebayCategory == "63862"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Coat"
            
        }else if result![0].ebayCategory == "63861"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Dress"
            
        }else if result![0].ebayCategory == "63861"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Gown"
            
        }else if result![0].ebayCategory == "155226"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Hoodie"
            
        }else if result![0].ebayCategory == "63862"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Jacket"
            
        }else if result![0].ebayCategory == "11554"{
            hideSleeve()
            unHideWaist()
            ebayCategory.stringValue = "Jeans"
            
        }else if result![0].ebayCategory == "3009"{
            unhideSleeve()
            unHideWaist()
            ebayCategory.stringValue = "Jumpsuit"
            
        }else if result![0].ebayCategory == "63863"{
            hideSleeve()
            unHideWaist()
            ebayCategory.stringValue = "Legging"
            
        }else if result![0].ebayCategory == "63861"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Maxi"
            
        }else if result![0].ebayCategory == "63864"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Mini"
            
        }else if result![0].ebayCategory == "63863"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Overall"
            
        }else if result![0].ebayCategory == "63863"{
            hideSleeve()
            unHideWaist()
            ebayCategory.stringValue = "Pants"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Pullover"
            
        }else if result![0].ebayCategory == "3009"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Romper"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Shirt"
            
        }else if result![0].ebayCategory == "11555"{
            hideSleeve()
            unHideWaist()
            ebayCategory.stringValue = "Shorts"
            
        }else if result![0].ebayCategory == "63864"{
            hideSleeve()
            unHideWaist()
            ebayCategory.stringValue = "Skirt"
            
        }else if result![0].ebayCategory == "63855"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Sleepwear"
            
        }else if result![0].ebayCategory == "63866"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Sweater"
            
        }else if result![0].ebayCategory == "155226"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Sweatshirt"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Tank"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Tee"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Top"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "T-shirt"
            
        }else if result![0].ebayCategory == "63863"{
            hideSleeve()
            unHideWaist()
            ebayCategory.stringValue = "Trouser"
            
        }else if result![0].ebayCategory == "53159"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Tunic"
            
        }else if result![0].ebayCategory == "63862"{
            unhideSleeve()
            hideWaist()
            ebayCategory.stringValue = "Vest"
            
        }else if result![0].ebayCategory == "63861"{
            unhideSleeve()
            hideWaist()
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
    
    func setSizeTypeSelectorValue() {
        if result![0].sizeType == "Juniors" {
            sizeTypeSelector.selectItem(at: 1)
        }else if result![0].sizeType == "Regular" {
            sizeTypeSelector.selectItem(at: 2)
        }else if result![0].sizeType == "Petite" {
            sizeTypeSelector.selectItem(at: 3)
        }else if result![0].sizeType == "Plus" {
            sizeTypeSelector.selectItem(at: 4)
        }else{
            sizeTypeSelector.selectItem(at: 0)
        }
    }
    
    
    
    func shippingTranslateCodeForDisplay() {
        let shippingDisplayValue = result![0].shipping
        if shippingDisplayValue == 912391 {
            shippingSelector.selectItem(at: 1)
            //shipping.stringValue = "3.99"
        }else if shippingDisplayValue == 1001736 {
            shippingSelector.selectItem(at: 2)
            //shipping.stringValue = "4.99"
        }else if shippingDisplayValue == 912401 {
            shippingSelector.selectItem(at: 3)
            //shipping.stringValue = "5.99"
        }else if shippingDisplayValue == 851453{
            shippingSelector.selectItem(at: 4)
            //shipping.stringValue = "6.99"
        }else if shippingDisplayValue == 851436{
            shippingSelector.selectItem(at: 5)
           // shipping.stringValue = "7.99"
        }else if shippingDisplayValue == 851450 {
            shippingSelector.selectItem(at: 6)
            //shipping.stringValue = "8.99"
        }else if shippingDisplayValue == 912425 {
            shippingSelector.selectItem(at: 7)
            //shipping.stringValue = "9.99"
        }else if shippingDisplayValue == 1001772 {
            shippingSelector.selectItem(at: 8)
            //shipping.stringValue = "13.99"
        }else if shippingDisplayValue == 851451{
            shippingSelector.selectItem(at: 9)
            //shipping.stringValue = "18.99"
        }else if shippingDisplayValue == 999308 {
            shippingSelector.selectItem(at: 10)
            //shipping.stringValue = "free"
        }
    }
    
    func storeCategoryTranslateCodeForDisplay() -> String {
           let storeCategoryDisplayValue = result![0].storeCategory
           if storeCategoryDisplayValue == "1" {
              storeCategorySelector.stringValue = "Other"
           }else if storeCategoryDisplayValue == "28973014011" {
               storeCategorySelector.stringValue = "Dresses"
           }else if storeCategoryDisplayValue == "29010495011" {
               storeCategorySelector.stringValue = "Tops"
           }else if storeCategoryDisplayValue == "29074207011" {
               storeCategorySelector.stringValue = "Swimwear"
           }else if storeCategoryDisplayValue == "31775381011" {
               storeCategorySelector.stringValue = "Pants"
           }else if storeCategoryDisplayValue == "31775416011" {
               storeCategorySelector.stringValue = "Shorts"
           }else if storeCategoryDisplayValue == "33096451011" {
               storeCategorySelector.stringValue = "Skirts"
           }else if storeCategoryDisplayValue == "33305264011" {
               storeCategorySelector.stringValue = "Mens Shoes"
           }else if storeCategoryDisplayValue == "33305265011" {
               storeCategorySelector.stringValue = "Womens Shoes"
           }
        return storeCategorySelector.stringValue
       }
    

    func zeroOut() {
        image1.image = nil //
        image2.image = nil //
        image3.image = nil //
        image4.image = nil //
        image5.image = nil //
        image6.image = nil //
        image7.image = nil //
        image8.image = nil //
        image9.image = nil //
        image10.image = nil //
        image11.image = nil //
        image12.image = nil //
        image13.image = nil //
        image14.image = nil //
        image15.image = nil //
        shippingSelector.selectItem(at: 0) //
        weightDisplay.stringValue = "" //
        inventoryCount.stringValue = "" //
        msrp.stringValue = "" //
        price.stringValue = "" //
        sku.stringValue = "" //
        UPCField.stringValue = "" //
        let tempItemDescription = result![0].itemDescription //
        itemDescriptionField.stringValue = "" //
        result![0].itemDescription = tempItemDescription //
        let tempBrand = result![0].brand //
        brandSelector.stringValue = "" //
        result![0].brand = tempBrand //
        let tempType = result![0].type //
        typeSelector.stringValue = "" //
        result![0].type = tempType //
        let tempColor = result![0].color //
        colorSelector.stringValue = "" //
        result![0].color = tempColor //
         let tempSize = result![0].size //
        sizeSelector.stringValue = "" //
        result![0].size = tempSize //
        let tempSleeveLength = result![0].sleeveLength //
        sleeveLengthSelector.stringValue = "" //
        result![0].sleeveLength = tempSleeveLength //
        ebayCategory.stringValue = "" //
        storeCategorySelector.selectItem(at: 0) //
        sizeTypeSelector.selectItem(at: 0) //
        ebayConditionSelector.selectItem(at: 0) //
        styleSelector.selectItem(at: 0)
        necklineSelector.selectItem(at: 0)
        materialSelector.selectItem(at: 0)
        occasionSelector.selectItem(at: 0)
        patternSelector.selectItem(at: 0)
        waistSelector.selectItem(at: 0)
        inseamSelector.selectItem(at: 0)
        riseSelector.selectItem(at: 0)
        image.stringValue = "" //
        imageOverride1TxtField.stringValue = "" //
        imageOverride2TxtField.stringValue = "" //
    }
    
    
    func zeroOutSearch() {
        image1.image = nil //
        image2.image = nil //
        image3.image = nil //
        image4.image = nil //
        image5.image = nil //
        image6.image = nil //
        image7.image = nil //
        image8.image = nil //
        image9.image = nil //
        image10.image = nil //
        image11.image = nil //
        image12.image = nil //
        image13.image = nil //
        image14.image = nil //
        image15.image = nil //
        shippingSelector.selectItem(at: 0) //
        weightDisplay.stringValue = "" //
        inventoryCount.stringValue = "" //
        msrp.stringValue = "" //
        price.stringValue = "" //
        sku.stringValue = "" //
        UPCField.stringValue = "" //

        itemDescriptionField.stringValue = "" //
        brandSelector.selectItem(at: 0) //
        typeSelector.selectItem(at: 0) //
        colorSelector.selectItem(at: 0) //
        sizeSelector.selectItem(at: 0) //
        sleeveLengthSelector.selectItem(at: 0)//
        ebayCategory.stringValue = "" //
        storeCategorySelector.selectItem(at: 0) //
        sizeTypeSelector.selectItem(at: 0) //
        ebayConditionSelector.selectItem(at: 0) //
        styleSelector.selectItem(at: 0)
        necklineSelector.selectItem(at: 0)
        materialSelector.selectItem(at: 0)
        occasionSelector.selectItem(at: 0)
        patternSelector.selectItem(at: 0)
        waistSelector.selectItem(at: 0)
        inseamSelector.selectItem(at: 0)
        riseSelector.selectItem(at: 0)
        image.stringValue = "" //
        imageOverride1TxtField.stringValue = "" //
        imageOverride2TxtField.stringValue = "" //
    }
    
    @IBAction func reviewMode(_ sender: NSButtonCell) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
        if sender.state == .on{
        print("on")
            reviewModeState = "on"
            zeroOut()
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
//            shippingSelector.selectItem(at: 0)
//            weightDisplay.stringValue = ""
//            inventoryCount.stringValue = ""
//            msrp.stringValue = ""
//            price.stringValue = ""
//            sku.stringValue = ""
//            UPCField.stringValue = ""
//            let tempItemDescription = result![0].itemDescription
//            itemDescriptionField.stringValue = ""
//            result![0].itemDescription = tempItemDescription
//            let tempBrand = result![0].brand
//            brandSelector.stringValue = ""
//            result![0].brand = tempBrand
//            let tempType = result![0].type
//            typeSelector.stringValue = ""
//            result![0].type = tempType
//            let tempColor = result![0].color
//            colorSelector.stringValue = ""
//            result![0].color = tempColor
//             let tempSize = result![0].size
//            sizeSelector.stringValue = ""
//            result![0].size = tempSize
//            let tempSleeveStyle = result![0].sleeveStyle
//            result![0].sleeveStyle = tempSleeveStyle
//            let tempSleeveLength = result![0].sleeveLength
//            sleeveLengthSelector.stringValue = ""
//            result![0].sleeveLength = tempSleeveLength
//            ebayCategory.stringValue = ""
//            storeCategorySelector.stringValue = ""
//            sizeTypeSelector.selectItem(at: 0)
//            ebayConditionSelector.selectItem(at: 0)
            
            SearchBar(self)
            
        }else{
            
            print("off")
            reviewModeState = "off"
            zeroOut()
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
//            shippingSelector.selectItem(at: 0)
//            weightDisplay.stringValue = ""
//            inventoryCount.stringValue = ""
//            msrp.stringValue = ""
//            price.stringValue = ""
//            shippingSelector.selectItem(at: 0)
//            sku.stringValue = ""
//            UPCField.stringValue = ""
//            let tempItemDescription = result![0].itemDescription
//            itemDescriptionField.stringValue = ""
//            result![0].itemDescription = tempItemDescription
//            let tempBrand = result![0].brand
//            brandSelector.stringValue = ""
//            result![0].brand = tempBrand
//            let tempType = result![0].type
//            typeSelector.stringValue = ""
//            result![0].type = tempType
//            let tempColor = result![0].color
//            colorSelector.stringValue = ""
//            result![0].color = tempColor
//             let tempSize = result![0].size
//            sizeSelector.stringValue = ""
//            result![0].size = tempSize
//            let tempSleeveStyle = result![0].sleeveStyle
//            result![0].sleeveStyle = tempSleeveStyle
//            let tempSleeveLength = result![0].sleeveLength
//            sleeveLengthSelector.stringValue = ""
//            result![0].sleeveLength = tempSleeveLength
//            ebayCategory.stringValue = ""
//            storeCategorySelector.stringValue = ""
//            sizeTypeSelector.selectItem(at: 0)
//            ebayConditionSelector.selectItem(at: 0)
            
            SearchBar(self)
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
        percentageOffMsrpSelector.removeAllItems()
        shippingSelector.removeAllItems()
        colorSelector.removeAllItems()
        typeSelector.removeAllItems()
        brandSelector.removeAllItems()
        sizeSelector.removeAllItems()
        sleeveLengthSelector.removeAllItems()
        storeCategorySelector.removeAllItems()
        sizeTypeSelector.removeAllItems()
        styleSelector.removeAllItems()
        necklineSelector.removeAllItems()
        materialSelector.removeAllItems()
        occasionSelector.removeAllItems()
        patternSelector.removeAllItems()
        waistSelector.removeAllItems()
        inseamSelector.removeAllItems()
        riseSelector.removeAllItems()
        productSelector.removeAllItems()
        
        
    
        
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
        percentageOffMsrpSelector.addItems(withObjectValues: ["", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%"])
        shippingSelector.addItems(withObjectValues: ["", "3.99", "4.99", "5.99", "6.99", "7.99", "8.99", "9.99", "13.99", "18.99", "Free"])
        colorSelector.addItems(withObjectValues: ["", "Beige", "Black", "Blue", "Brown", "Charcoal", "Copper", "Gold", "Gray", "Green", "Multicolored", "Natural", "Navy", "Orange", "Pink", "Purple", "Red", "Silver", "Taupe", "Turquoise", "White", "Wine", "Yellow"])
        typeSelector.addItems(withObjectValues: ["", "Blouse", "Bodysuit", "Cami", "Coat", "Dress", "Gown", "Hoodie", "Jacket", "Jeans", "Jumpsuit", "Legging" ,"Maxi", "Mini", "Overall", "Pants", "Pullover", "Romper", "Shirt", "Shorts", "Skirt", "Sleepwear", "Sweater", "Sweatshirt", "Tank", "Tee", "Top", "Trouser", "T-Shirt", "Tunic", "Vest", "Wrap"])
        brandSelector.addItems(withObjectValues: ["", "7 For All Mankind", "Adriano Goldschmied", "ASTR The Label", "Bar III", "Carbon Copy", "Current Air", "Dee Elle", "Free People", "Ginger by Stella & Ginger", "Guess", "Heartloom", "Hudson", "JOA", "Joe's Jeans", "Kendall + Kylie", "Leyden", "Line & Dot", "Lucky Brand", "Lucy Paris", "Maison Jules", "Moon River", "Nanette Lepore", "Paige", "Project 28","Rachel Roy", "Rachel Zoe", "Sanctuary", "Topson Downs", "Trina Turk", "True Vintage"])
        sizeSelector.addItems(withObjectValues: ["", "XXS", "XS", "S", "M", "L", "XL", "XXL", "3XL", "4XL", "5XL", "6XL", "0", "2", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22"])
        sleeveLengthSelector.addItems(withObjectValues: ["", "Short Sleeve", "Long Sleeve", "3/4 Sleeve", "Sleeveless"])
        storeCategorySelector.addItems(withObjectValues: ["", "Dresses", "Other", "Pants", "Shorts", "Skirts", "Swimwear", "Tops", "Mens Shoes", "Womens Shoes"])
        sizeTypeSelector.addItems(withTitles: ["", "Juniors", "Regular", "Petite", "Plus"])
        styleSelector.addItems(withObjectValues: ["", "Basic", "Camisole", "Cropped", "Jersey", "Kimono", "Ringer", "Tunic"])
        necklineSelector.addItems(withObjectValues: ["", "Boat Neck", "Collared","Cowl Neck", "Crew Neck", "Halter", "Henley", "High Neck", "Mock Neck", "Off the Shoulder", "One Shoulder", "Round Neck", "Scoop Neck", "Square Neck", "Sweetheart", "Turtleneck", "V-Neck"])
        materialSelector.addItems(withObjectValues: ["", "Polyester", "Cotton", "Nylon", "Acetate", "Alfa", "Alginate", "Alpaca", "Angora", "Animal Hair", "Aramid", "Bamboo", "Camel", "Cashgora", "Cashmere", "Chlorofiber", "Coir", "Cupro", "Elastodiene", "Elastolefin", "Elastomultiester", "Faux Fur", "Faux Leather", "Flax", "Fluorofiber", "Fur", "Guanaco", "Hemp", "Henequen", "Jute", "Kapok", "Leather", "Linen", "Llama", "Lyocell", "Maguey", "Manila Hemp", "Modacrylic", "Modal", "Mohair", "Patent Leather", "Polyacrylate Fiber", "Polyamide", "Polycarbamide", "Polyethylene", "Polyimide", "Polylactide", "Polypropylene", "Polyurethane", "Ramie", "Silk", "Sisal", "Spandex", "Suede", "Sunn", "Tiacetate", "Trivinyl", "Vicuna", "Viscose", "Wool", "Yak"])
        occasionSelector.addItems(withObjectValues: ["", "Casual", "Business", "Formal", "Party/Cocktail", "Travel", "Wedding", "Workwear"])
        patternSelector.addItems(withObjectValues: ["", "Solid", "Floral", "Striped", "Polka Dot", "Geometric", "Argyle/Diamond", "Camouflage", "Check", "Colorblock", "Fair Isle", "Herringbone", "Paisley", "Plaid"])
        waistSelector.addItems(withObjectValues: ["", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20" ])
        inseamSelector.addItems(withObjectValues: ["", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"])
        riseSelector.addItems(withObjectValues: ["", "Ultra Low", "Low", "Mid", "High"])
        productSelector.addItems(withTitles: stringArray)
        
    
        
        // Select an item at a specific index
        clearimageSelectedPopUpButtons()
        ebayConditionSelector.selectItem(at: 0)
        //shippingSelector.selectItem(at: 0)
        //colorSelector.selectItem(at: 0)
        //styleSelector.selectItem(at: 0)
        //brandSelector.selectItem(at: 0)
       // sizeSelector.selectItem(at: 0)
        //sleeveStyleSelector.selectItem(at: 0)
        //sleeveLengthSelector.selectItem(at: 0)
        sizeTypeSelector.selectItem(at: 0)
        
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
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
        if sender.state == .on{
        inventoryCheckInModeState =  "on"
              zeroOut()
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
//            shippingSelector.selectItem(at: 0)
//            weightDisplay.stringValue = ""
//            inventoryCount.stringValue = ""
//            msrp.stringValue = ""
//            price.stringValue = ""
//            sku.stringValue = ""
//            UPCField.stringValue = ""
//            let tempItemDescription = result![0].itemDescription
//            itemDescriptionField.stringValue = ""
//            result![0].itemDescription = tempItemDescription
//            let tempBrand = result![0].brand
//            brandSelector.selectItem(at: 0)
//            result![0].brand = tempBrand
//            let tempType = result![0].type
//            typeSelector.stringValue = ""
//            result![0].type = tempType
//            let tempColor = result![0].color
//            colorSelector.stringValue = ""
//            result![0].color = tempColor
//             let tempSize = result![0].size
//            sizeSelector.stringValue = ""
//            result![0].size = tempSize
//            let tempSleeveStyle = result![0].sleeveStyle
//            result![0].sleeveStyle = tempSleeveStyle
//            let tempSleeveLength = result![0].sleeveLength
//            sleeveLengthSelector.stringValue = ""
//            result![0].sleeveLength = tempSleeveLength
//            ebayCategory.stringValue = ""
//            storeCategorySelector.stringValue = ""
//            sizeTypeSelector.stringValue = ""
//            ebayConditionSelector.selectItem(at: 0)
//
        qtyReceived.stringValue = "1"
            qtyReceived.backgroundColor = NSColor.yellow
             SearchBar(self)
        }else{
             qtyReceived.backgroundColor = NSColor.white
            qtyReceived.stringValue = ""
            weightDisplay.stringValue = ""
            
            
            setupPopUpButtons()
              zeroOut()
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
//            weightDisplay.stringValue = ""
//            inventoryCount.stringValue = ""
//            msrp.stringValue = ""
//            shippingSelector.selectItem(at: 0)
//            sku.stringValue = ""
//            UPCField.stringValue = ""
//            let tempItemDescription = result![0].itemDescription
//            itemDescriptionField.stringValue = ""
//            result![0].itemDescription = tempItemDescription
//            let tempBrand = result![0].brand
//            brandSelector.selectItem(at: 0)
//            result![0].brand = tempBrand
//            let tempType = result![0].type
//            typeSelector.stringValue = ""
//            result![0].type = tempType
//            let tempColor = result![0].color
//            colorSelector.stringValue = ""
//            result![0].color = tempColor
//             let tempSize = result![0].size
//            sizeSelector.stringValue = ""
//            result![0].size = tempSize
//            let tempSleeveStyle = result![0].sleeveStyle
//            result![0].sleeveStyle = tempSleeveStyle
//            let tempSleeveLength = result![0].sleeveLength
//            sleeveLengthSelector.stringValue = ""
//            result![0].sleeveLength = tempSleeveLength
//            ebayCategory.stringValue = ""
//            storeCategorySelector.stringValue = ""
//            sizeTypeSelector.stringValue = ""
//            ebayConditionSelector.selectItem(at: 0)
            
            UPCField.stringValue = "not found"
            UPCField.textColor = NSColor.red
            itemDescriptionField.stringValue = "not found"
            itemDescriptionField.textColor = NSColor.red
            
            }

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
    
    func splitAtFirst(str: String, delimiter: String) -> (String)? {
        guard let upperIndex = (str.range(of: delimiter)?.upperBound), let _ = (str.range(of: delimiter)?.lowerBound) else { return nil }
       //let firstPart: String = .init(str.prefix(upTo: lowerIndex))
       let lastPart: String = .init(str.suffix(from: upperIndex))
       return (lastPart)
    }

    
    @IBAction func SearchBar(_ sender: Any) {
        arrayOfURLs = []
        hdArrayOfURLs = []
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        results = realm.objects(Product.self)
        let imageCode: Int?
       
   
        if UPCSearchField.stringValue.count != 12 {
            print("clear all fields placeholder code")
            setupPopUpButtons()
            zeroOutSearch()
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
//            inventoryCount.stringValue = ""
//            msrp.stringValue = ""
//            percentageOffMsrpSelector.selectItem(at: 0)
//            price.stringValue = ""
//            shippingSelector.selectItem(at: 0)
//            sku.stringValue = ""
//            UPCField.stringValue = ""
//            itemDescriptionField.stringValue = ""
//            brandSelector.selectItem(at: 0)
//            typeSelector.selectItem(at: 0)
//            colorSelector.selectItem(at: 0)
//            sizeSelector.selectItem(at: 0)
//            sleeveLengthSelector.selectItem(at: 0)
//            ebayCategory.stringValue = ""
//            storeCategorySelector.selectItem(at: 0)
//            sizeTypeSelector.selectItem(at: 0)
//            ebayConditionSelector.selectItem(at: 0)
//            image.stringValue = ""
            
            
            
        } else {



      
          if UPCSearchField.stringValue != "" && results?.count != nil && UPCSearchField.stringValue.count == 12 {
            searchString = UPCSearchField!.integerValue
           // print("Search String \(searchString)")
            let predicate = NSPredicate(format: "upc == %@", NSNumber (value: searchString))
            result = results!.filter(predicate)
            print("result: \(String(describing: result))")
            print("result count \(result!.count)")
            if (result?.count)! == 1 {
                
                if result![0].code != "" {
               // let imageCode = Int(result![0].code)
                    imageCode = Int(result![0].code)
                HRimageCode = Int(result![0].code)
                print(result![0].image)
                }else{
                   // let imageCode: Int?
                    imageCode = 00000000
                    
                }
            
                
            
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
                    }
              
                    
    
                

                if reviewModeState == "off" {
                    
                    UPCField.textColor = NSColor.black
                    itemDescriptionField.textColor = NSColor.black
                    setupPopUpButtons()
                    imageOverride1TxtField.stringValue = ""
                    imageOverride2TxtField.stringValue = ""
                    weightDisplay.stringValue = ""
                    price.stringValue = ""
                    noImagesCheckBox.state = NSControl.StateValue.off
                    if (result![0].imageSlot1) == "******************************" {
                        noImagesCheckBox.state = NSControl.StateValue.on
                    }
                    UPCField.stringValue = String(result![0].upc)
                    OriginalQty.stringValue = String(result![0].originalQty)
                    inventoryCount.stringValue = String(result![0].inventoryCount)
                    itemDescriptionField.stringValue = result![0].itemDescription
                    colorSelector.stringValue = String(result![0].color)
                    sku.stringValue = String(result![0].sku)
                    brandSelector.stringValue = String(result![0].brand)
                    typeSelector.stringValue = String(result![0].type)
                    colorSelector.stringValue = String(result![0].color)
                    sizeSelector.stringValue = String(result![0].size)
                    image.stringValue = String(result![0].image)
                    msrp.stringValue = String(result![0].msrp)
                    price.stringValue = result![0].price
                    sleeveLengthSelector.stringValue = String(result![0].sleeveLength)
                    styleSelector.stringValue = String(result![0].style)
                    necklineSelector.stringValue = String(result![0].neckline)
                    materialSelector.stringValue = String(result![0].material)
                    occasionSelector.stringValue = String(result![0].occasion)
                    patternSelector.stringValue = String(result![0].pattern)
                    waistSelector.stringValue = String(result![0].waist)
                    inseamSelector.stringValue = String(result![0].inseam)
                    riseSelector.stringValue = String(result![0].rise)
                    
                    
                    let str = String(result![0].sku)
                    let rowNum = Int(splitAtFirst(str: str, delimiter: "_")!)
                    //print(rowNum)
                    productSelector.selectItem(at: rowNum!)
                    
                    
                    
                    
                    
                    readAndSetEbayCategoryCode()
                    _ = storeCategoryTranslateCodeForDisplay()
                    setEbayConditionSelectorValue()
                    setSizeTypeSelectorValue()
                    ovrUPC = String(result![0].upc)
                    shippingTranslateCodeForDisplay()
            
                
                    
                    if result![0].type == "Jeans" || result![0].type == "Legging" || result![0].type == "Pants" || result![0].type == "Shorts" || result![0].type == "Skirt" || result![0].type == "Trouser"{
                        hideSleeve()
                        unHideWaist()
                    }else{
                        unhideSleeve()
                        hideWaist()
                    }
                    
                    
                    if result![0].image == "" {
                        return
                    } else {
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
                            //print(url1)
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
                    }
                    
                    
                    
                } else {
                    //******** ReviewModeSate is ON *********
                    print("review mode on")
                    UPCField.textColor = NSColor.black
                    itemDescriptionField.textColor = NSColor.black
                    updateimages()
                    noImagesCheckBox.state = NSControl.StateValue.off
                    if (result![0].imageSlot1) == "******************************" {
                        noImagesCheckBox.state = NSControl.StateValue.on
                    }
                    
                    inventoryCount.stringValue = String(result![0].inventoryCount)
                    clearimageSelectedPopUpButtons()
                    msrp.stringValue = String(result![0].msrp)
                    price.stringValue = String(result![0].price)
                    sku.stringValue = String(result![0].sku)
                    UPCField.stringValue = String(result![0].upc)
                    itemDescriptionField.stringValue = String(result![0].itemDescription)
                    shippingTranslateCodeForDisplay()
                    brandSelector.stringValue = String(result![0].brand)
                    typeSelector.stringValue = String(result![0].type)
                    colorSelector.stringValue = String(result![0].color)
                    sizeSelector.stringValue = String(result![0].size)
                    sleeveLengthSelector.stringValue = String(result![0].sleeveLength)
                    styleSelector.stringValue = String(result![0].style)
                    necklineSelector.stringValue = String(result![0].neckline)
                    materialSelector.stringValue = String(result![0].material)
                    occasionSelector.stringValue = String(result![0].occasion)
                    patternSelector.stringValue = String(result![0].pattern)
                    waistSelector.stringValue = String(result![0].waist)
                    inseamSelector.stringValue = String(result![0].inseam)
                    riseSelector.stringValue = String(result![0].rise)
                    readAndSetEbayCategoryCode()
                    _ = storeCategoryTranslateCodeForDisplay()
                    setSizeTypeSelectorValue()
                    setEbayConditionSelectorValue ()
                    
                }

            } else {
 print("error.localizedDescription2")
                setupPopUpButtons()
                zeroOutSearch()
//                image1.image = nil
//                image2.image = nil
//                image3.image = nil
//                image4.image = nil
//                image5.image = nil
//                image6.image = nil
//                image7.image = nil
//                image8.image = nil
//                image9.image = nil
//                image10.image = nil
//                image11.image = nil
//                image12.image = nil
//                image13.image = nil
//                image14.image = nil
//                image15.image = nil
//                weightDisplay.stringValue = ""
//                inventoryCount.stringValue = ""
//                msrp.stringValue = ""
//                price.doubleValue = 0
//                shippingSelector.selectItem(at: 0)
//                sku.stringValue = ""
//                UPCField.stringValue = ""
//                itemDescriptionField.textColor = .red
//                itemDescriptionField.stringValue = "not found"
//                brandSelector.stringValue = ""
//                typeSelector.stringValue = ""
//                colorSelector.stringValue = ""
//                sizeSelector.stringValue = ""
//                sleeveLengthSelector.stringValue = ""
//                ebayCategory.stringValue = ""
//                storeCategorySelector.stringValue = ""
//                sizeTypeSelector.stringValue = ""
//                ebayConditionSelector.selectItem(at: 0)
               
            
            }

        } else {
            print("error")

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
        }
    }
    
    
    @IBAction func updateImages(_ sender: NSButton) {
        updateimages()
    }
    
    func updateimages(){
        //let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        //let realm = try! Realm(configuration: config)
       //  try! realm.write {
            
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
        let vc = segue.destinationController as! OverrideIMG
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
    
    
    @IBAction func typeDidSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            let previousType = result![0].type
            result![0].type = typeSelector.stringValue
            let newType = typeSelector.stringValue
            result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousType, with: newType)
            itemDescriptionField.stringValue = result![0].itemDescription
            
            //*********************************************************************************************************
            if typeSelector.indexOfSelectedItem == 1 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Blouse"
                result![0].storeCategory = "29010495011"
                storeCategorySelector.stringValue = "Tops"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
                
            }else if typeSelector.indexOfSelectedItem == 2 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Bodysuit"
                result![0].storeCategory = "29010495011"
                storeCategorySelector.stringValue = "Tops"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 3 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Cami"
                result![0].storeCategory = "29010495011"
                storeCategorySelector.stringValue = "Tops"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 4 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "63862"
                ebayCategory.stringValue = "Coat"
                result![0].storeCategory = "1"
                storeCategorySelector.stringValue = "Other"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 5 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "63861"
                ebayCategory.stringValue = "Dress"
                result![0].storeCategory = "28973014011"
                storeCategorySelector.stringValue = "Dresses"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 6 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "63861"
                ebayCategory.stringValue = "Gown"
                result![0].storeCategory = "28973014011"
                storeCategorySelector.stringValue = "Dresses"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 7 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "155226"
                ebayCategory.stringValue = "Hoodie"
                result![0].storeCategory = "1"
                storeCategorySelector.stringValue = "Other"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 8 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "63862"
                ebayCategory.stringValue = "Jacket"
                result![0].storeCategory = "1"
                storeCategorySelector.stringValue = "Other"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 9 {
                hideSleeve()
                unHideWaist()
                result![0].ebayCategory = "11554"
                ebayCategory.stringValue = "Jeans"
                result![0].storeCategory = "31775381011"
                storeCategorySelector.stringValue = "Other"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 10 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "3009"
                ebayCategory.stringValue = "Jumpsuit"
                result![0].storeCategory = "1"
                storeCategorySelector.stringValue = "Other"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 11 {
                hideSleeve()
                unHideWaist()
                result![0].ebayCategory = "63863"
                ebayCategory.stringValue = "Legging"
                result![0].storeCategory = "31775381011"
                storeCategorySelector.stringValue = "Pants"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 12 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "63861"
                ebayCategory.stringValue = "Maxi"
                result![0].storeCategory = "28973014011"
                storeCategorySelector.stringValue = "Dresses"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 13 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "63864"
                ebayCategory.stringValue = "Mini"
                result![0].storeCategory = "33096451011"
                storeCategorySelector.stringValue = "Dresses"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 14 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "63863"
                ebayCategory.stringValue = "Overall"
                result![0].storeCategory = "31775381011"
                storeCategorySelector.stringValue = "Pants"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 15 {
                hideSleeve()
                unHideWaist()
                result![0].ebayCategory = "63863"
                ebayCategory.stringValue = "Pants"
                result![0].storeCategory = "31775381011"
                storeCategorySelector.stringValue = "Pants"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 16 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Pullover"
                result![0].storeCategory = "29010495011"
                storeCategorySelector.stringValue = "Tops"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 17 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "3009"
                ebayCategory.stringValue = "Romper"
                result![0].storeCategory = "1"
                storeCategorySelector.stringValue = "Other"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 18 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Shirt"
                result![0].storeCategory = "29010495011"
                storeCategorySelector.stringValue = "Tops"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 19 {
                hideSleeve()
                unHideWaist()
                result![0].ebayCategory = "11555"
                ebayCategory.stringValue = "Shorts"
                result![0].storeCategory = "31775416011"
                storeCategorySelector.stringValue = "Shorts"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 20 {
                hideSleeve()
                unHideWaist()
                result![0].ebayCategory =  "63864"
                ebayCategory.stringValue = "Skirt"
                result![0].storeCategory = "33096451011"
                storeCategorySelector.stringValue = "Skirts"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 21 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "63855"
                ebayCategory.stringValue = "Sleepwear"
                result![0].storeCategory = "1"
                storeCategorySelector.stringValue = "Other"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 22 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "63866"
                ebayCategory.stringValue = "Sweater"
                result![0].storeCategory = "29010495011"
                storeCategorySelector.stringValue = "Tops"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 23 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "155226"
                ebayCategory.stringValue = "Sweatshirt"
                result![0].storeCategory = "1"
                storeCategorySelector.stringValue = "Other"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 24 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Tank"
                result![0].storeCategory = "29010495011"
                storeCategorySelector.stringValue = "Tops"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 25 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Tee"
                result![0].storeCategory = "29010495011"
                storeCategorySelector.stringValue = "Tops"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 26 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Top"
                result![0].storeCategory = "29010495011"
                storeCategorySelector.stringValue = "Tops"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 27 {
                hideSleeve()
                unHideWaist()
                result![0].ebayCategory = "63863"
                ebayCategory.stringValue = "Trouser"
                result![0].storeCategory = "31775381011"
                storeCategorySelector.stringValue = "Pants"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
            
            }else if typeSelector.indexOfSelectedItem == 28 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "T-shirt"
                result![0].storeCategory = "29010495011"
                storeCategorySelector.stringValue = "Tops"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 29 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "53159"
                ebayCategory.stringValue = "Tunic"
                result![0].storeCategory = "29010495011"
                storeCategorySelector.stringValue = "Tops"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 30 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "63862"
                ebayCategory.stringValue = "Vest"
                result![0].storeCategory = "1"
                storeCategorySelector.stringValue = "Other"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
                
            }else if typeSelector.indexOfSelectedItem == 31 {
                unhideSleeve()
                hideWaist()
                result![0].ebayCategory = "63861"
                ebayCategory.stringValue = "Wrap"
                result![0].storeCategory = "Dresses"
                storeCategorySelector.stringValue = "Dresses"
                self.typeSelector.isEnabled = false
                self.typeSelector.isEnabled = true
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
    
    @IBAction func percentageOffMsrpDidSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            if percentageOffMsrpSelector.indexOfSelectedItem == 1 {
                percentageOffMsrp = 0.1
            }else if percentageOffMsrpSelector.indexOfSelectedItem == 2 {
                percentageOffMsrp = 0.2
            }else if percentageOffMsrpSelector.indexOfSelectedItem == 3 {
                percentageOffMsrp = 0.3
            }else if percentageOffMsrpSelector.indexOfSelectedItem == 4 {
                percentageOffMsrp = 0.4
            }else if percentageOffMsrpSelector.indexOfSelectedItem == 5 {
                percentageOffMsrp = 0.5
            }else if percentageOffMsrpSelector.indexOfSelectedItem == 6 {
                percentageOffMsrp = 0.6
            }else if percentageOffMsrpSelector.indexOfSelectedItem == 7 {
                percentageOffMsrp = 0.7
            }else if percentageOffMsrpSelector.indexOfSelectedItem == 8 {
                percentageOffMsrp = 0.8
            }else if percentageOffMsrpSelector.indexOfSelectedItem == 9 {
                percentageOffMsrp = 0.9
            }
            print(result![0].msrp)
            //let trimDollarSignMsrp = result![0].msrp.dropFirst(1)
            let msrpValue = Float(result![0].msrp)
            print(msrpValue!)
            var discountedPrice = msrpValue! - (percentageOffMsrp! * msrpValue!)
            print(discountedPrice.rounded())
            discountedPrice = (discountedPrice * 100).rounded() / 100
            print("discount price: \(discountedPrice)")
            let twoDecimalPlaces = String(format: "%.2f", discountedPrice)
            result![0].price = twoDecimalPlaces
            price.stringValue = result![0].price
            percentageOffMsrpSelector.selectItem(at: 0)
            self.percentageOffMsrpSelector.isEnabled = false
            self.percentageOffMsrpSelector.isEnabled = true
        }
    }
    
    @IBAction func priceDidSet(_ sender: NSTextField) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            result![0].price = price.stringValue
        }
    }
    
    @IBAction func shippingDidSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            //           let previousShipping = String(result![0].shipping)
            //            let newShipping = String(shippingSelector.integerValue)
            if shippingSelector.indexOfSelectedItem == 1 {
                result![0].shipping = 912391
            }else if shippingSelector.indexOfSelectedItem == 2 {
                result![0].shipping = 1001736
            }else if shippingSelector.indexOfSelectedItem == 3 {
                result![0].shipping = 912401
            }else if shippingSelector.indexOfSelectedItem == 4 {
                result![0].shipping = 851453
            }else if shippingSelector.indexOfSelectedItem == 5 {
                result![0].shipping = 851436
            }else if shippingSelector.indexOfSelectedItem == 6 {
                result![0].shipping = 851450
            }else if shippingSelector.indexOfSelectedItem == 7 {
                result![0].shipping = 912425
            }else if shippingSelector.indexOfSelectedItem == 8 {
                result![0].shipping = 1001772
            }else if shippingSelector.indexOfSelectedItem == 9 {
                result![0].shipping = 851451
            }else if shippingSelector.indexOfSelectedItem == 10 {
                result![0].shipping = 999308
            }
            self.shippingSelector.isEnabled = false
            self.shippingSelector.isEnabled = true
        }
    }
    
    
    @IBAction func skuDidset(_ sender: NSTextField) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            result![0].sku = sku.stringValue
        }
    }
    
    
    
    @IBAction func sleeveLengthDidSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            
            let previousSleeveLength = result![0].sleeveLength
            result![0].sleeveLength = sleeveLengthSelector.stringValue
            let newSleeveLength = sleeveLengthSelector.stringValue
            result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousSleeveLength, with: newSleeveLength)
            itemDescriptionField.stringValue = result![0].itemDescription
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
    
    @IBAction func storeCategoryDidset(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            var previousStoreCategory: String?
            let savedStoreCategory = result![0].storeCategory
            if savedStoreCategory == "1" {
                previousStoreCategory = "Other"
            }else if savedStoreCategory == "28973014011" {
                previousStoreCategory = "Dresses"
            }else if savedStoreCategory == "29010495011" {
                previousStoreCategory = "Tops"
            }else if savedStoreCategory == "29074207011" {
                previousStoreCategory = "Swimwear"
            }else if savedStoreCategory == "31775381011" {
                previousStoreCategory = "Pants"
            }else if savedStoreCategory == "31775416011" {
                previousStoreCategory = "Shorts"
            }else if savedStoreCategory == "33096451011" {
                previousStoreCategory = "Skirts"
            }else if savedStoreCategory == "33305264011" {
                previousStoreCategory = "Mens Shoes"
            }else if savedStoreCategory == "33305265011" {
                previousStoreCategory = "Womens Shoes"
            }
            
            if storeCategorySelector.indexOfSelectedItem == 1 {
                result![0].storeCategory = "28973014011"
            }else if storeCategorySelector.indexOfSelectedItem == 2 {
                result![0].storeCategory = "1"
            }else if storeCategorySelector.indexOfSelectedItem == 3 {
                result![0].storeCategory = "31775381011"
            }else if storeCategorySelector.indexOfSelectedItem == 4 {
                result![0].storeCategory = "31775416011"
            }else if storeCategorySelector.indexOfSelectedItem == 5 {
                result![0].storeCategory = "33096451011"
            }else if storeCategorySelector.indexOfSelectedItem == 6 {
                result![0].storeCategory = "29074207011"
            }else if storeCategorySelector.indexOfSelectedItem == 7 {
                result![0].storeCategory = "29010495011"
            }else if storeCategorySelector.indexOfSelectedItem == 8 {
                result![0].storeCategory = "33305264011"
            }else if storeCategorySelector.indexOfSelectedItem == 9 {
                result![0].storeCategory = "33305265011"
            }
            
            let newStoreCategory = storeCategorySelector.stringValue
            result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousStoreCategory!, with: newStoreCategory)
            itemDescriptionField.stringValue = result![0].itemDescription
            self.storeCategorySelector.isEnabled = false
            self.storeCategorySelector.isEnabled = true
        }
    }
    
    @IBAction func sizeTypeDidSet(_ sender: NSPopUpButton) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            let previousSizeType = result![0].sizeType
            if sizeTypeSelector.indexOfSelectedItem == 1 {
                result![0].sizeType = "Juniors"
            }else if sizeTypeSelector.indexOfSelectedItem == 2 {
                result![0].sizeType = "Regular"
                }else if sizeTypeSelector.indexOfSelectedItem == 3 {
                result![0].sizeType = "Petite"
                }else if sizeTypeSelector.indexOfSelectedItem == 4 {
                result![0].sizeType = "Plus"
            }
            let newSizeType = sizeTypeSelector.stringValue
            result![0].itemDescription = result![0].itemDescription.replacingOccurrences(of: previousSizeType, with: newSizeType)
            itemDescriptionField.stringValue = result![0].itemDescription
            self.sizeTypeSelector.isEnabled = false
            self.sizeTypeSelector.isEnabled = true
        }
    }
    
    
    @IBAction func styleDidSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
               let realm = try! Realm(configuration: config)
               try! realm.write {
                   
                if styleSelector.indexOfSelectedItem == 1 {
                    result![0].style = "Basic"
                }else if styleSelector.indexOfSelectedItem == 2 {
                    result![0].style = "Camisole"
                }else if styleSelector.indexOfSelectedItem == 3 {
                    result![0].style = "Cropped"
                }else if styleSelector.indexOfSelectedItem == 4 {
                    result![0].style = "Jersey"
                }else if styleSelector.indexOfSelectedItem == 5 {
                    result![0].style = "Kimono"
                }else if styleSelector.indexOfSelectedItem == 6 {
                    result![0].style = "Ringer"
                }else if styleSelector.indexOfSelectedItem == 7 {
                    result![0].style = "Tunic"
                }
                   self.styleSelector.isEnabled = false
                   self.styleSelector.isEnabled = true
               }
    }
    
    @IBAction func necklineDidSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            
            if necklineSelector.indexOfSelectedItem == 1 {
                result![0].neckline = "Boat Neck"
            }else if necklineSelector.indexOfSelectedItem == 2 {
                result![0].neckline = "Collared"
            }else if necklineSelector.indexOfSelectedItem == 3 {
                result![0].neckline = "Cowl Neck"
            }else if necklineSelector.indexOfSelectedItem == 4 {
                result![0].neckline = "Crew Neck"
            }else if necklineSelector.indexOfSelectedItem == 5 {
                result![0].neckline = "Halter"
            }else if necklineSelector.indexOfSelectedItem == 6 {
                result![0].neckline = "Henley"
            }else if necklineSelector.indexOfSelectedItem == 7 {
                result![0].neckline = "High Neck"
            }else if necklineSelector.indexOfSelectedItem == 8 {
                result![0].neckline = "Mock Neck"
            }else if necklineSelector.indexOfSelectedItem == 9 {
                result![0].neckline = "Off the Shoulder"
            }else if necklineSelector.indexOfSelectedItem == 10 {
                result![0].neckline = "Round Neck"
            }else if necklineSelector.indexOfSelectedItem == 11 {
                result![0].neckline = "Scoop Neck"
            }else if necklineSelector.indexOfSelectedItem == 12 {
                result![0].neckline = "Square Neck"
            }else if necklineSelector.indexOfSelectedItem == 13 {
                result![0].neckline = "Sweetheart"
            }else if necklineSelector.indexOfSelectedItem == 14 {
                result![0].neckline = "Turttleneck"
            }else if necklineSelector.indexOfSelectedItem == 15 {
                result![0].neckline = "V-Neck"
            }
            self.necklineSelector.isEnabled = false
            self.necklineSelector.isEnabled = true
        }
    }
    
    @IBAction func materialDidSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            
            if materialSelector.indexOfSelectedItem == 1 {
                result![0].material = "Polyester"
            }else if materialSelector.indexOfSelectedItem == 2 {
                result![0].material = "Cotton"
            }else if materialSelector.indexOfSelectedItem == 3 {
                result![0].material = "Nylon"
            }else if materialSelector.indexOfSelectedItem == 4 {
                result![0].material = "Acetate"
            }else if materialSelector.indexOfSelectedItem == 5 {
                result![0].material = "Alfa"
            }else if materialSelector.indexOfSelectedItem == 6 {
                result![0].material = "Alginate"
            }else if materialSelector.indexOfSelectedItem == 7 {
                result![0].material = "Alpaca"
            }else if materialSelector.indexOfSelectedItem == 8 {
                result![0].material = "Angora"
            }else if materialSelector.indexOfSelectedItem == 9 {
                result![0].material = "Animal Hair"
            }else if materialSelector.indexOfSelectedItem == 10 {
                result![0].material = "Aramid"
            }else if materialSelector.indexOfSelectedItem == 11 {
                result![0].material = "Bamboo"
            }else if materialSelector.indexOfSelectedItem == 12 {
                result![0].material = "Camel"
            }else if materialSelector.indexOfSelectedItem == 13 {
                result![0].material = "Cashgora"
            }else if materialSelector.indexOfSelectedItem == 14 {
                result![0].material = "Cashmere"
            }else if materialSelector.indexOfSelectedItem == 15 {
                result![0].material = "Chlorofiber"
            }else if materialSelector.indexOfSelectedItem == 16 {
                result![0].material = "Coir"
            }else if materialSelector.indexOfSelectedItem == 17 {
                result![0].material = "Cupro"
            }else if materialSelector.indexOfSelectedItem == 18 {
                result![0].material = "Elastodiene"
            }else if materialSelector.indexOfSelectedItem == 19 {
                result![0].material = "Elastolefin"
            }else if materialSelector.indexOfSelectedItem == 20 {
                result![0].material = "Elastomultiester"
            }else if materialSelector.indexOfSelectedItem == 21 {
                result![0].material = "Faux Fur"
            }else if materialSelector.indexOfSelectedItem == 22 {
                result![0].material = "Faux Leather"
            }else if materialSelector.indexOfSelectedItem == 23 {
                result![0].material = "Flax"
            }else if materialSelector.indexOfSelectedItem == 24 {
                result![0].material = "Fluorofiber"
            }else if materialSelector.indexOfSelectedItem == 25 {
                result![0].material = "Fur"
            }else if materialSelector.indexOfSelectedItem == 26 {
                result![0].material = "Guanaco"
            }else if materialSelector.indexOfSelectedItem == 27 {
                result![0].material = "Hemp"
            }else if materialSelector.indexOfSelectedItem == 28 {
                result![0].material = "Henequen"
            }else if materialSelector.indexOfSelectedItem == 29 {
                result![0].material = "Jute"
            }else if materialSelector.indexOfSelectedItem == 30 {
                result![0].material = "Kapok"
            }else if materialSelector.indexOfSelectedItem == 31 {
                result![0].material = "Leather"
            }else if materialSelector.indexOfSelectedItem == 32 {
                result![0].material = "Linen"
            }else if materialSelector.indexOfSelectedItem == 33 {
                result![0].material = "Llama"
            }else if materialSelector.indexOfSelectedItem == 34 {
                result![0].material = "Lyocell"
            }else if materialSelector.indexOfSelectedItem == 35 {
                result![0].material = "Maguey"
            }else if materialSelector.indexOfSelectedItem == 36 {
                result![0].material = "Manila Hemp"
            }else if materialSelector.indexOfSelectedItem == 37 {
                result![0].material = "Modacrylic"
            }else if materialSelector.indexOfSelectedItem == 38 {
                result![0].material = "Modal"
            }else if materialSelector.indexOfSelectedItem == 39 {
                result![0].material = "Mohair"
            }else if materialSelector.indexOfSelectedItem == 40 {
                result![0].material = "Patent Leather"
            }else if materialSelector.indexOfSelectedItem == 41 {
                result![0].material = "Polyacrylate Fiber"
            }else if materialSelector.indexOfSelectedItem == 42 {
                result![0].material = "Polyamide"
            }else if materialSelector.indexOfSelectedItem == 43 {
                result![0].material = "Polycarbamide"
            }else if materialSelector.indexOfSelectedItem == 44 {
                result![0].material = "Polyethylene"
            }else if materialSelector.indexOfSelectedItem == 45 {
                result![0].material = "Polyimide"
            }else if materialSelector.indexOfSelectedItem == 46 {
                result![0].material = "Polylactide"
            }else if materialSelector.indexOfSelectedItem == 47 {
                result![0].material = "Polypropylene"
            }else if materialSelector.indexOfSelectedItem == 48 {
                result![0].material = "Polyurethane"
            }else if materialSelector.indexOfSelectedItem == 49 {
                result![0].material = "Ramie"
            }else if materialSelector.indexOfSelectedItem == 50 {
                result![0].material = "Silk"
            }else if materialSelector.indexOfSelectedItem == 51 {
                result![0].material = "Sisal"
            }else if materialSelector.indexOfSelectedItem == 52 {
                result![0].material = "Spandex"
            }else if materialSelector.indexOfSelectedItem == 53 {
                result![0].material = "Suede"
            }else if materialSelector.indexOfSelectedItem == 54 {
                result![0].material = "Sunn"
            }else if materialSelector.indexOfSelectedItem == 55 {
                result![0].material = "Tiacetate"
            }else if materialSelector.indexOfSelectedItem == 56 {
                result![0].material = "Trivinyl"
            }else if materialSelector.indexOfSelectedItem == 57 {
                result![0].material = "Vicuna"
            }else if materialSelector.indexOfSelectedItem == 58 {
                result![0].material = "Viscose"
            }else if materialSelector.indexOfSelectedItem == 59 {
                result![0].material = "Wool"
            }else if materialSelector.indexOfSelectedItem == 60 {
                result![0].material = "Yak"
            }
            self.materialSelector.isEnabled = false
            self.materialSelector.isEnabled = true
        }
    }
    
    @IBAction func occasionDidSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            
            if occasionSelector.indexOfSelectedItem == 1 {
                result![0].occasion = "Casual"
            }else if occasionSelector.indexOfSelectedItem == 2 {
                result![0].occasion = "Business"
            }else if occasionSelector.indexOfSelectedItem == 3 {
                result![0].occasion = "Formal"
            }else if occasionSelector.indexOfSelectedItem == 4 {
                result![0].occasion = "Party/Cocktail"
            }else if occasionSelector.indexOfSelectedItem == 5 {
                result![0].occasion = "Travel"
            }else if occasionSelector.indexOfSelectedItem == 6 {
                result![0].occasion = "Wedding"
            }else if occasionSelector.indexOfSelectedItem == 7 {
                result![0].occasion = "Workwear"
            }
            self.occasionSelector.isEnabled = false
            self.occasionSelector.isEnabled = true
        }
    }
    
    @IBAction func patternDidSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            
            if patternSelector.indexOfSelectedItem == 1 {
                result![0].pattern = "Solid"
            }else if patternSelector.indexOfSelectedItem == 2 {
                result![0].pattern = "Floral"
            }else if patternSelector.indexOfSelectedItem == 3 {
                result![0].pattern = "Striped"
            }else if patternSelector.indexOfSelectedItem == 4 {
                result![0].pattern = "Polka Dot"
            }else if patternSelector.indexOfSelectedItem == 5 {
                result![0].pattern = "Geometric"
            }else if patternSelector.indexOfSelectedItem == 6 {
                result![0].pattern = "Argyle/Diamond"
            }else if patternSelector.indexOfSelectedItem == 7 {
                result![0].pattern = "Camouflage"
            }else if patternSelector.indexOfSelectedItem == 8 {
                result![0].pattern = "Check"
            }else if patternSelector.indexOfSelectedItem == 9 {
                result![0].pattern = "Colorblock"
            }else if patternSelector.indexOfSelectedItem == 10 {
                result![0].pattern = "Fair Isle"
            }else if patternSelector.indexOfSelectedItem == 11 {
                result![0].pattern = "Herringbone"
            }else if patternSelector.indexOfSelectedItem == 12 {
                result![0].pattern = "Paisley"
            }else if patternSelector.indexOfSelectedItem == 13 {
                result![0].pattern = "Plaid"
            }
            self.patternSelector.isEnabled = false
            self.patternSelector.isEnabled = true
        }
    }
    
    @IBAction func waistDidSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
               let realm = try! Realm(configuration: config)
               try! realm.write {
                   
                   if waistSelector.indexOfSelectedItem == 1 {
                       result![0].waist = "10"
                   }else if waistSelector.indexOfSelectedItem == 2 {
                       result![0].waist = "11"
                   }else if waistSelector.indexOfSelectedItem == 3 {
                       result![0].waist = "12"
                   }else if waistSelector.indexOfSelectedItem == 4 {
                       result![0].waist = "13"
                   }else if waistSelector.indexOfSelectedItem == 5 {
                       result![0].waist = "14"
                   }else if waistSelector.indexOfSelectedItem == 6 {
                       result![0].waist = "15"
                   }else if waistSelector.indexOfSelectedItem == 7 {
                       result![0].waist = "16"
                   }else if waistSelector.indexOfSelectedItem == 8 {
                       result![0].waist = "17"
                   }else if waistSelector.indexOfSelectedItem == 9 {
                       result![0].waist = "18"
                   }else if waistSelector.indexOfSelectedItem == 10 {
                       result![0].waist = "19"
                   }else if waistSelector.indexOfSelectedItem == 11 {
                       result![0].waist = "20"
                }
                   self.waistSelector.isEnabled = false
                   self.waistSelector.isEnabled = true
               }
    }
    
    @IBAction func inseamDIdSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
               let realm = try! Realm(configuration: config)
               try! realm.write {
                   
                   if inseamSelector.indexOfSelectedItem == 1 {
                       result![0].inseam = "26"
                   }else if inseamSelector.indexOfSelectedItem == 2 {
                       result![0].inseam = "27"
                   }else if inseamSelector.indexOfSelectedItem == 3 {
                       result![0].inseam = "28"
                   }else if inseamSelector.indexOfSelectedItem == 4 {
                       result![0].inseam = "29"
                   }else if inseamSelector.indexOfSelectedItem == 5 {
                       result![0].inseam = "30"
                   }else if inseamSelector.indexOfSelectedItem == 6 {
                       result![0].inseam = "31"
                   }else if inseamSelector.indexOfSelectedItem == 7 {
                       result![0].inseam = "32"
                   }else if inseamSelector.indexOfSelectedItem == 8 {
                       result![0].inseam = "33"
                   }else if inseamSelector.indexOfSelectedItem == 9 {
                       result![0].inseam = "34"
                   }else if inseamSelector.indexOfSelectedItem == 10 {
                       result![0].inseam = "35"
                   }else if inseamSelector.indexOfSelectedItem == 11 {
                       result![0].inseam = "36"
                   }else if inseamSelector.indexOfSelectedItem == 12 {
                       result![0].inseam = "37"
                   }else if inseamSelector.indexOfSelectedItem == 13 {
                       result![0].inseam = "38"
                   }else if inseamSelector.indexOfSelectedItem == 14 {
                       result![0].inseam = "39"
                   }else if inseamSelector.indexOfSelectedItem == 15 {
                       result![0].inseam = "40"
                   }
                   self.inseamSelector.isEnabled = false
                   self.inseamSelector.isEnabled = true
               }
    }
    
    @IBAction func riseDidSet(_ sender: NSComboBox) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
               let realm = try! Realm(configuration: config)
               try! realm.write {
                   
                   if riseSelector.indexOfSelectedItem == 1 {
                       result![0].rise = "Ultra Low"
                   }else if riseSelector.indexOfSelectedItem == 2 {
                       result![0].rise = "Low"
                   }else if riseSelector.indexOfSelectedItem == 3 {
                       result![0].rise = "Mid"
                   }else if riseSelector.indexOfSelectedItem == 4 {
                       result![0].rise = "High"
                   }
                   self.riseSelector.isEnabled = false
                   self.riseSelector.isEnabled = true
               }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func appendToDB(_ sender: NSButton) {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            
            var upcArray: [Int] = []
            var skuArray: [String] = []
            let nextSkuInArray: String?
            var code: String?
            for i in results! {
                skuArray.append(i.sku)
                upcArray.append(i.upc)
            }
            
            //           let lastUpcInArray = upcArray.last
            //            print("last upc: \(lastUpcInArray!)")
            //            print("upc field \(UPCSearchField.integerValue)")
            //            if let index = upcArray.firstIndex(of: UPCSearchField.integerValue) {
            //            print("index: \(index)")
            //            }
            
            let lastSkuInArray = Int(skuArray.last!.dropFirst(4))
            //print("last number in array: \(String(describing: lastSkuInArray))")
            let skuPrefix = String(skuArray.last!.dropLast(3))
            // print("skuPrefix \(skuPrefix)")
            
            if upcArray.firstIndex(of: UPCSearchField.integerValue) != nil {
                nextSkuInArray = nil
            }else{
                nextSkuInArray = skuPrefix + String(lastSkuInArray! + 1)
               // print("nextSkuInArray: \(String(describing: nextSkuInArray))")
            }
            
            if nextSkuInArray != nil {
                if image.stringValue != "" && image.stringValue.contains("macy") {
                               let imageLinkstart = image.stringValue.replacingOccurrences(of: "http://slimages.macys.com/is/image/MCY/", with: "")
                                                  let imageLinkEnd = imageLinkstart.replacingOccurrences(of: "%20", with: "")
                                                      code = String(Int(imageLinkEnd)! - 7)
                                                  
                           }else if image.stringValue.contains("bloom") {
                               let imageLinkstart = image.stringValue.replacingOccurrences(of: "http://images.bloomingdales.com/is/image/BLM/", with: "")
                                                  let imageLinkEnd = imageLinkstart.replacingOccurrences(of: "%20", with: "")
                                                      code = String(Int(imageLinkEnd)! - 7)
                                              }
                
                
                realm.create(Product.self, value: ["upc": UPCSearchField.integerValue, "msrp": msrp.stringValue, "UPCField": UPCSearchField.integerValue, "sku": nextSkuInArray! , "vendorName": "XXXXXXXXXXXXXXXXXX", "image": image.stringValue, "code": code!], update: .modified)
            }else{
                if image.stringValue != "" && image.stringValue.contains("macy") {
                               let imageLinkstart = image.stringValue.replacingOccurrences(of: "http://slimages.macys.com/is/image/MCY/", with: "")
                                                  let imageLinkEnd = imageLinkstart.replacingOccurrences(of: "%20", with: "")
                                                      code = String(Int(imageLinkEnd)! - 7)
                                                  
                           }else if image.stringValue.contains("bloom") {
                               let imageLinkstart = image.stringValue.replacingOccurrences(of: "http://images.bloomingdales.com/is/image/BLM/", with: "")
                                                  let imageLinkEnd = imageLinkstart.replacingOccurrences(of: "%20", with: "")
                                                      code = String(Int(imageLinkEnd)! - 7)
                                              }
                realm.create(Product.self, value: ["upc": UPCSearchField.integerValue, "msrp": msrp.stringValue, "UPCField": UPCSearchField.integerValue, "vendorName": "XXXXXXXXXXXXXXXXXX", "image": image.stringValue, "code": code!], update: .modified)
            }
            
           
            
            SearchBar(self)
        }
    }
    
    
    func productScroll() {
               for i in results! {
                   upcArray.append(i.upc)
               }
        
    }
    
    @IBAction func scrollProducts(_ sender: NSPopUpButton) {
        productScroll()
        let selectedProductNum = productSelector.indexOfSelectedItem
        productSelector.selectItem(at: selectedProductNum)
        let row = String(upcArray[selectedProductNum - 1])
        UPCSearchField.stringValue = row
        SearchBar(self)
        productSelector.selectItem(at: selectedProductNum)
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
