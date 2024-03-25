//
//  ContentView.swift
//  TOOTutils
//
//  Created by thor on 1/2/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import SwiftUI
#if os(iOS)
import UIKit
#endif


struct ContentView : View {
     
    
    private let btnLabelStrLs : [String] = [
        "Color Blend" ,
        "MQTT Utility" ,
        "Multicast Utility" ,
        "Live Video Stream\nVLC" ,
        "Live Video Stream\nGstreamer" ,   // 5
        "Rtsp Stream\nLive555" ,
        "Libgd Integration",   //7
        "-",
        "Ble bluetooth Keyboard",
        "Nfc Testing",
        "-",
        "Push Notification",
        "Audio",
        "-",
        "Google Map"
        
    ]
    
     
    private let wndsLs : [AnyView] = [
        AnyView(TColorBlendMainWnd()),
        AnyView(TMqttMainWnd()),
        AnyView(TMulticastMainWnd()),
        AnyView(TLiveVideoMainWnd()),
        AnyView(TLiveVideoMainWnd()),  // 5
        AnyView(TLive555MainWnd()),  // 6
        AnyView(Text("Libgd Integration")),  // 7
        AnyView(EmptyView()),  // -
        AnyView(TBleMainWnd()),
        AnyView(Text("Nfc Testing Coming soon....")),
        AnyView(EmptyView()),   // -
        AnyView(TPushNotifiMainWnd()),
        AnyView(TAudioMainWnd()),
        AnyView(EmptyView()),   // -
        AnyView(TGoogleMapMainWnd()),
    ]
    
     
    
    var body: some View {
        
       let mykey : String = try!  TReadPrivateConfKeys.value(for: "TOOT_TEST_KEY")
        
#if os(iOS)
        let divW  : CGFloat  = UIScreen.main.bounds.width
        #else
        let divW : CGFloat = 100
 #endif
          
        NavigationSplitView {
            ScrollView{
            VStack {
                Text("TOOT Private Key test:\(mykey)")
                
                Spacer()
                
                FlowLayout(alignment: .center ) {
                    
                    ForEach(Array( btnLabelStrLs.enumerated() ), id: \.offset) { idx , str in
                        
                        if str == "-" {
                            SwiftUI.Group{
                                Divider()
                                    .frame(width: divW  )
                            }
                            
                        }
                        else {
                            
                            NavigationLink {
                                wndsLs[idx]
#if os(iOS)
                                    .toolbarBackground(.blue.opacity(0.7), for: .navigationBar  )
                                    .toolbarBackground(.visible, for: .navigationBar)
#endif
                            } label: {
                                let txtLb = Text(str)
                                    .font(.system(size: 14))
                                    .bold()
                                
                                Rectangle()
                                    .frame(width: 120,height: 58)
                                    .foregroundColor( Color.random)
                                    .cornerRadius(6)
                                    .shadow(radius: 6)
                                    .overlay {
                                        txtLb
                                            .foregroundStyle(.black)
                                    }
                                    .overlay {
                                        txtLb
                                            .shadow(radius: 6)
                                            .foregroundStyle(.white)
                                            .offset(  x: -1 , y : -1)
                                        
                                    }
                            }
                        }
                    }
                    
                }
                
                Button("FetchIpAddr") {
                    let ip = getLocalIP()
                    
                    print(ip)
                }
                
                Spacer()
                
                
                
                Text("SwiftUI 5 @ 2024/02")
                
                
            }
        }
        } detail: {
            Text("Detail....")
        }
    }
}


extension Color {
    static var random: Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
}

//
//struct ContentView: View {
//    
//    
//   // @State private var testPath = NavigationPath()
//    
//    @EnvironmentObject var appObj : TTestEnvObj
//    
//     
//    
//    
//    init() {
//         print("Content view init....")
//    }
//     
//    
//    var body: some View {

