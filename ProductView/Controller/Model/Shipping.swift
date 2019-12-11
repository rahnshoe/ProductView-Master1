//
//  Shipping.swift
//  ProductView
//
//  Created by chris rahn on 12/10/19.
//  Copyright © 2019 chris rahn. All rights reserved.
//

import Foundation
import Cocoa

protocol ShipData  {
    func displayShipping(shipCode: String, ShipPrice: String)
}
 
class Shipping: NSObject {
    
    
    var shipDataDelegate: ShipData?
    
    //var weight = 1
    
    let fourNNShipping = 1001736
    let sixNNShipping = 851453
    let nineNNShipping = 912425
    
    func calculateShipping () {
        //if weight >= 1{
          //  shipping.stringValue = sixNNShipping
          //  shipDataDelegate?.displayShipping(shipCode: <#T##String#>, ShipPrice: <#T##String#>)
        }
        
    }
    

