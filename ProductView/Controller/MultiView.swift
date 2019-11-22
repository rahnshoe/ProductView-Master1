//
//  MultiView.swift
//  ProductView
//
//  Created by chris rahn on 3/20/19.
//  Copyright © 2019 chris rahn. All rights reserved.
//

import Cocoa
import RealmSwift

class MultiView: NSViewController {
    
    var results: Results<Product>?
    var result: Results<Product>?
    var searchString: Int = 0
    var counter = 0
    var arrayOfURLs: [URL] = []
    var hdArrayOfURLs: [URL] = []
    
    var AltImgText1 = ""
    var AltImgText2 = ""
    var ovrUPC = ""
    
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
 
    
    @IBOutlet weak var saveHD_img1: NSButton!
    @IBOutlet weak var saveHD_img2: NSButton!
    @IBOutlet weak var saveHD_img3: NSButton!
    @IBOutlet weak var saveHD_img4: NSButton!
    @IBOutlet weak var saveHD_img5: NSButton!
    @IBOutlet weak var saveHD_img6: NSButton!
    @IBOutlet weak var saveHD_img7: NSButton!
    @IBOutlet weak var saveHD_img8: NSButton!
    @IBOutlet weak var saveHD_img9: NSButton!
    @IBOutlet weak var saveHD_img10: NSButton!
    @IBOutlet weak var saveHD_img11: NSButton!
    @IBOutlet weak var saveHD_img12: NSButton!
    @IBOutlet weak var saveHD_img13: NSButton!
    @IBOutlet weak var saveHD_img14: NSButton!
    @IBOutlet weak var saveHD_img15: NSButton!
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
    
    
    @IBOutlet weak var image8TXT: NSTextField!
    @IBOutlet weak var image9TXT: NSTextField!
    
    @IBOutlet weak var emptyFlag: NSTextField!
    @IBOutlet weak var scaleStatus: NSTextField!
    
