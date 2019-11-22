//
//  OhausScale.swift
//  ProductView
//
//  Created by chris rahn on 11/22/19.
//  Copyright © 2019 chris rahn. All rights reserved.
//
import Cocoa
import CoreBluetooth

let OhausScaleServiceCBUUID = CBUUID(string: "2456e1b9-26e2-8f83-e744-f34f01e9d701")
let OhausScaleCharacteristicCBUUID = CBUUID(string: "2456e1b9-26e2-8f83-e744-f34f01e9d703")
let CBUUIDClientCharacteristicConfigurationString: String = "00002902-0000-1000-8000-00805f9b34fb"

class OhausScale: NSObject {
    
    var centralManager: CBCentralManager!
    var scalePeripheral: CBPeripheral!
    var selectedCharacteristic:CBCharacteristic? = nil
    var logWindowController:NSWindowController? = nil
    var scaleCounter = 0
    var hexStringString:String? = nil

    func scaleBegin() ->String{
        centralManager = CBCentralManager(delegate: self, queue: nil)
        return "Scale is disconnected"
    }
}


extension OhausScale: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            case .unknown:
            print("unknown")
        case .resetting:
            print("resetting")
        case .unsupported:
            print("unsupported")
        case .unauthorized:
           print("unauthorized")
        case .poweredOff:
            print("poweredOff")
        case .poweredOn:
            print("poweredOn")
             //centralManager.scanForPeripherals(withServices: nil)
            centralManager.scanForPeripherals(withServices: [OhausScaleServiceCBUUID])
        @unknown default:
            print("default_error")
        }
    }


}
