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
    
    
    @IBOutlet weak var HighRezImageView: NSImageView!
    
   override func viewDidLoad() {
        super.viewDidLoad()
    //let url1 = URL(string: "\(lowImgURLbegin)\(imageCode)\(lowImgURLEnd)")
    
    do {
  //      let data = try Data(contentsOf: url1!)
        HighRezImageView.image = HighRezImageView1
        //incrementer += 1
    //} catch {
      //  print("error!")
    
    
    }

}
    
    
    @IBAction func CloseWindow(_ sender: Any) {
        self.view.window?.close()
    }
    
}
    

 

