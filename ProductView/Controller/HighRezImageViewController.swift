//
//  HighRezImageViewController.swift
//  ProductView
//
//  Created by chris rahn on 3/27/19.
//  Copyright © 2019 chris rahn. All rights reserved.
//

import Cocoa
import RealmSwift

var counter = 0




class HighRezImageViewController: NSViewController {
    
    
    @IBOutlet weak var closeButton: NSButton!
    
       

    
    @IBOutlet weak var HighRezImageView: NSImageView!
    
   override func viewDidLoad() {
        super.viewDidLoad()
    
    (closeButton.cell as! NSButtonCell).isBordered = false//The background color is used only when drawing borderless buttons.
    (closeButton.cell as! NSButtonCell).backgroundColor = NSColor.red
       
    if reviewModeState == "on" {
        if HRZimg1Selected == true {
            print("imag1 selected")
            let url1 = URL(string:HRZurl1!)
            do {
                let data = try Data(contentsOf: url1!)
                HighRezImageView1 = NSImage(data: data)
            } catch {
                print("error!")
            }
            do {
                
                HighRezImageView.image = HighRezImageView1
            }
            
        } else if HRZimg2Selected == true {
            print("imag2 selected")
            let url1 = URL(string:HRZurl2!)
            do {
                let data = try Data(contentsOf: url1!)
                HighRezImageView1 = NSImage(data: data)
            } catch {
                print("error!")
            }
            do {
                
                HighRezImageView.image = HighRezImageView1
            }
            
            } else if HRZimg3Selected == true {
            print("imag3 selected")
            let url1 = URL(string:HRZurl3!)
            do {
                let data = try Data(contentsOf: url1!)
                HighRezImageView1 = NSImage(data: data)
            } catch {
                print("error!")
            }
            do {
                
                HighRezImageView.image = HighRezImageView1
            }
            
            } else if HRZimg4Selected == true {
            print("imag4 selected")
            let url1 = URL(string:HRZurl4!)
            do {
                let data = try Data(contentsOf: url1!)
                HighRezImageView1 = NSImage(data: data)
            } catch {
                print("error!")
            }
            do {
                
                HighRezImageView.image = HighRezImageView1
            }
            
        }
        
        
        
        
        
        
        
        
        
        
        
    
    
    }else{
                   let url1 = URL(string: "\(hiRezImgURLbegin)\(HRimageCode!)\(hiRezImgURLEnd)")
                   //print("url1 is: \(url1)")
                   do {
                       let data = try Data(contentsOf: url1!)
                       HighRezImageView1 = NSImage(data: data)
                   } catch {
                       print("error!")
                   }
    
    do {
  
        HighRezImageView.image = HighRezImageView1
    }


 

    
   
    
}
    }
    @IBAction func CloseWindow(_ sender: NSButton) {
        HRimageCode = tempHRimageCode!
           self.view.window?.close()
            HRZimg1Selected = false
            HRZimg2Selected = false
            HRZimg3Selected = false
            HRZimg4Selected = false


}
}
