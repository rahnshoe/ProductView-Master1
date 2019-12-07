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
   

    
     let hiRezImgURLbegin = "https://slimages.macysassets.com/is/image/MCY/products/1/optimized/"
     let hiRezImgURLEnd = "_fpx.tif?op_sharpen=1&wid=1230&hei=1500&fit=fit,1&$filterxlrg$"
                  
    
                   
                   let url1 = URL(string: "\(hiRezImgURLbegin)\(HRimageCode!)\(hiRezImgURLEnd)")
                   print("url1 is: \(url1)")
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
 

    
    @IBAction func CloseWindow(_ sender: NSButton) {
        HRimageCode = tempHRimageCode
        self.view.window?.close()
    }
    
}
    

 

