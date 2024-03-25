//
//  TAudioHandler.swift
//  TOOTutils
//
//  Created by thor on 5/3/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import Foundation
import AVFoundation
 

class TAudioHandler : NSObject, ObservableObject , AVAudioRecorderDelegate {
    
    private var audioM4aDev : AVAudioRecorder?
    private var audioWavDev : AVAudioRecorder?
    private var recFolder : URL?
    
    private var isM4aSessOK = false
    
    private var testFM : FolderMonitor?
    
    
    override init() {
        super.init()
        setupFolderPath()
         print("++++++++++++++++++")
        print(URL.currentDirectory())
        print(URL.temporaryDirectory)
        print(URL.cachesDirectory)
        print("----")
        print(URL.applicationDirectory)
        print(URL.libraryDirectory)
        print(URL.userDirectory)
        print("----")
        print(URL.documentsDirectory)
        print(URL.downloadsDirectory)
        print("++++++++++++++++++")
  
        
 
    }
    
      func setupFolderPath() {
        let docPath = URL.userHome
        print(docPath)
       // print( URL.userHomePath)
         let tmpDir = docPath.appendingPathComponent("recFiles", conformingTo: .directory)
        var isDir : ObjCBool = true
        print(tmpDir.absoluteString)
        if !FileManager.default.fileExists(atPath: tmpDir.absoluteString, isDirectory: &isDir){
            print("recfilder not exist....")
            do {
            try   FileManager.default.createDirectory(at: tmpDir, withIntermediateDirectories: true, attributes: nil)
            }catch{
                fatalError(error.localizedDescription)
            }
        }
        
        var p = URL.homeDirectory.appendingPathComponent("test.txt", conformingTo: .text).absoluteString
        print("homeDirectory : ", p , FileManager.default.isWritableFile(atPath: p))
        
        p = URL.documentsDirectory.appendingPathComponent("test.txt", conformingTo: .text).absoluteString
        print("documentsDirectory : ", p , FileManager.default.isWritableFile(atPath: p))
        
        
       recFolder = tmpDir
        
        
    }
    
    
    public func setupAudioSession() throws {
        let audSess = AVAudioSession.sharedInstance()
        try audSess.setCategory(.playAndRecord, mode: .default)
        try audSess.setActive(true)
        isM4aSessOK = true
    }
     
    public func starRecM4a( ) throws {
        let recSett : [String : Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        if !isM4aSessOK {
            try setupAudioSession()
        }
         
        let fn =  "testM4a.m4a" // Date.yyyyMMdd_HHmmss
      
        
        let recFilename = recFolder?.appendingPathComponent("rec\(fn)", conformingTo: .mpeg4Audio)
        
        print(recFilename!)
        
      
        
        audioM4aDev = try AVAudioRecorder(url: recFilename!, settings: recSett)
        audioM4aDev?.prepareToRecord()  // this call will write file type header data to disk, here write m4a meta data to file (written file can be found)
        
        audioM4aDev?.record()
        print("M4a recording....")
        
         
         
    }
    
    func mfoder () {
        testFM = FolderMonitor(url: recFolder!)
        testFM?.folderDidChange =   {
            print("recFolder chged.....")
            
        }
        
        testFM?.startMonitoring()
    }
    
    
    public func starRecWav( ) throws {
        
        let fn =  "testWav.wav" // Date.yyyyMMdd_HHmmss
         
        print("Wav recording....")
        
        let recSett : [String : Any] = [
            AVFormatIDKey: kAudioFormatLinearPCM,
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 2,
           // AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        if !isM4aSessOK {
            try setupAudioSession()
        }
         
        
        URL.libraryDirectory
        
        let recFilename = recFolder?.appendingPathComponent("rec\(fn)", conformingTo: .wav)
        
        print(recFilename!)
        
      
        
        audioWavDev = try AVAudioRecorder(url: recFilename!, settings: recSett)
        audioWavDev?.prepareToRecord() // this call will write file type header data to disk, here write wav header data to file (written file can be found)
        
        audioWavDev?.record()
       
         
        print("Wav start recording  ....")
    }
    
    
  
    func stopRecM4a() {
        audioM4aDev?.stop()
        print("M4a recording stopped....")
    }
    
    func stopRecWav() {
        audioWavDev?.stop()
        print("Wav recording stopped....")
    }
    
      // MARK: -
      
      public func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
          print("Audio recofing done........")
      }
      
      public func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
          print("audio recording error: " , error?.localizedDescription ?? "")
      }
      
}







