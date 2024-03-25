//
//  TBleMainWnd.swift
//  TOOTutils
//
//  Created by thor on 24/2/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import SwiftUI
import CoreBluetooth







struct TBleMainWnd: View {
    
    
    
    let blm = TBleCoordinator.thizInst
    
    
    
    
    var body: some View {
        
        
        VStack {
            
            
            HStack {
                
                Button("Scan Ble"){
                   
                    blm.doScan()
                }
                .buttonStyle(.borderedProminent)
                
                
                    Button("Ble Stop Scan"){
                   
                    blm.doStopScan()
                }
                .buttonStyle(.borderedProminent)
                
                 
            }
            
            
            
        }
        
        
    }
    
    
    
    
    
}










#Preview {
    TBleMainWnd()
}
