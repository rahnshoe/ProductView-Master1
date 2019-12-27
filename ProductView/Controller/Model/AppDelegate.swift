//
//  AppDelegate.swift
//  ProductView
//
//  Created by chris rahn on 3/6/19.
//  Copyright © 2019 chris rahn. All rights reserved.
//

import Cocoa
import RealmSwift

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



   func applicationDidFinishLaunching(_ aNotification: Notification) {
    
    //var config = Realm.Configuration()
    //config.deleteRealmIfMigrationNeeded = true
    
    // ****Blowout REALM CONFIG****
  
  
     //try! FileManager.default .removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
    
   

  
    
    
 
       //bump the schema version to 0
    
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
        schemaVersion: 1,
        migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    //migration.enumerateObjects(ofType: Product.className()) { oldObject, newObject in
            //    }
               }
             })
 
   //    Realm.Configuration.defaultConfiguration = Realm.Configuration()
    
    
    
    
    print(Realm.Configuration.defaultConfiguration.fileURL!)
    
    
  //let realm = try! Realm()        // Insert code here to initialize your application
 
 }

    func applicationWillTerminate(_ aNotification: Notification) {
 
 // Insert code here to tear down your application

    }
 
}

