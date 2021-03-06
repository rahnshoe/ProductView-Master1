//
//  ViewController.swift
//  ProductView
//
//  Created by chris rahn on 3/6/19.
//  Copyright © 2019 chris rahn. All rights reserved.
//
//var upcScanIn: String = "801682090309"
//var upcScanIn: String = "190383568836"
//var upcScanIn: String = "888380730546"

import Cocoa
import RealmSwift

var realmDBurl = URL(string: "")
var HighRezImageView1: NSImage?

class ViewController: NSViewController {
//
//
var results: Results<Product>?
var previouslyRun: String?
var postFixValue = 000
//var result: Results<Product>?
//// var realmDBurl = URL(string: "")
//var searchString: Int = 0
//var counter = 0
//
//
//    @IBOutlet weak var UPCField: NSTextField!
//    @IBOutlet weak var itemDescriptionField: NSTextField!
//   // @IBOutlet weak var prodImage: NSImageView!
//    @IBOutlet weak var hdImageButton: NSButton!
//    @IBOutlet weak var mainSearchBar: NSSearchField!
//    @IBOutlet weak var colorField: NSTextField!
//    @IBOutlet weak var sizeField: NSTextField!
//    @IBOutlet weak var quantityField: NSTextField!
//
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var previousRun: NSButtonCell!
    @IBOutlet weak var setSKU: NSTextField!
    
    
    //
//
//
    override func viewDidLoad() {
       super.viewDidLoad()
        (startButton.cell as! NSButtonCell).isBordered = false//The background color is used only when drawing borderless buttons.
        (startButton.cell as! NSButtonCell).backgroundColor = NSColor.green
   
//
//        //MultiView.saveHD_img8.backgroundColor =
//
//        // Do any additional setup after loading the view.
//        //let addWomensNewInstance1 = AddWomens()
   }
//
//    //MARK: - Data Manipulation Methods
//
    
    
    @IBAction func previouslyRun(_ sender: NSButtonCell) {
        if sender.state == .on {
            previouslyRun = nil
            print("this has been run before")
        }else if sender.state == .off {
            previouslyRun = "nope"
            print("not previously run")
        }
    }
    
@IBAction func OpenFile(_ sender: Any) {

        let fpFilePicker: NSOpenPanel = NSOpenPanel()

        fpFilePicker.allowsMultipleSelection = false
        fpFilePicker.canChooseFiles = true
        fpFilePicker.canChooseDirectories = false

        fpFilePicker.runModal()

        let chosenFile = fpFilePicker.url

        if(chosenFile != nil) {
            //there is a file
            realmDBurl = fpFilePicker.url!
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
           // print("config: \(config)")
            do {
            let realm = try Realm(configuration: config)
                results = realm.objects(Product.self)
                 try! realm.write {
                
               // print("results: \(results!)")
                
               // print(results![1].upc)
               // print(results![1].color.localizedCapitalized)
                
                if previouslyRun == nil {
                    return
                }else{
                    
                for i in results! {
                    
                    if setSKU.stringValue != "" {
                       postFixValue = postFixValue + 1
                       //setSKU.integerValue = setSKU.integerValue + 1
                        i.sku = String(setSKU.integerValue)
                        i.sku = "AZ" + i.sku + "_" + String(postFixValue)
                    }
                    
                    if i.msrp.contains("$") {
                        i.msrp = String(i.msrp.dropFirst(1))
                        
                    }
                
                    if i.image.contains("macy") {
                        
                        
                        let imageLinkstart = i.image.replacingOccurrences(of: "http://slimages.macys.com/is/image/MCY/", with: "")
                        let imageLinkEnd = imageLinkstart.replacingOccurrences(of: "%20", with: "")
                        i.code = String(Int(imageLinkEnd)! - 7)
                        
                    }else if i.image.contains("bloom") {
                        
                        let imageLinkstart = i.image.replacingOccurrences(of: "http://images.bloomingdales.com/is/image/BLM/", with: "")
                        let imageLinkEnd = imageLinkstart.replacingOccurrences(of: "%20", with: "")
                        i.code = String(Int(imageLinkEnd)! - 7)
                        
                    }
                    
                    
                   i.color = i.color.localizedCapitalized
                   i.itemDescription = i.itemDescription.localizedCapitalized
                   i.vendorName = i.vendorName.localizedCapitalized
                   
                    //SET Brand Field from Vendor Name
                    
                    if i.vendorName.contains("7 For All Mankind") {
                        i.brand = "7 For All Mankind"
                    }else if i.vendorName.contains("Adriano Goldschmied") {
                        i.brand = "Adriano Goldschmied"
                    }else if i.vendorName.contains("Astr") {
                        i.brand = "ASTR The Label"
                    }else if i.vendorName.contains("Bar") {
                        i.brand = "Bar III"
                    }else if i.vendorName.contains("Carbon Copy") {
                        i.brand = "Carbon Copy"
                    }else if i.vendorName.contains("Current Air") {
                        i.brand = "Current Air"
                    }else if i.vendorName.contains("Dee Elle") {
                        i.brand = "Dee Elle"
                    }else if i.vendorName.contains("Free People") {
                        i.brand = "Free People"
                    }else if i.vendorName.contains("Ginger By Stella") {
                        i.brand = "Ginger by Stella & Ginger"
                    }else if i.vendorName.contains("Guess") {
                        i.brand = "Guess"
                    }else if i.vendorName.contains("Heartloom") {
                        i.brand = "Heartloom"
                    }else if i.vendorName.contains("Hudson") {
                        i.brand = "Hudson"
                    }else if i.vendorName.contains("Joa") {
                        i.brand = "JOA"
                    }else if i.vendorName.contains("Joe's Jeans") {
                        i.brand = "Joe's Jeans"
                    }else if i.vendorName.contains("Kndll") {
                        i.brand = "Kendall + Kylie"
                    }else if i.vendorName.contains("Leyden") {
                        i.brand = "Leyden"
                    }else if i.vendorName.contains("Line & Dot") {
                        i.brand = "Line & Dot"
                    }else if i.vendorName.contains("Lucky") {
                        i.brand = "Lucky Brand"
                    }else if i.vendorName.contains("Lucy Paris") {
                        i.brand = "Lucy Paris"
                    }else if i.vendorName.contains("Maison") {
                        i.brand = "Maison Jules"
                    }else if i.vendorName.contains("Moon River") {
                        i.brand = "Moon River"
                    }else if i.vendorName.contains("Nanette Lepore") {
                        i.brand = "Nanette Lepore"
                    }else if i.vendorName.contains("Paige Denim") {
                        i.brand = "Paige"
                    }else if i.vendorName.contains("Project 28") {
                        i.brand = "Project 28"
                    }else if i.vendorName.contains("Rachel Roy") {
                        i.brand = "Rachel Roy"
                    }else if i.vendorName.contains("Rachel Zoe") {
                        i.brand = "Rachel Zoe"
                    }else if i.vendorName.contains("Sanctuary") {
                        i.brand = "Sanctuary"
                    }else if i.vendorName.contains("Topson") {
                        i.brand = "Topson Downs"
                    }else if i.vendorName.contains("Trina Turk") {
                        i.brand = "Trina Turk"
                    }else if i.vendorName.contains("True Vintage") {
                        i.brand = "True Vintage"
                        
                    }else{
                        i.brand = "********"
                    }
                    
                    
                    if i.color.localizedCaseInsensitiveContains("Beige") {
                        i.color = "Beige"
                    }else if i.color.localizedCaseInsensitiveContains("Black") {
                        i.color = "Black"
                    }else if i.color.localizedCaseInsensitiveContains("Blue") {
                        i.color = "Blue"
                    }else if i.color.localizedCaseInsensitiveContains("Brown") {
                        i.color = "Brown"
                    }else if i.color.localizedCaseInsensitiveContains("Bwn") {
                        i.color = "Brown"
                    }else if i.color.localizedCaseInsensitiveContains("Charcoal") {
                        i.color = "Charcoal"
                    }else if i.color.localizedCaseInsensitiveContains("Copper") {
                        i.color = "Copper"
                    }else if i.color.localizedCaseInsensitiveContains("Gold") {
                        i.color = "Gold"
                    }else if i.color.localizedCaseInsensitiveContains("Gray") {
                        i.color = "Gray"
                    }else if i.color.localizedCaseInsensitiveContains("Green") {
                        i.color = "Green"
                    }else if i.color.localizedCaseInsensitiveContains("Grn") {
                        i.color = "Green"
                    }else if i.color.localizedCaseInsensitiveContains("Multi") {
                        i.color = "Multicolored"
                    }else if i.color.localizedCaseInsensitiveContains("Natural") {
                        i.color = "Natural"
                    }else if i.color.localizedCaseInsensitiveContains("Navy") {
                        i.color = "Navy"
                    }else if i.color.localizedCaseInsensitiveContains("Oran") {
                        i.color = "Orange"
                    }else if i.color.localizedCaseInsensitiveContains("Org") {
                        i.color = "Orange"
                    }else if i.color.localizedCaseInsensitiveContains("Pink") {
                        i.color = "Pink"
                    }else if i.color.localizedCaseInsensitiveContains("Pur") {
                        i.color = "Purple"
                    }else if i.color.localizedCaseInsensitiveContains("Red") {
                        i.color = "Red"
                    }else if i.color.localizedCaseInsensitiveContains("Silver") {
                        i.color = "Silver"
                    }else if i.color.localizedCaseInsensitiveContains("Taupe") {
                        i.color = "Taupe"
                    }else if i.color.localizedCaseInsensitiveContains("Turq") {
                        i.color = "Turquoise"
                    }else if i.color.localizedCaseInsensitiveContains("White") {
                        i.color = "White"
                    }else if i.color.localizedCaseInsensitiveContains("Wine") {
                        i.color = "Wine"
                    }else if i.color.localizedCaseInsensitiveContains("Yel") {
                        i.color = "Yellow"
                    }else{
                        i.color = "**COLOR**"
                    }
                    

                    
                    if i.itemDescription.localizedCaseInsensitiveContains("shirt"){
                        i.type = "Shirt"
                        i.ebayCategory = "53159"
                        i.storeCategory = "29010495011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("tank"){
                        i.type = "Tank"
                        i.ebayCategory = "53159"
                        i.storeCategory = "29010495011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("cami"){
                        i.type = "Cami"
                        i.ebayCategory = "53159"
                        i.storeCategory = "29010495011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("pullover"){
                        i.type = "Pullover"
                        i.ebayCategory = "53159"
                        i.storeCategory = "29010495011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("top"){
                        i.type = "Top"
                        i.ebayCategory = "53159"
                        i.storeCategory = "29010495011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("tunic"){
                        i.type = "Tunic"
                        i.ebayCategory = "53159"
                        i.storeCategory = "29010495011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("tshirt"){
                        i.type = "T-shirt"
                        i.ebayCategory = "53159"
                        i.storeCategory = "29010495011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("t-shirt"){
                        i.type = "T-shirt"
                        i.ebayCategory = "53159"
                        i.storeCategory = "29010495011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("tee"){
                        i.type = "Tee"
                        i.ebayCategory = "53159"
                        i.storeCategory = "29010495011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("blouse"){
                        i.type = "Blouse"
                        i.ebayCategory = "53159"
                        i.storeCategory = "29010495011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("sweater"){
                        i.type = "Sweater"
                        i.ebayCategory = "63866"
                        i.storeCategory = "29010495011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("skirt"){
                        i.type = "Skirt"
                        i.ebayCategory = "63864"
                        i.storeCategory = "33096451011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("mini"){
                        i.type = "Mini"
                        i.ebayCategory = "63864"
                        i.storeCategory = "33096451011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("shorts"){
                        i.type = "Shorts"
                        i.ebayCategory = "11555"
                        i.storeCategory = "31775416011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("legging"){
                        i.type = "Legging"
                        i.ebayCategory = "63863"
                        i.storeCategory = "31775381011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("overall"){
                        i.type = "Overall"
                        i.ebayCategory = "63863"
                        i.storeCategory = "31775381011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("pant"){
                        i.type = "Pants"
                        i.ebayCategory = "63863"
                        i.storeCategory = "31775381011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("trouser"){
                        i.type = "Trouser"
                        i.ebayCategory = "63863"
                        i.storeCategory = "31775381011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("jumpsuit"){
                        i.type = "Jumpsuit"
                        i.ebayCategory = "3009"
                        i.storeCategory = "1"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("romper"){
                        i.type = "Romper"
                        i.ebayCategory = "3009"
                        i.storeCategory = "1"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("jean"){
                        i.type = "Jeans"
                        i.ebayCategory = "11554"
                        i.storeCategory = "31775381011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("sleepwear"){
                        i.type = "Sleepwear"
                        i.ebayCategory = "63855"
                        i.storeCategory = "1"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("dress"){
                        i.type = "Dress"
                        i.ebayCategory = "63861"
                        i.storeCategory = "28973014011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("wrap"){
                        i.type = "Wrap"
                        i.ebayCategory = "63861"
                        i.storeCategory = "28973014011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("gown"){
                        i.type = "Gown"
                        i.ebayCategory = "63861"
                        i.storeCategory = "28973014011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("maxi"){
                        i.type = "Maxi"
                        i.ebayCategory = "63861"
                        i.storeCategory = "28973014011"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("coat"){
                        i.type = "Coat"
                        i.ebayCategory = "63862"
                        i.storeCategory = "1"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("jacket"){
                        i.type = "Jacket"
                        i.ebayCategory = "63862"
                        i.storeCategory = "1"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("vest"){
                        i.type = "Vest"
                        i.ebayCategory = "63862"
                        i.storeCategory = "1"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("hoodie"){
                        i.type = "Hoodie"
                        i.ebayCategory = "155226"
                        i.storeCategory = "1"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("sweatshirt"){
                        i.type = "Sweatshirt"
                        i.ebayCategory = "155226"
                        i.storeCategory = "1"
                    }else if i.itemDescription.localizedCaseInsensitiveContains("bodysuit"){
                        i.type = "Bodysuit"
                        i.ebayCategory = "53159"
                        i.storeCategory = "29010495011"
                    }else{
                        i.type = "**TYPE**"
                    }
                    
                    
                    
                    if i.size == "" {
                    i.size = "**SIZE**"
                    }
                    
                    
                    let itemDescriptionStart = (i.brand + " Womens "  + i.itemDescription)
                    let itemDescriptionEnd = (" " + i.color + " " + i.size)
                    if itemDescriptionStart.localizedCaseInsensitiveContains(i.type) {
                        i.itemDescription = itemDescriptionStart + itemDescriptionEnd
                    }else{
                    i.itemDescription = (i.brand + " Womens " + i.itemDescription + " " + i.type + " " + i.color + " " + i.size)
                    }
                    
                    if i.eBayConditionID == 0 {
                     i.eBayConditionID = 1000
                    }
                    
                    }
                    }
                }
            
                    //var sentanceToCapitalize =  result![0].brand + " Womens " + result![0].itemDescription + " " + result![0].color + " " + result![0].size
                    //result![0].itemDescription = sentanceToCapitalize.localizedCapitalized
                
                    
                
                //print("number of results - reference viewcontroller  \(results!.count)")
               // dismiss(ViewController.self)""
                print("perform segue")
                 performSegue(withIdentifier: "MultiView", sender: self)
                print("segue performed")
                self.view.window?.close()
                
            } catch {
                print("no file \(error)")
            }
            


        }
    }
//    //write updated objects to realm
//    func saveDataFields() {
//        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schema Version: 0)
//        let realm = try! Realm(configuration: config)
//        try! realm.write {
//            result![0].upc = UPCField.integerValue
//            result![0].itemDescription = itemDescriptionField.stringValue
//            result![0].color = colorField.stringValue
//            result![0].size = sizeField.stringValue
//            result![0].originalQty = quantityField.integerValue
//
//
//            //write updated objects to realm
//        }
//
//        print(result![0].itemDescription)
//      }
//
//
//
//@IBAction func SearchBar(_ sender: NSSearchField) {
//    let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schema Version: 0)
//    let realm = try! Realm(configuration: config)
//    print(results?.count as Any)
//    if results?.count != nil {
//    searchString = mainSearchBar!.integerValue
//   print(searchString)
//    let predicate = NSPredicate(format: "upc == %@", NSNumber (value: searchString))
//    result = results!.filter(predicate)
//
//        if (result?.count)! > 0 {
//
//
//    UPCField.stringValue = String(result![0].upc)
//    itemDescriptionField.stringValue = result![0].itemDescription
//            colorField.stringValue = String(result![0].color)
//            sizeField.stringValue = String(result![0].size)
//            quantityField.stringValue = String(result![0].originalQty)
//            let url = URL(string: result![0].image)
//            print(result![0].image)
//        do {
//            let data = try Data(contentsOf: url!)
//        //    prodImage.image = NSImage(data: data)
//            hdImageButton.image = NSImage(data: data)
//        } catch {
//            print("error!")
//        }
//         print(itemDescriptionField)
//        try! realm.write {
//
//        }
//    } else {
//
//
//        print("error.localizedDescription")
//        UPCField.stringValue = "not found"
//        itemDescriptionField.stringValue = "not found"
//        //prodImage.image = nil
//        hdImageButton.image = nil
//
//    }
//    } else {
//        UPCField.stringValue = "No Realm File!"
//    }
//
//
//        }
//
//    @IBAction func saveButton(_ sender: NSButton) {
//        saveDataFields()
//    }
//    @IBAction func MultiView(_ sender: Any) {
//        performSegue(withIdentifier: "MultiView", sender: self)
//    }
//    
//    
//    @IBAction func hdImageButton(_ sender: NSButton) {
//
//        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schema  Version: 0)
//        let realm = try! Realm(configuration: config)
//
//        let image0 =  result![0].image
//        print("image is \(image0)")
//
//       let hiRezImgURLbegin = "https://slimages.macysassets.com/is/image/MCY/products/1/optimized/"
//        let hiRezImgURLEnd = "_fpx.tif?op_sharpen=1&wid=1230&hei=1500&fit=fit,1&$filterxlrg$"
//        //let lowImgURLbegin = "http://slimages.macys.com/is/image/MCY/"
//       // let lowImgURLEnd = "%20"
//       // print(lowImgURLEnd)
//
//        let start = image0.index(image0.startIndex, offsetBy: 39)
//        let end = image0.index(image0.endIndex, offsetBy: 0)
//        let range = start..<end
//        let imageCode = Int(image0[range])!
//        print("image code is \(imageCode)")
//
//        //iterate and set image display
//        //var arrayOfURLs: [URL] = []
//        ///var incrementer = 0
//        let url1 = URL(string: "\(hiRezImgURLbegin)\(imageCode)\(hiRezImgURLEnd)")
//        print("url1 is: \(url1)")
//        do {
//            let data = try Data(contentsOf: url1!)
//            HighRezImageView1 = NSImage(data: data)
//        } catch {
//            print("error!")
//        }
     
      //  let url = URL(string: result![0].image)
     //   do {
     //      let data = try Data(contentsOf: url!)
       //     HighRezImageView1 = NSImage(data: data)
      //      print(HighRezImageView1)
     //   } catch {
      //      print("error!")
        }
//performSegue(withIdentifier: "SegueHD", sender: self)
   


