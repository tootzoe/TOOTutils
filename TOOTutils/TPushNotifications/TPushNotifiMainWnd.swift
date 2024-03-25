//
//  TPushNotifiMainWnd.swift
//  TOOTutils
//
//  Created by thor on 3/3/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//

import SwiftUI


#if os(iOS)

import OAuth2
 
struct TPushNotifiMainWnd: View {
    @StateObject var notifiObj = TAppMainMsgHandler()
    @State private var isAuthorized = false
    
   
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            Button("Google OAuth2 Authenticate"){
              //  oauthswift.
            }.buttonStyle(.borderedProminent)
            
            Divider()
            
            Button(notifiObj.isPermission ? 
                   "Notification Permission Granted" :
                   "Request Notification" ){
                Task{
                    await notifiObj.request()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(notifiObj.isPermission)
            .task {
                await notifiObj.getAuthStatus()
            }
            
            
        }
    }
}

#else

struct TPushNotifiMainWnd: View {
    var body: some View {
        VStack {
            Text("macOS doesn't not implement this function.")
            
        }
    }
}

#endif

#Preview {
    TPushNotifiMainWnd()
}
