//
//  TMqttMainWnd.swift
//  TOOTutils
//
//  Created by thor on 3/2/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import SwiftUI

import Combine
import CocoaMQTT
#if os(macOS)
import AppKit
#endif


struct TMqttMainWnd: View {
    
    //private var mqttMod = TMqttModel()
    
   @State  private var currMqtt : CocoaMQTT5? = nil
    
    
    @State private var mqttConnState = CocoaMQTTConnState.disconnected
    
    
    @State private var logStrStream : String = ""
    private let logTeMaxCnt = 2048
    
    //MARK: -
    @State private var mqttHostStr = "testemqx.langrensha.game"
    @State private var mqttPortStr = "31883"
    @State private var mqttUserStr = "testmqtt_langrensha"
    @State private var mqttPwdStr = "ErZDb07XXfZMlk7"
    
    
    @State private var mqttTopicStr = "lrs-room-02"
    
    
    //MARK: -
    
    @State private var sendCntStr = ""
    
    
   //@State
    private let lampCmdPubOjb = PassthroughSubject<[String] , Never>()
   // @State private var lampCmdCancelable : AnyCancellable? = nil
    
 
//#if os(iOS)
//print(UIDevice.current.identifierForVendor?.uuidString ?? "" )
//#endif
//print( String(ProcessInfo().processIdentifier))

    
    var body: some View {
        ScrollView {
            
            GroupBox("Login Info") {
 
                
                HStack {
                    LabeledContent {
                        TextField("", text: $mqttHostStr)
                    } label: {
                        Text("Mqtt Host")
                    }
                    LabeledContent {
                        TextField("", text: $mqttPortStr)
                    } label: {
                        Text("Port")
                    }
                }
                 
                HStack {
                    LabeledContent {
                        TextField("", text: $mqttUserStr)
                    } label: {
                        Text("Username")
                    }
                    LabeledContent {
                        TextField("", text: $mqttPwdStr)
                    } label: {
                        Text("Password")
                    }
                }
                
                
                
             //   Button(isConnected ? "Disconnect Mqtt" : "Connect Mqtt"){
                Button {
                    if mqttConnState == .disconnected {
                        setupMqttConn()
                    }else if mqttConnState == .connected {
                         currMqtt?.disconnect()
                         logInfo("Mqtt disconnected from server....")
                    }
     
                   // print( String(ProcessInfo().processIdentifier))
                   
                } label: {
                    HStack {
                        if mqttConnState == .connecting {   ProgressView().frame( height: 20 ) }
                        Text(mqttConnState == .disconnected ? "Connect to Server" : "Disconnect from server")
                            .frame(height: 24)
                    }
                }
                .buttonStyle(.bordered)
                .disabled(mqttConnState == .connecting)
                
            }
             
            GroupBox("Lamp Controller") {
                FlowLayout {
                    ForEach( 1...4 , id: \.self) { it in
                        TLampCmdWid(otherPubObj: lampCmdPubOjb , thizIdx: it)
                    }
                    
                }
            }
            
            
            GroupBox("Send") {
                
                HStack {
                    LabeledContent {
                        TextField("", text: $sendCntStr , axis: .vertical)
                            .lineLimit(1...4)
                          
                    } label: {
                        Text("Mqtt Data")
                    }
                    
                    VStack {
 
                        
                        Button{
                            
//                            let subject = Just<Int>(12)
//
//                            // Attach to listen to that value and process it
//                            let cancellable = subject.sink(
//                               // This is the first time completion is being mentioned.
//                               // More on that after this block
//                               receiveCompletion: { _ in
//                                   print("Publisher completed")
//                               }, receiveValue: { value in // This is where the value gets send to
//                                   print("\(value)")
//                               }
//                            )
                          
                            
                            
//
//                            let subject = CurrentValueSubject<Int, Never>(30)
//
//
//
//                            let cancellable = subject.sink(
//                               receiveCompletion: { _ in
//                                   print("Publisher completed")
//                               }, receiveValue: { value in
//                                   print("\(value)")
//                               }
//                            )
//
//
//                            subject.send(completion: .finished)

                           
                            
                            
//                            let subject = CurrentValueSubject<Int, Never>(0)
//
//                            // Then we attach a lister to it.
//                            // However, this time it comes with the completion closure
//                            let cancellable = subject.sink(
//                               receiveCompletion: { _ in
//                                   print("Publisher completed")
//                               }, receiveValue: { value in
//                                   print("\(value)")
//                               }
//                            )
//
//                            subject.send(completion: .finished)
//                            subject.send(10)
                            
//
//                            let pubSub = PassthroughSubject< [Int] , Never> (  )
//
//                            let listener = pubSub.sink { _ in
//                                print("listening done.....")
//                            } receiveValue: { val in
//                               let _ = val.map { val in
//                                    print(val)
//                                }
//
//                            }
//
//                            pubSub.send([12,33,45,66])
//
                            
                            if sendCntStr.isEmpty,
                               mqttConnState != .connected
                            {
                                return
                            }
                            
                            let rtnVal = currMqtt?.publish(mqttTopicStr , withString: sendCntStr , qos: .qos2 ,DUP: false,  properties: MqttPublishProperties() )
                             
                            logInfo("Send: \(sendCntStr) -> rtnVal: \(String(describing: rtnVal))"    )
                            
                        } label: {
                            Text("Send")
                                .font(.title2)
                                     .padding(10)
                                     .foregroundColor(.white)
                                     .background(.green)
                                     .cornerRadius(8)
                        }
                        .controlSize(.mini)
                        .buttonStyle(.plain)
                        .disabled(mqttConnState != CocoaMQTTConnState.connected)
                        
//                        Button{
//                            logInfo("test...\n")
//                        } label: {
//                            Text("Repeat Send")
//                                .font(.subheadline)
//                                .padding(.horizontal , 6)
//                                     .foregroundColor(.white)
//                                     .background(.green.opacity(0.5))
//                                     .cornerRadius(6)
//                        }
//                        .controlSize(.mini)
//                        .buttonStyle(.plain)
                        
                        
                        
//                        Button("Repeat Send"){
//
//                            logInfo("test")
//
//                        }.frame(minWidth: 120)
//                        .padding()
//                            .buttonStyle(.bordered)
                        
                        
                    }
                     
                  
                }
                
            }
        
            GroupBox("Log") {
                
                TextEditor(text: .constant( logStrStream) )
                    .frame(minHeight: 100)
                    .onReceive(Just(logStrStream)){   _ in
                        if logStrStream.count > logTeMaxCnt {
                            logStrStream = String(logStrStream.prefix(logTeMaxCnt))
                        }
                    }
                
                
                
                Button("Clean Log"){
                  
                    logStrStream = ""
                      
                }.padding()
                    .buttonStyle(.bordered)
                   
                 
                
            }
            
            
             
        }
       
#if os(iOS)
        .onTapGesture {
            hideKb()
        }
#endif
        .navigationTitle("Mqtt Utility")
        .frame(maxWidth: .infinity )
        .onReceive(lampCmdPubOjb, perform: { valLs in
            
            var str = "{ lampId: \"\(valLs[0])\", LampColor: \"\(valLs[1])\" }"
            
//            let _ = valLs.map { val in
//               // print(val)
//                str = "{lampId: \( }"
//            }
//
            sendCntStr = str
            
            
        })
        
        
    }
    
    
    private func mqttConnStateChged( _ : CocoaMQTT5, state:  CocoaMQTTConnState) {
        logInfo( "Mqtt " + state.description)
        mqttConnState = state
        if mqttConnState == .connected {
            Task{
                currMqtt?.subscribe(mqttTopicStr, qos: .qos1)
            }
        }
    }
    
