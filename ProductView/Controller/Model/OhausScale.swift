//
//  Ohaus.swift
//  protocols and delegates
//
//  Created by chris rahn on 11/23/19.
//  Copyright © 2019 chris rahn. All rights reserved.
//

import Cocoa
import CoreBluetooth

protocol ScaleData {
    func displayWeight(weight: String, lbs: Int, ounces: Int, ounceFraction: Int) 
   // func displayWeight(weight: String)
    
}

protocol ScaleStatus {
    func displayScaleStatus(status: String)
}

let OhausScaleServiceCBUUID = CBUUID(string: "2456e1b9-26e2-8f83-e744-f34f01e9d701")
let OhausScaleCharacteristicCBUUID = CBUUID(string: "2456e1b9-26e2-8f83-e744-f34f01e9d703")
let CBUUIDClientCharacteristicConfigurationString: String = "00002902-0000-1000-8000-00805f9b34fb"


var tempWeight: String?
var lbs: Int?
var ounces: Int?
var ounceFraction: Int?

class OhausScale: NSViewController {
    var scaleDelegate: ScaleData?
    var scaleStatusDelegate: ScaleStatus?


    var counter = 0
    var centralManager: CBCentralManager!
    var scalePeripheral: CBPeripheral!
    var selectedCharacteristic:CBCharacteristic? = nil
    var logWindowController:NSWindowController? = nil
    var scaleCounter = 0
    var hexStringString:String? = nil
    var scaleStatus: String?


    func scaleBegin() ->String{
        centralManager = CBCentralManager(delegate: self, queue: nil)
        return "Scale is disconnected"
    }
    
     func appendRead(_ characteristic:CBCharacteristic) {
            appendCharacteristicOperation(characteristic, operationType: .Read)
        }
    
