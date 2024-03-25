//
//  TBleCoordinator.swift
//  TOOTutils
//
//  Created by thor on 24/2/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import Foundation
import CoreBluetooth




class TBleCoordinator: NSObject, CBCentralManagerDelegate,   CBPeripheralDelegate {
    
     private var blm : CBCentralManager? = nil
 
   static let thizInst : TBleCoordinator = TBleCoordinator()
    
    
  // static let `default` : TBleCoordinator = TBleCoordinator()
    
    override init() {
        super.init()
        
        print("blm init....")
        
       // self.blm = CBCentralManager(delegate: self, queue: nil)
    }
    
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        print(central.state.rawValue)
        
        if blm == central {
            print("Same bluetooth manager....")
        }
        
//        
//        if central.state == .poweredOn {
//            central.scanForPeripherals(withServices: nil)
//        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
       // print(peripheral.name)
        
        guard peripheral.name != nil else {return}
        
        print("-------------------------------------")
        print("found dev name : \(String(describing: peripheral.name))")
        print("UUID : \(String(describing: peripheral.identifier))")
        
    }
    
    
    func doScan() {
       // guard let blm = blm else {return}
        
        print("doScan........\(blm?.state.rawValue)")
        
        if blm?.state == .poweredOn {
            blm?.scanForPeripherals(withServices: nil )
        }
    }
    
    func doStopScan() {
        
        print("Stop Scan........\(blm?.state.rawValue)")
        
        blm?.stopScan()
    }
    
    
    
}





