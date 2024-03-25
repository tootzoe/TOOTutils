//
//  TAudioHandlerMac.swift
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
    
    
    override init() {
        super.init()
//        print("++++++++++++++++++")
//       print(URL.currentDirectory())
//       print(URL.temporaryDirectory)
//       print(URL.cachesDirectory)
//       print("----")
//       print(URL.applicationDirectory)
//       print(URL.libraryDirectory)
//       print(URL.userDirectory)
//       print("----")
//       print(URL.documentsDirectory)
//       print(URL.downloadsDirectory)
//       print("++++++++++++++++++")
 
       
        
    }
    
   
    public func starRecM4a(_ fpath: String) throws {
        
        let fn = fpath // "/Users/thor/rec20240311_134304.m4a" // fpath + "rec" + Date.yyyyMMdd_HHmmss  +  ".m4a"
       
        print("M4a recording....\(fn)")
        
  
        let settings : [String : Any] = [AVFormatIDKey : kAudioFormatMPEG4AAC ,
                        AVSampleRateKey: 12000,
                 AVNumberOfChannelsKey : 2,
               AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        audioM4aDev = try AVAudioRecorder(url: URL(string: fn)!, settings: settings)
        audioM4aDev?.delegate = self
        audioM4aDev?.prepareToRecord()
        
        audioM4aDev?.record()
         
        print("M4a start recording  ....")
    }
    
    public func starRecWav(_ fpath: String) throws {
        
        let fn = fpath // "/Users/thor/rec20240311_134305.wav" //  fpath + "rec" + Date.yyyyMMdd_HHmmss  +  ".wav"
       
        print("Wav recording at: \(fn)")
        
 
        
        let settings : [String : Any] = [AVFormatIDKey : kAudioFormatLinearPCM ,
                        AVSampleRateKey: 12000,
                 AVNumberOfChannelsKey : 2,
             
        ]
        
        audioWavDev = try AVAudioRecorder(url: URL(string: fn)!, settings: settings)
        audioWavDev?.delegate = self
        audioWavDev?.prepareToRecord()
        
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


