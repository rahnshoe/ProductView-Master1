////
////  ViewController.swift
////  OHAUS
////
////  Created by chris rahn on 9/21/19.
////  Copyright © 2019 chris rahn. All rights reserved.
////
//
////import Cocoa
////import CoreBluetooth
////
////let OhausScaleServiceCBUUID = CBUUID(string: "2456e1b9-26e2-8f83-e744-f34f01e9d701")
////let OhausScaleCharacteristicCBUUID = CBUUID(string: "2456e1b9-26e2-8f83-e744-f34f01e9d703")
////let CBUUIDClientCharacteristicConfigurationString: String = "00002902-0000-1000-8000-00805f9b34fb"
//
///class OhausViewController: NSViewController {
//
//    var centralManager: CBCentralManager!
//    var scalePeripheral: CBPeripheral!
//    var selectedCharacteristic:CBCharacteristic? = nil
//    var logWindowController:NSWindowController? = nil
//    var counter = 0
//    var hexStringString:String? = nil
//
//    @IBOutlet weak var weightDisplay: NSTextField!
//    @IBOutlet weak var scaleStatus: NSTextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        scaleStatus.stringValue = "Scale is disconnected"
//        centralManager = CBCentralManager(delegate: self, queue: nil)
//        }
//
//    func appendRead(_ characteristic:CBCharacteristic) {
//        appendCharacteristicOperation(characteristic, operationType: .Read)
//    }
//
//           private func appendCharacteristicOperation(_ characteristic:CBCharacteristic, operationType:OperationType, data: Data? = nil) {
//            let data = data ?? characteristic.value ?? Data()
//            if counter < 2 {
//            counter += 1
//        let hexString = data.hexString
//            hexStringString = String(hexString)
//        let mutableMultilineString = hexStringString
//                if counter > 1 {
//                let startingIndex = mutableMultilineString!.index(mutableMultilineString!.startIndex, offsetBy: 4)
//                    let endingIndex = mutableMultilineString!.index(mutableMultilineString!.startIndex, offsetBy: 34)
//                let range = startingIndex..<endingIndex
//                    let substring1 = mutableMultilineString!.substring(with: range)
//                print("substring1: \(substring1)")
//             weightDisplay.stringValue = hexStringtoAscii(substring1)
//                 } else {
//                    return
//                }
//            } else {
//                counter = 1
//            }
//        }
//    }
//
//    func hexStringtoAscii(_ hexString : String) -> String {
//
//        let pattern = "(0x)?([0-9a-f]{2})"
//        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
//        let nsString = hexString as NSString
//       // print(nsString.length)
//        let matches = regex.matches(in: hexString, options: [], range: NSMakeRange(0, nsString.length))
//        let characters = matches.map {
//            Character(UnicodeScalar(UInt32(nsString.substring(with: $0.range(at: 2)), radix: 16)!)!)
//        }
//        return String(characters)
//    }
//
//    func hexToString(hex: String) -> String? {
//        guard hex.count % 2 == 0 else {
//            return nil
//        }
//
//        var bytes = [CChar]()
//
//        var startIndex = hex.index(hex.startIndex, offsetBy: 0)
//        while startIndex < hex.endIndex {
//            let endIndex = hex.index(startIndex, offsetBy: 2)
//            let substr = hex[startIndex..<endIndex]
//
//            if let byte = Int8(substr, radix: 16) {
//                bytes.append(byte)
//            } else {
//                return nil
//            }
//
//            startIndex = endIndex
//        }
//
//        bytes.append(0)
//        return String(cString: bytes)
//    }
//
//extension OhausViewController: CBCentralManagerDelegate {
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        switch central.state {
//            case .unknown:
//            print("unknown")
//        case .resetting:
//            print("resetting")
//        case .unsupported:
//            print("unsupported")
//        case .unauthorized:
//           print("unauthorized")
//        case .poweredOff:
//            print("poweredOff")
//        case .poweredOn:
//            print("poweredOn")
//             //centralManager.scanForPeripherals(withServices: nil)
//            centralManager.scanForPeripherals(withServices: [OhausScaleServiceCBUUID])
//        @unknown default:
//            print("default_error")
//        }
//    }
//
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
//                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
//        scalePeripheral = peripheral
//        scalePeripheral.delegate = self
//        centralManager.stopScan()
//        centralManager.connect(scalePeripheral)
//    }
//
//    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//        print("Connected!")
//        scalePeripheral.discoverServices([OhausScaleServiceCBUUID])
//    }
//
//}
//
//extension OhausViewController: CBPeripheralDelegate {
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
//        guard let services = peripheral.services else { return }
//        for service in services {
//            //print(service)
//            peripheral.discoverCharacteristics([OhausScaleCharacteristicCBUUID], for: service)
//            }
//    }
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
//                error: Error?) {
//    guard let characteristics = service.characteristics else { return }
//
//  for characteristic in characteristics {
//
//        //Once found, subscribe to the this particular characteristic...
//        peripheral.setNotifyValue(true, for: characteristic)
//        // We can return after calling CBPeripheral.setNotifyValue because CBPeripheralDelegate's
//        // didUpdateNotificationStateForCharacteristic method will be called automatically
//        peripheral.readValue(for: characteristic)
//        peripheral.discoverDescriptors(for: characteristic)
//    }
//}
//    // Getting Values From Characteristic
//
//    /*After you've found a characteristic of a service that you are interested in, you can read the characteristic's value by calling the peripheral "readValueForCharacteristic" method within the "didDiscoverCharacteristicsFor service" delegate.
//     */
//    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
//    appendRead(characteristic)
//    }
//
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
//        print("********************************")
//}
//
//    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?){
//        if (error != nil) {
//            print("Error changing notification state:\(String(describing: error?.localizedDescription))")
//            } else {
//        }
//        if (characteristic.isNotifying) {
//            print ("Subscribed. Notification has begun for: \(characteristic.uuid)")
//            scaleStatus.stringValue = "Scale is Connected"
//            selectedCharacteristic = characteristic
//        }
//    }
//}
//
//func log(_ message:String, file:String = #file, line:Int = #line, functionName:String = #function) {
//    }
//
//private enum OperationType : String {
//    case Read, Write
//}
//
//private struct LogEntry {
//    let serviceUUID:String
//    let charUUID:String
//    let operation:OperationType
//    let data:String
//    let timestamp:Date
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
