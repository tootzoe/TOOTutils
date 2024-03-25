//
//  TMulticastMainWnd.swift
//  TOOTutils
//
//  Created by thor on 18/2/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import SwiftUI
import Network



struct TMulticastMainWnd: View {
    
    @State private var myCg : NWConnectionGroup? = nil
    
    @State private var hzf  = 0
    
    @State private var recMsg = ""
    
    
    var body: some View {
        
        
        
        VStack {
            
             
            Text("Multicast test....")
             
            Button("Start Multicast....."){
                startMulticast()
            }
            .buttonStyle(.borderedProminent)
            
            Divider()
            
            
            Button(" Multicast test send....."){
                testMulticastSend("toot send num: \(hzf)" )
                hzf = hzf + 1
            }
            .buttonStyle(.borderedProminent)
            
            
            TextEditor(text: $recMsg )
                .frame(minHeight: 100)
            
            Button("Clean log"){
                recMsg = ""
            }
            
        }
        
         
        
    }
    
    
    
    
    
    
    func startMulticast()  {
        
//        guard let mc = try? NWMulticastGroup(for: [.hostPort(host: "224.0.0.241", port: 5853)]) else {
//            fatalError("multicast Group error....")
//        }  
        guard let mc = try? NWMulticastGroup(for: [.hostPort(host: "239.1.1.1", port: 9004)]) else {
            fatalError("multicast Group error....")
        }
        
        let gp = NWConnectionGroup(with: mc, using: .udp)
        
        gp.setReceiveHandler(maximumMessageSize: 2048, rejectOversizedMessages: true) { message, content, isComplete in
            print("Got msg from \(String(describing: message.remoteEndpoint))")
            
            print("msg: \(String(describing: content))")
            
            let str = "Got msg from: \(String(describing: message.remoteEndpoint)) --\n\(String(decoding: content!  , as: UTF8.self))"
            
            recMsg.append(str + "\n")
            
            // quick reply msg
          //  let sendMsg = Data("This is reply msg ....".utf8)
          //  message.reply(content: sendMsg)
        }
        
        gp.stateUpdateHandler = { nstate in
            print("gp enter state: \(nstate)")
            print("conn state: \(gp.state)")
            
            
            
        }
        
        gp.start(queue: .main)
        
        print("multicast started.........")
        
        myCg = gp
        
        
        #if false
        let sendMsg = Data("my send msg here....".utf8)
        gp.send(content: sendMsg) { error in
            print("gp send complete with Err: \(error)")
        }
        #endif
        
        
    }
    
    func testMulticastSend(_ str : String)  {
        
        let sendMsg = Data(str.utf8)
        myCg?.send(content: sendMsg) { error in
            print("gp send complete with Err: \(String(describing: error))")
        }
        
        print("testMulticastSend done....")
        
        
        // when you’re done with the NWConnectionGroup, cancel it to clean up any associated state.
        
       // myCg?.cancel()
    }
    
    
    
}

#Preview {
    TMulticastMainWnd()
}