    func appendCharacteristicOperation(_ characteristic:CBCharacteristic, operationType:OperationType, data: Data? = nil) {
        var data: Data?
        data = data ?? characteristic.value ?? Data()
        print("data \(String(describing: data))")
                if counter < 2 {
                counter += 1
            let hexString = data!.hexString
                hexStringString = String(hexString)
                    print(hexString)
            let mutableMultilineString = hexStringString
                    
                    print("hexString: \(hexString)")
                    
                    if counter > 1  && hexString.count == 40 {
                        //                    let startingIndex = mutableMultilineString!.index(mutableMultilineString!.startIndex, offsetBy: 6)
                        //                        let endingIndex = mutableMultilineString!.index(mutableMultilineString!.startIndex, offsetBy: 23)
                        //                    let range = startingIndex..<endingIndex
                        //                        let substring1 = mutableMultilineString!.substring(with: range)
                        
                        var substr = mutableMultilineString!.dropFirst(6)
                        substr = substr.dropLast(6)
                        let substring1 = String(substr)
                        
                        //                        let startingIndex1 = mutableMultilineString!.index(mutableMultilineString!.startIndex, offsetBy: 6)
                        //                            let endingIndex1 = mutableMultilineString!.index(mutableMultilineString!.startIndex, offsetBy: 8)
                        //                        let range1 = startingIndex1..<endingIndex1
                        //                            let substring2 = mutableMultilineString!.substring(with: range1)
                        var substr2 = mutableMultilineString!.dropFirst(6)
                        substr2 = substr2.dropLast(32)
                        let substring2 = String(substr2)
                        
                        //print("substring2: \(substring2)")
                        let tempWeight1 = hexStringtoAscii(substring2)
                        // print("tempweight1: \(tempWeight1)")
                        lbs = Int(tempWeight1)
                        
                        
                        //                        let startingIndex2 = mutableMultilineString!.index(mutableMultilineString!.startIndex, offsetBy: 10)
                        //                        let endingIndex2 = mutableMultilineString!.index(mutableMultilineString!.startIndex, offsetBy: 14)
                        //                        let range2 = startingIndex2..<endingIndex2
                        //                        let substring3 = mutableMultilineString!.substring(with: range2)
                        //
                        var substr3 = mutableMultilineString!.dropFirst(10)
                        substr3 = substr3.dropLast(26)
                        let substring3 = String(substr3)
                        
                        // print("substring3: \(substring3)")
                        let tempWeight2 = hexStringtoAscii(substring3)
                        // print("tempweight2: \(tempWeight2)")
                        ounces = Int(tempWeight2)
                        //  print("ounces: \(ounces!)")
                        
                        //                        let startingIndex3 = mutableMultilineString!.index(mutableMultilineString!.startIndex, offsetBy: 16)
                        //                        let endingIndex3 = mutableMultilineString!.index(mutableMultilineString!.startIndex, offsetBy: 22)
                        //                        let range3 = startingIndex3..<endingIndex3
                        //                        let substring4 = mutableMultilineString!.substring(with: range3)
                        
                        var substr4 = mutableMultilineString!.dropFirst(16)
                        substr4 = substr4.dropLast(20)
                        let substring4 = String(substr3)
                        
                        //print("substring4: \(substring4)")
                        let tempWeight3 = hexStringtoAscii(substring4)
                        //print("tempweight3: \(tempWeight3)")
                        ounceFraction = Int(tempWeight3)
                        // print("ounceFraction: \(ounceFraction!)")
                        
                        
                        print("substring1: \(substring1)")
                        tempWeight = hexStringtoAscii(substring1)
                        // print("tempweight: \(tempWeight)")
                        scaleDelegate?.displayWeight(weight: tempWeight!, lbs: lbs!, ounces: ounces!, ounceFraction: ounceFraction!)
                        
                    } else {
                        //  print("dataB4return: \(data)")
                        data = nil
                        // print("dataAfterreturn: \(data)")
                        return
                    }
                } else {
                    counter = 1
        }
        
    }
    
    
}

        func hexStringtoAscii(_ hexString : String) -> String {
    
            let pattern = "(0x)?([0-9a-f]{2})"
            let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let nsString = hexString as NSString
           // print(nsString.length)
            let matches = regex.matches(in: hexString, options: [], range: NSMakeRange(0, nsString.length))
            let characters = matches.map {
                Character(UnicodeScalar(UInt32(nsString.substring(with: $0.range(at: 2)), radix: 16)!)!)
            }
            return String(characters)
        }
    
        func hexToString(hex: String) -> String? {
            guard hex.count % 2 == 0 else {
                return nil
            }
    
            var bytes = [CChar]()
    
            var startIndex = hex.index(hex.startIndex, offsetBy: 0)
            while startIndex < hex.endIndex {
                let endIndex = hex.index(startIndex, offsetBy: 2)
                let substr = hex[startIndex..<endIndex]
    
                if let byte = Int8(substr, radix: 16) {
                    bytes.append(byte)
                } else {
                    return nil
                }
    
                startIndex = endIndex
            }
    
            bytes.append(0)
            return String(cString: bytes)
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
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                            advertisementData: [String: Any], rssi RSSI: NSNumber) {
            scalePeripheral = peripheral
            scalePeripheral.delegate = self
            centralManager.stopScan()
            centralManager.connect(scalePeripheral)
        }
    
        func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
            print("Connected!")
            scalePeripheral.discoverServices([OhausScaleServiceCBUUID])
        }

  }
    
    extension OhausScale: CBPeripheralDelegate {
        func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
            guard let services = peripheral.services else { return }
            for service in services {
                //print(service)
                peripheral.discoverCharacteristics([OhausScaleCharacteristicCBUUID], for: service)
                }
        }
        func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {
        guard let characteristics = service.characteristics else { return }
    
      for characteristic in characteristics {
    
            //Once found, subscribe to the this particular characteristic...
            peripheral.setNotifyValue(true, for: characteristic)
            // We can return after calling CBPeripheral.setNotifyValue because CBPeripheralDelegate's
            // didUpdateNotificationStateForCharacteristic method will be called automatically
            peripheral.readValue(for: characteristic)
            peripheral.discoverDescriptors(for: characteristic)
        }
    }
        // Getting Values From Characteristic
    
        /*After you've found a characteristic of a service that you are interested in, you can read the characteristic's value by calling the peripheral "readValueForCharacteristic" method within the "didDiscoverCharacteristicsFor service" delegate.
         */
        func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        appendRead(characteristic)
        }
    
        func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
            print("********************************")
    }
    
        func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?){
            if (error != nil) {
                print("Error changing notification state:\(String(describing: error?.localizedDescription))")
                } else {
            }
            if (characteristic.isNotifying) {
                print ("Subscribed. Notification has begun for: \(characteristic.uuid)")
 //*******      scaleStatus.stringValue = "Scale is Connected"
                scaleStatus = "Scale connected"
                print(scaleStatus!)
                  scaleStatusDelegate?.displayScaleStatus(status: scaleStatus!)
                selectedCharacteristic = characteristic
            }
        }
    }
    
    func log(_ message:String, file:String = #file, line:Int = #line, functionName:String = #function) {
        }
    

enum OperationType : String {
    case Read, Write
}

private struct LogEntry {
    let serviceUUID:String
    let charUUID:String
    let operation:OperationType
    let data:String
    let timestamp:Date
}

