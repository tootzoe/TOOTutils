//
//  TLive555MainWnd.swift
//  TOOTutils
//
//  Created by thor on 16/3/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import SwiftUI








 


struct TLive555MainWnd: View {
     
    @State private var mediaFolderPath = URL.documentsDirectory.path()
    
    var body: some View {
        VStack {
             
            Text("ខ្ញុំគេជាខ្មែរ។៕ ").font(.system(size: 32))
            Text("ខ្ញុំគេជាខ្មែរ។៕")
                .font(  FontFamily.KhmerOSMoul.regular.swiftUIFont(size: 32) )
            Text("ខ្ញុំគេជាខ្មែរ។៕")
                .font(  FontFamily.KhBattambang.regular.swiftUIFont(size: 32) )     
            Text("ខ្ញុំគេជាខ្មែរ។៕")
                .font(  FontFamily.KhmerOSDangrek.regular.swiftUIFont(size: 32) )
            
            Text(TL.tootStr2)
            
            Image(asset: Asset.trees)
            
            #if os(macOS)
            Button("Select MediaFolder"){
                
                 let op = NSOpenPanel()
                op.directoryURL = URL.documentsDirectory
                
                op.canChooseDirectories = true
                op.canChooseFiles = false
                op.title = "Select a folder contains medial files...."
                op.begin { rsl in
                    if rsl.rawValue == NSApplication.ModalResponse.OK.rawValue {
                        mediaFolderPath = op.url?.path() ?? mediaFolderPath
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            #endif
            
            Button("Start Live555 Media Server"){
                
                startLive555Svr(mediaFolderPath)
                     
            }.buttonStyle(.borderedProminent)
        }
        .onDisappear(perform: {
            print("stopLive555Server....")
            stopLive555Server( )
        })
        
        
    }
    
    private func startLive555Svr(_ folderPath :String) { 
        
        DispatchQueue.global().async {
            startMediaSrv(folderPath)
        }
        
    }
    
    
}

#Preview {
    TLive555MainWnd()
}









