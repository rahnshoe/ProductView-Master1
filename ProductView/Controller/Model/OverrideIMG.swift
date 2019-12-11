//
//  OverrideIMG.swift
//  ProductView
//
//  Created by chris rahn on 9/6/19.
//  Copyright © 2019 chris rahn. All rights reserved.
//


import Cocoa
import RealmSwift

class OverrideIMG: NSViewController {
    

    
    
    @IBOutlet weak var override8: NSTextField!
    @IBOutlet weak var override9: NSTextField!
    
    @IBOutlet weak var altImg_img1: NSImageView!
    @IBOutlet weak var altImg_img2: NSImageView!
    
    var upcValue = ""
    var upc = 0
    var altImg1 = ""
    var altImg2 = ""
    var url1 = URL(string: "")
    var url2 = URL(string: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        override8.stringValue = altImg1
        override9.stringValue = altImg2
      
        url1 = URL(string: override8.stringValue)
        url2 = URL(string: override9.stringValue)
     
        let data = try? Data(contentsOf: url1!)
        altImg_img1.image = NSImage(data: data!)
        let data1 = try? Data(contentsOf: url2!)
        altImg_img2.image = NSImage(data: data1!)
       
        
    }
    
    
    
    @IBAction func save(_ sender: NSButton) {
          overrideImageFields()
    }
    
   func overrideImageFields() {
    let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
    let realm = try! Realm(configuration: config)
    try! realm.write {
        print("OV8: ",override8.stringValue)
        print("OV9: ",override9.stringValue)
        print("UPCValue: ", upcValue)
        upc = Int(upcValue)!
        print("upc: ",upc)
        
        realm.create(Product.self, value: ["upc": upc, "imageSlot8": override8.stringValue, "imageSlot9": override9.stringValue], update: .modified)

        
        
        url1 = URL(string: override8.stringValue)
        url2 = URL(string: override9.stringValue)
        print("URL1: ",url1)
        print("URL2: ",url2)
        
        let data = try? Data(contentsOf: url1!)
        altImg_img1.image = NSImage(data: data!)
        let data1 = try? Data(contentsOf: url2!)
        altImg_img2.image = NSImage(data: data1!)
        
    }
}

}