    private func recPong(mqtt: CocoaMQTT5 ) {
       // print("rec pong....")
    }
    
    private func recMsg ( thizmqtt: CocoaMQTT5, msg : CocoaMQTT5Message, q : UInt16, dp :MqttDecodePublish?) {
        
        if let str = msg.string {
            logInfo("Svr msg: " + str)
        }
        
       // print(msg.string ?? "no msg....")
        
    }
    
     
    private  func setupMqttConn()   {
        
        
#if os(macOS)
        let osType = "Mac"
 #else
        let osType = "iOS"
#endif
        
        let idStr   = "Lrs_" + osType + "_" +  String( NSUUID().uuidString.replacingOccurrences(of: "-", with: "").prefix(16) )
        
        currMqtt = CocoaMQTT5(clientID: idStr, host: "testemqx.langrensha.game", port: 31883)
        
        guard let currMqtt = currMqtt else {
            logInfo("Failed to instance CocoaMQTT5 obj....")
            return
        }
 
        
        let connectProperties = MqttConnectProperties()
        connectProperties.topicAliasMaximum = 0
        connectProperties.sessionExpiryInterval = 0
        connectProperties.receiveMaximum = 100
        connectProperties.maximumPacketSize = 500
        currMqtt.connectProperties = connectProperties
        
        
        let lastWillMessage = CocoaMQTT5Message(topic: "/will", string: "dieout....")
        lastWillMessage.contentType = "JSON"
        lastWillMessage.willExpiryInterval = .max
        lastWillMessage.willDelayInterval = 0
        lastWillMessage.qos = .qos1
        currMqtt.willMessage = lastWillMessage
        

        currMqtt.username = "testmqtt_langrensha"
        currMqtt.password = "ErZDb07XXfZMlk7"
      
        currMqtt.keepAlive = 30
        
         
       let isOk = currMqtt.connect()
        
    
        
        print("Start connect to mqtt server....")
        
        
        if isOk {
            
           // currMqtt.subscribe(mqttTopicStr, qos: .qos1)
            
            currMqtt.didReceivePong = recPong
            
            currMqtt.didReceiveMessage = recMsg
            currMqtt.didChangeState  = mqttConnStateChged
            
            
        }
        
        
    }
    
    
    private func logInfo(_ info : String) {
       let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .medium
        
        
        logStrStream.append( df.string(from: .now) + ": " +  info + "\n")
        
    }
    
}

#if os(iOS)
extension View {
  func hideKb() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}
#endif



#Preview {
  //  TMqttMainWnd(mqttLib: CocoaMQTT5(clientID: "TOOTzoeMqtt",host: "broker.emqx.io", port: 1883))
    TMqttMainWnd()
}
