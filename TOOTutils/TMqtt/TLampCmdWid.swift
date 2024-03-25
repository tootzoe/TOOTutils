//
//  TLampCmdWid.swift
//  TOOTMqttMac
//
//  Created by thor on 4/2/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import SwiftUI
import Combine



struct TLampCmdWid: View {
    
  
    public let otherPubObj : PassthroughSubject<[String] , Never>
    public let thizIdx : Int
    
    @State private var brightnessVal : Int = 100
    
    
 
    @State private var isOnRed = false
    @State private var isOnGreen = false
    @State private var isOnBlue = false
    @State private var bgCr = Color.black
    
    @State private var crBits : UInt8 = 0
    
    private let crLs : [Color] = [
        .black,
        .red,
        .green,
            .yellow, // 3
        .blue,
        .purple,
            .cyan,
        .white
    ]
    
    var body: some View {
        
        
        ZStack {
            
            bgCr
            
            VStack {
                HStack (spacing: 0 ){
                    Button {
                        isOnRed.toggle()
                        updColor()
                    } label: {
                        Text("R")
                            .font(.subheadline)
                            .padding(.horizontal, 3)
                             
                            .overlay {
                                
                                Circle()
                                    .stroke(lineWidth: 1.6)
                                 
                                    
                            }.foregroundColor(.red)
                    }
                    .background( isOnRed ? .black : .clear)
                    .buttonStyle(.bordered)
                    .controlSize(.mini)
                      
                    Button {
                        isOnGreen.toggle()
                        updColor()
                    } label: {
                        Text("G")
                            .font(.subheadline)
                            .padding(.horizontal, 3)
                             
                            .overlay {
                                
                                Circle()
                                    .stroke(lineWidth: 1.6)
                                 
                                    
                            }.foregroundColor(.green)
                    }
                    .background( isOnGreen ? .black : .clear)
                    .buttonStyle(.bordered)
                    .controlSize(.mini)
                    
                   Button {
                       isOnBlue.toggle()
                       updColor()
                       
                    } label: {
                        Text("B")
                            .font(.subheadline)
                            .padding(.horizontal, 3)
                             
                            .overlay {
                                
                                Circle()
                                    .stroke(lineWidth: 1.6)
                                 
                                    
                            }.foregroundColor(.blue)
                    }
                    .background( isOnBlue ? .black : .clear)
                    //.border(.blue)
                    .buttonStyle(.bordered)
                     
                    .controlSize(.mini)
                     
                    
                }
                 
                
                Picker("Bri" , selection: $brightnessVal){
                    
                    ForEach( 1...100 , id: \.self ) { v in
                        Text("\(v)").tag(v)
                    }
                    
                   
                    
                }

                
            }
        }
        
    }
    
    private func updColor() {
      
        // otherPubObj .send([11,44,55])
        
        let r = isOnRed ?  (1 << 0) : 0
        let g = isOnGreen ? (1 << 1) : 0
        let b = isOnBlue ? (1 << 2) : 0
        
        crBits = UInt8(r | g | b)
        
        bgCr = crLs[Int(crBits)]
        
       // print(bgCr.description)
        
        otherPubObj.send(["\(thizIdx)" , bgCr.description])
        
    }
    
}

#Preview {
    TLampCmdWid(otherPubObj: PassthroughSubject<[String] , Never>(), thizIdx: 0 )
}
