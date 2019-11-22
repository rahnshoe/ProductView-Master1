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


var results: Results<Product>?
var result: Results<Product>?
// var realmDBurl = URL(string: "")
var searchString: Int = 0
var counter = 0

    
    @IBOutlet weak var UPCField: NSTextField!
    @IBOutlet weak var itemDescriptionField: NSTextField!
   // @IBOutlet weak var prodImage: NSImageView!
    @IBOutlet weak var hdImageButton: NSButton!
    @IBOutlet weak var mainSearchBar: NSSearchField!
    @IBOutlet weak var colorField: NSTextField!
    @IBOutlet weak var sizeField: NSTextField!
    @IBOutlet weak var quantityField: NSTextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MultiView.saveHD_img8.backgroundColor = 
        
        // Do any additional setup after loading the view.
        //let addWomensNewInstance1 = AddWomens()
    }

    //MARK: - Data Manipulation Methods
    
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
            do {
            let realm = try Realm(configuration: config)
                results = realm.objects(Product.self)
                //print(results![0].upc)
                print(results!.count)
            } catch {
                print("\(error)")
            }
            
            
            
        }
    }
    //write updated objects to realm
    func saveDataFields() {
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        try! realm.write {
            result![0].upc = UPCField.integerValue
            result![0].itemDescription = itemDescriptionField.stringValue
            result![0].color = colorField.stringValue
            result![0].size = sizeField.stringValue
            result![0].originalQty = quantityField.integerValue
            
            
            //write updated objects to realm
        }
        
        print(result![0].itemDescription)
      }

   
    
@IBAction func SearchBar(_ sender: NSSearchField) {
    let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
    let realm = try! Realm(configuration: config)
    print(results?.count as Any)
    if results?.count != nil {
    searchString = mainSearchBar!.integerValue
   print(searchString)
    let predicate = NSPredicate(format: "upc == %@", NSNumber (value: searchString))
    result = results!.filter(predicate)
            
        if (result?.count)! > 0 {
        
        
    UPCField.stringValue = String(result![0].upc)
    itemDescriptionField.stringValue = result![0].itemDescription
            colorField.stringValue = String(result![0].color)
            sizeField.stringValue = String(result![0].size)
            quantityField.stringValue = String(result![0].originalQty)
            let url = URL(string: result![0].image)
            print(result![0].image)
        do {
            let data = try Data(contentsOf: url!)
        //    prodImage.image = NSImage(data: data)
            hdImageButton.image = NSImage(data: data)
        } catch {
            print("error!")
        }
         print(itemDescriptionField)
        try! realm.write {
        
        }
    } else {
        

        print("error.localizedDescription")
        UPCField.stringValue = "not found"
        itemDescriptionField.stringValue = "not found"
        //prodImage.image = nil
        hdImageButton.image = nil
            
    }
    } else {
        UPCField.stringValue = "No Realm File!"
    }
   
    
        }
    
    @IBAction func saveButton(_ sender: NSButton) {
        saveDataFields()
    }
    @IBAction func MultiView(_ sender: Any) {
        performSegue(withIdentifier: "MultiView", sender: self)
    }
    
    
    @IBAction func hdImageButton(_ sender: NSButton) {
  
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        
        let image0 =  result![0].image
        print("image is \(image0)")
        
       let hiRezImgURLbegin = "https://slimages.macysassets.com/is/image/MCY/products/1/optimized/"
        let hiRezImgURLEnd = "_fpx.tif?op_sharpen=1&wid=1230&hei=1500&fit=fit,1&$filterxlrg$"
        //let lowImgURLbegin = "http://slimages.macys.com/is/image/MCY/"
       // let lowImgURLEnd = "%20"
       // print(lowImgURLEnd)
        
        let start = image0.index(image0.startIndex, offsetBy: 39)
        let end = image0.index(image0.endIndex, offsetBy: 0)
        let range = start..<end
        let imageCode = Int(image0[range])!
        print("image code is \(imageCode)")

        //iterate and set image display
        //var arrayOfURLs: [URL] = []
        ///var incrementer = 0
        let url1 = URL(string: "\(hiRezImgURLbegin)\(imageCode)\(hiRezImgURLEnd)")
        do {
            let data = try Data(contentsOf: url1!)
            HighRezImageView1 = NSImage(data: data)
        } catch {
            print("error!")
        }
     
      //  let url = URL(string: result![0].image)
     //   do {
     //      let data = try Data(contentsOf: url!)
       //     HighRezImageView1 = NSImage(data: data)
      //      print(HighRezImageView1)
     //   } catch {
      //      print("error!")
       // }
performSegue(withIdentifier: "SegueHD", sender: self)
    }
    
    
    }
 