    override func viewDidLoad() {
        scaleStatus.stringValue = "Scale is disconnected"
        counter = 0
        super.viewDidLoad()
        // Do view setup here.
    }
    

    
    @IBAction func SearchBar(_ sender: Any) {
         saveHD_img1.state = .off
         saveHD_img2.state = .off
         saveHD_img3.state = .off
         saveHD_img4.state = .off
         saveHD_img5.state = .off
         saveHD_img6.state = .off
         saveHD_img7.state = .off
         saveHD_img8.state = .off
         saveHD_img9.state = .off
         saveHD_img10.state = .off
         saveHD_img11.state = .off
         saveHD_img12.state = .off
         saveHD_img13.state = .off
         saveHD_img14.state = .off
         saveHD_img15.state = .off
        
       
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
                
                image8TXT.stringValue = ""
                image9TXT.stringValue = ""
                UPCField.stringValue = String(result![0].upc)
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
                //let substring = "pants"
                //if itemDescriptionField.stringValue.contains(substring, option caseInsensitve) {
               // style.stringValue = substring
               // } else {
                    // no match
                
                //temp change delete me 123
                
               //}
              
                
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
                
                //sizeField.stringValue = String(result![0].size)
                //quantityField.stringValue = String(result![0].originalQty)
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
                print("image code is \(imageCode)")
                
                //iterate and set image display
                let images = [image1, image2, image3, image4,image5, image6, image7, image8, image9, image10, image11, image12, image13, image14, image15]
                var incrementer = 0
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
                
                
          /*     do {
                   let data = try Data(contentsOf: url8!)
                    //    prodImage.image = NSImage(data: data)
                    image8.image = NSImage(data: data)
                } catch {
                    print("error!")
                }
                print(itemDescriptionField)
                try! realm.write {
                    
                  }
         */       } else {
                
                
                print("error.localizedDescription")
                UPCField.stringValue = "not found"
                itemDescriptionField.stringValue = "not found"
                //prodImage.image = nil
                image8.image = nil
                
            }
        } else {
           UPCField.stringValue = "No Realm File!"
        }
 
      
        
        
        
    }
 
    @IBAction func updateImages(_ sender: NSButton) {
        updateimages()
    }
    
    func updateimages(){
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        
        
        image8TXT.stringValue = String(result![0].imageSlot8)
        image9TXT.stringValue = String(result![0].imageSlot9)
        let url2 = URL(string: image8TXT.stringValue)
        let url3 = URL(string: image9TXT.stringValue)
        
        do {
            
            let data1 = try Data(contentsOf: url2!)
            image8.image = NSImage(data: data1)
            let data2 = try Data(contentsOf: url3!)
            image9.image = NSImage(data: data2)
            
            
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
         result![0].imageSlot8 = image8TXT.stringValue
         result![0].imageSlot9 = image9TXT.stringValue
        }
    }
    
    
    
    @IBAction func initScale(_ sender: NSButton) {
        
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
            }
        
        print(result![0].itemDescription)
    }
    
    
    
    
    @IBAction func override(_ sender: NSButton) {
        
       
        performSegue(withIdentifier: "OVERRIDEIMGSEGUE", sender: self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        var vc = segue.destinationController as! OverrideIMG
        AltImgText1 = String(describing: hdArrayOfURLs[7])
        AltImgText2 = String(describing: hdArrayOfURLs[8])
        vc.altImg1 = AltImgText1
        vc.altImg2 = AltImgText2
        vc.upcValue = ovrUPC
       
    }
    
    //write updated objects to realm
    
    
    
    
    
   /* @IBAction func forwardButton(_ sender: Any) {
        arrayOfURLs = []
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        
        
       
           let upcString = String(realm.objects(Product.self)[counter].upc)
           let itemDescriptionString = String(realm.objects(Product.self)[counter].itemDescription)
           let colorString = String(realm.objects(Product.self)[counter].color)
           let image0 = String(realm.objects(Product.self)[counter].image)
        
           UPCField.stringValue = upcString
           itemDescriptionField.stringValue = itemDescriptionString
           colorField.stringValue = colorString
        
        //let hiRezImgURLbegin = "https://slimages.macysassets.com/is/image/MCY/products/1/optimized/"
        //let hiRezImgURLEnd = "_fpx.tif?op_sharpen=1&wid=1230&hei=1500&fit=fit,1&$filterxlrg$"
        let lowImgURLbegin = "http://slimages.macys.com/is/image/MCY/"
        let lowImgURLEnd = "%20"
        
        let start = image0.index(image0.startIndex, offsetBy: 39)
        let end = image0.index(image0.endIndex, offsetBy: 0)
        let range = start..<end
        let imageCode = Int(image0[range])!-7
        
        //iterate and set image display
        //var arrayOfURLs: [URL] = []
        let images = [image1, image2, image3, image4,image5, image6, image7, image8, image9, image10, image11, image12, image13, image14, image15]
        var incrementer = 0
        repeat {
            for i in images {
                let url1 = URL(string: "\(lowImgURLbegin)\(imageCode + incrementer )\(lowImgURLEnd)")
              // print(url1)
                arrayOfURLs.append(url1!)
                do {
                    let data = try Data(contentsOf: url1!)
                    i!.image = NSImage(data: data)
                    incrementer += 1
                } catch {
                    print("error!")
                }
            }
        }while incrementer <= 7
        
        counter += 1
       //dump(arrayOfURLs)
        //print(arrayOfURLs[14])
    }
    
 
    
    
    @IBAction func backButton(_ sender: Any) {
         arrayOfURLs = []
        hdArrayOfURLs = []
        let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
        let realm = try! Realm(configuration: config)
        guard counter > 1 else {
            return
        }
            counter -= 1
            let upcString = String(realm.objects(Product.self)[counter-1].upc)
            let itemDescriptionString = String(realm.objects(Product.self)[counter-1].itemDescription)
            let colorString = String(realm.objects(Product.self)[counter-1].color)
            let image0 = String(realm.objects(Product.self)[counter-1].image)
            
            UPCField.stringValue = upcString
            itemDescriptionField.stringValue = itemDescriptionString
            colorField.stringValue = colorString
            
            //let hiRezImgURLbegin = "https://slimages.macysassets.com/is/image/MCY/products/1/optimized/"
            //let hiRezImgURLEnd = "_fpx.tif?op_sharpen=1&wid=1230&hei=1500&fit=fit,1&$filterxlrg$"
            let lowImgURLbegin = "http://slimages.macys.com/is/image/MCY/"
            let lowImgURLEnd = "%20"
        
            let start = image0.index(image0.startIndex, offsetBy: 39)
            let end = image0.index(image0.endIndex, offsetBy: -3)
            let range = start..<end
            let imageCode = Int(image0[range])!-7
        
            //iterate and set image display
            let images = [image1, image2, image3, image4,image5, image6, image7, image8, image9, image10, image11, image12, image13, image14, image15]
            var incrementer = 0
            repeat {
                for i in images {
                    let url1 = URL(string: "\(lowImgURLbegin)\(imageCode + incrementer )\(lowImgURLEnd)")
                    // print(url1)
                    arrayOfURLs.append(url1!)
            do {
            let data = try Data(contentsOf: url1!)
                i!.image = NSImage(data: data)
            incrementer += 1
            } catch {
            print("error!")
            }
                }
            }while incrementer <= 7
             
        }
      */
    //@IBAction func box1(_ sender: NSButton) {
      //  if sender.state == .on{
     //       print("game on!")
    //    } else {
      //      print("off!")
      //  }
        
        
        
   // }
    @IBAction func ibox1(_ sender: NSButton) {
        if sender.state == .on{
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
            let path0 =  String(describing: hdArrayOfURLs[0])
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
             realm.create(Product.self, value: ["upc": upcValue, "imageSlot1": path0], update: .modified)
                print("URL saved to realmDB.")
            }
        } else {
            print("off!")
    }
    }
    @IBAction func ibox2(_ sender: NSButton) {
        if sender.state == .on{
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
                let path0 =  String(describing: hdArrayOfURLs[1])
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
                realm.create(Product.self, value: ["upc": upcValue, "imageSlot2": path0], update: .modified)
                print("URL saved to realmDB.")

            }
        } else {
            print("off!")
        }
    }
    @IBAction func ibox3(_ sender: NSButton) {
        if sender.state == .on{
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
                let path0 =  String(describing: hdArrayOfURLs[2])
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
                realm.create(Product.self, value: ["upc": upcValue, "imageSlot3": path0], update: .modified)
                print("URL saved to realmDB.")

            }
        } else {
            print("off!")
        }
    }
    @IBAction func ibox4(_ sender: NSButton) {
        if sender.state == .on{
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
                let path0 =  String(describing: hdArrayOfURLs[3])
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
                realm.create(Product.self, value: ["upc": upcValue, "imageSlot4": path0], update: .modified)
                print("URL saved to realmDB.")

            }
        } else {
            print("off!")
        }
    }
    @IBAction func ibox5(_ sender: NSButton) {
        if sender.state == .on{
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
                let path0 =  String(describing: hdArrayOfURLs[4])
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
                realm.create(Product.self, value: ["upc": upcValue, "imageSlot5": path0], update: .modified)
                print("URL saved to realmDB.")
            }
        } else {
            print("off!")
        }
    }
    @IBAction func ibox6(_ sender: NSButton) {
        if sender.state == .on{
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
                let path0 =  String(describing: hdArrayOfURLs[5])
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
               realm.create(Product.self, value: ["upc": upcValue, "imageSlot6": path0], update: .modified)
                print("URL saved to realmDB.")

            }
        } else {
            print("off!")
        }
    }
    @IBAction func ibox7(_ sender: NSButton) {
        if sender.state == .on{
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
                let path0 =  String(describing: hdArrayOfURLs[6])
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
                realm.create(Product.self, value: ["upc": upcValue, "imageSlot7": path0], update: .modified)
                print("URL saved to realmDB.")
        
            }
        } else {
            print("off!")
        }
    }
    @IBAction func ibox8(_ sender: NSButton) {
        if sender.state == .on{
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
                let path0 =  String(describing: hdArrayOfURLs[7])
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
                realm.create(Product.self, value: ["upc": upcValue, "imageSlot8": path0], update: .modified)
                print("URL saved to realmDB.")
                
                }
                } else {
            print("off!")
        }
    }
    @IBAction func ibox9(_ sender: NSButton) {
        if sender.state == .on{
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
                let path0 =  String(describing: hdArrayOfURLs[8])
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
                realm.create(Product.self, value: ["upc": upcValue, "imageSlot9": path0], update: .modified)
                print("URL saved to realmDB.")
                
            }
        } else {
            print("off!")
        }
    }
    @IBAction func ibox10(_ sender: NSButton) {
        if sender.state == .on{
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
                let path0 =  String(describing: hdArrayOfURLs[9])
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
                realm.create(Product.self, value: ["upc": upcValue, "imageSlot10": path0], update: .modified)
                print("URL saved to realmDB.")
                
            }
        } else {
            print("off!")
        }
    }
    @IBAction func ibox11(_ sender: NSButton) {
        if sender.state == .on{
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
                let path0 =  String(describing: hdArrayOfURLs[10])
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
                realm.create(Product.self, value: ["upc": upcValue, "imageSlot11": path0], update: .modified)
                print("URL saved to realmDB.")
               
            }
        } else {
            print("off!")
        }
    }
    @IBAction func ibox12(_ sender: NSButton) {
        if sender.state == .on{
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
                let path0 =  String(describing: hdArrayOfURLs[11])
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
                realm.create(Product.self, value: ["upc": upcValue, "imageSlot12": path0], update: .modified)
                print("URL saved to realmDB.")
             
            }
        } else {
            print("off!")
        }
    }
    @IBAction func ibox13(_ sender: NSButton) {
        if sender.state == .on{
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
                let path0 =  String(describing: hdArrayOfURLs[12])
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
                realm.create(Product.self, value: ["upc": upcValue, "imageSlot13": path0], update: .modified)
                print("URL saved to realmDB.")
               
            }
        } else {
            print("off!")
        }
    }
    @IBAction func ibox14(_ sender: NSButton) {
        if sender.state == .on{
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
                let path0 =  String(describing: hdArrayOfURLs[13])
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
                realm.create(Product.self, value: ["upc": upcValue, "imageSlot14": path0], update: .modified)
                print("URL saved to realmDB.")
               
            }
        } else {
            print("off!")
        }
    }
    @IBAction func ibox15(_ sender: NSButton) {
        if sender.state == .on{
            let config = Realm.Configuration(fileURL: realmDBurl, readOnly: false, schemaVersion: 1)
            let realm = try! Realm(configuration: config)
            try! realm.write {
                let path0 =  String(describing: hdArrayOfURLs[14])
                let searchfieldChangeValue = UPCSearchField.stringValue
                let upcValue = Int(searchfieldChangeValue)
                realm.create(Product.self, value: ["upc": upcValue, "imageSlot15": path0], update: .modified)
                print("URL saved to realmDB.")
               
            }
        } else {
            print("off!")
        }
    }
    
    
    
    }



