//
//  TAudioMainWnd.swift
//  TOOTutils
//
//  Created by thor on 5/3/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import SwiftUI
import AVFoundation


  var totalWavDatLen  = 0

struct TAudioMainWnd: View {
    
    let   audHandler = TAudioHandler()
    
    @State private var savePath = URL.userHomePath
    
    
    private var wavFifo : URL {
        URL.temporaryDirectory.appendingPathComponent("wavfifo.wav", conformingTo: .wav) 
    } 
    private var ma4Pathname : URL {
        let n = "rec" + Date.yyyyMMdd_HHmmss  +  ".m4a"
       
      return  URL.temporaryDirectory.appendingPathComponent(n, conformingTo: .mpeg4Audio)
    }
    
    var body: some View {
        VStack {
            Text("Audio functions Test....")
            #if os(macOS)
            Button("Select Folder"){
              //  print("URLHome ",URL.homeDirectory)
             let op = NSOpenPanel()
                op.directoryURL = NSURL.fileURL(withPath: URL.userHomePath, isDirectory: true)
                op.canChooseDirectories = true
                op.canChooseFiles = false
                op.title = "Select a folder for saving audio...."
                op.begin { resp in
                    if resp == NSApplication.ModalResponse.OK {
                        savePath = op.url?.path() ?? savePath
                    }
                }
            }.buttonStyle(.borderedProminent)
            #endif
            
            Text("Recoding save to : \(savePath)")
            
            Button("Create wav fifo"){
                
                Task{
                  await  testFifo()
                }
                
                print("create fifo done....")
                
            }.buttonStyle(.borderedProminent)
                .tint(.yellow)
            
            Button("check wav fifo"){
                let b = FileManager.default.isWritableFile(atPath: wavFifo.path())
                
                print("wavFifo is b " , b)
                
            }.buttonStyle(.borderedProminent)
                .tint(.red)
            
            Divider()
            
            Button("write bin from c to wav fifo"){
               
                testWriteFifo(wavFifo.path())
                
            }.buttonStyle(.borderedProminent)
                .tint(.red)   
            
            Button("write txt from UI to wav fifo"){
               
                testWriteFile()
                
            }.buttonStyle(.borderedProminent)
                .tint(.green)
            
            Divider()
             
            Button("Start test rec"){
                #if os(iOS)
            try?  audHandler.starRecM4a()
            try?  audHandler.starRecWav()
                #else
                totalWavDatLen = 0
                try?  audHandler.starRecM4a(ma4Pathname.path)
                try?  audHandler.starRecWav(/*savePath*/ wavFifo.path())
                #endif
            }.buttonStyle(.borderedProminent)
            // 
            Button("Stop test rec"){
                 audHandler.stopRecM4a()
                 audHandler.stopRecWav()
            }.buttonStyle(.borderedProminent)    
            
            Button("Test Write txt"){
                testWriteFile()
            }.buttonStyle(.borderedProminent)
            
            Divider()
            
            Button("Eskimo says call swift from c"){
                SomeCLibSetup(&callbacks)
                SomeCLibTest()
            }.buttonStyle(.borderedProminent)
            
        }
        .onDisappear(){
            print("audio wnd disappear....")
        }
    }
     
    
    func testWriteFile() {
        
        do {
          //  try  "TOOT some text write to documentDir..222222..".write(to: <#T##URL#>, atomically: <#T##Bool#>, encoding: <#T##String.Encoding#>)
            print("SwiftUI do try write to fifo......")
          try  "tvar myDat = Date()".data(using: .utf8)?.write(to: wavFifo)
            
           
            
//            let recFolder = docPath.appendingPathComponent("recFiles", conformingTo: .directory)
//            try FileManager.default.createDirectory(at: recFolder, withIntermediateDirectories: true, attributes: nil)
//            try "rec file data cnt here....".write(to: recFolder.appendingPathComponent("recFile", conformingTo: .wav), atomically: true, encoding: .utf8)
            
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testFifo() async {
        createFifoFile(wavFifo.path())
    }
    
}


public extension Date {
    static var yyyyMMdd_HHmmss : String {
        let dtFmt = DateFormatter()
        dtFmt.dateFormat = "yyyyMMdd_HHmmss"
        return  dtFmt.string(from: Date())
    }
}




public extension URL {
    #if os(macOS)
    static var userHome : URL   {
        URL(fileURLWithPath: userHomePath, isDirectory: true)
    }
    
    static var userHomePath : String   {
        let pw = getpwuid(getuid())

        if let home = pw?.pointee.pw_dir {
            return FileManager.default.string(withFileSystemRepresentation: home, length: Int(strlen(home))) + "/"
        }
        
        fatalError()
    }
    #else
    
    static var userHome : URL   {
       // URL.documentsDirectory
        URL.temporaryDirectory
    }
    
    static var userHomePath : String   {
        return userHome.absoluteString
    }
    #endif
}
  
   
private func printGreeting(modifier: UnsafePointer<CChar>) {
    print("Hello \(String(cString: modifier))World!")
}

var callbacks = SomeCLibCallbacks(
    printGreeting: { (modifier) in
        printGreeting(modifier: modifier)
    }
)

extension Data {
    var hexDescription: String {
        return reduce("") {$0 + String(format: "%02x", $1)}
    }
}
  

#Preview {
    TAudioMainWnd()
}




@_cdecl ("fifoWavByteArrArrived")
func fifoWavByteArrArrived(dat : UnsafePointer<UInt8>! , len : Int32) {
    totalWavDatLen += Int(len)
    print("len: \(len) , totalWavDatLen: \(totalWavDatLen)"  )
    //print(dat)
  //  print("====================")
    
    var myDat = Data()
    myDat.append(dat, count:  Int(len))
    
   // let str = String(bytes: myDat, encoding: .utf8)
   // print(str)
   // print(myDat.hexDescription)
    print("========Done============")
}




@_cdecl ("toottestfun")
func sumtoot(x : UInt32) {
    print("swift output x: " , x)
     
    
}