////        }
//        
//        
//        NavigationStack(path: $appObj.testPath)   {
//            List {
//                NavigationLink("Go to detail A", value: "Show AAAA")
//                NavigationLink("Go to B", value: "Show BBB")
//                NavigationLink("Go to number 1", value: 1)
//                
//                
//              
//                    
//                }
//                .navigationDestination(for: String.self) { textValue in
//                    DetailView(    text: textValue)
//                }
//                .navigationDestination(for: Int.self) { numberValue in
//                    Text("Detail with \(numberValue)")
//                }
//                 .navigationTitle("Root view")
//                 .toolbarBackground(.yellow, for: .navigationBar)
//                // .toolbarBackground(.visible, for: .navigationBar)
//            }
//        
//    }
//     
//}

//
//struct DetailView: View {
//    
//   // @Binding var npath : NavigationPath
//    
//    @EnvironmentObject var appObj : TTestEnvObj
//    
//    let text: String
//    
//    
//    init(  text: String) {
//       // self._npath = npath
//        self.text = text
//        
//        
//             print("DetailView  init....")
//        
//         
//    }
//    
//
//    var body: some View {
//        VStack {
//            Text("Detail view showing")
//            Text(text)
//
//            Divider()
//
//            NavigationLink("Link to 3", value: 3)
//            NavigationLink("Link to C", value: "CCCC")
//            
//            Divider()
//            
//            Button("Remove last path"){
////                while npath.count > 0 {
////                    npath.removeLast()
////                }
//               // npath.removeLast()
//               // npath.removeAll()
//                appObj.testPath = NavigationPath()
//            }
//            
//        }
//        .navigationTitle(text)
//    }
//}

//
// 
//struct ContentView2: View {
//    
//    @State private var isAnimate = false
//    
//  //  @State private var repCnt = Int.max
//    
//   // @State
//    private var minMaxScale = 32.0  //* 6.8
//   // @State
//    private let maxScale = 32.0 * 6.8
//    
//    
//    var body: some View {
//        VStack {
////            Image(systemName: "globe")
////                .imageScale(.large)
////                .foregroundStyle(.tint)
////            Text("Go!!!!!")
//            
//            Spacer()
//            
//            ZStack {
//                
//               
//                
//                Circle()
//                    .fill(.red)
//                    //.frame(width: minMaxScale)
//                    .frame(width: isAnimate ? minMaxScale : maxScale)
//                    .offset(x: -50, y: -80)
//                    .blendMode(.screen)
//                
//                Circle()
//                    .fill(.green)
//                   // .frame(width: minMaxScale)
//                    .frame(width: isAnimate ? minMaxScale : maxScale)
//                    .offset(x: 50, y: -80)
//                    .blendMode(.screen)
//                
//                Circle()
//                    .fill(.blue)
//                   // .frame(width: minMaxScale)
//                    .frame(width: isAnimate ? minMaxScale : maxScale)
//                    .blendMode(.screen)
//                
//                
//                
//                
//            }
//           // .rotationEffect(Angle(degrees: 50))
//           //  .animation(.smooth.repeatForever(autoreverses: true), value: isAnimate)
//            .animation(Animation.default.repeat(.smooth,  isRep: isAnimate), value: isAnimate)
// //            .onAppear {
////                withAnimation(.smooth .repeatForever(   autoreverses: true)) {
////                    if isAnimate {
////                        minMaxScale = 6.8 * minMaxScale
////                    }
////                   
////                }
////             }
//            
//            
//            Spacer()
//            
//            Button("Toggle Animation"){
//                isAnimate.toggle()
//              
//            }.background(.green)
//                .padding()
//                
//        }
//        .padding()
//        .onAppear{
//            isAnimate.toggle()
//        }
//    }
//}
//
//
//extension Animation {
//    
//    func `repeat`(_ anim : Animation , isRep: Bool, autoreverses: Bool = true) -> Animation {
//        if isRep {
//            return anim.repeatForever(autoreverses: autoreverses)
//        } else {
//            return anim
//        }
//    }
//}

#Preview {
    ContentView()
}
