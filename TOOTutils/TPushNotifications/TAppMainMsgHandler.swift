//
//  TAppMainMsgHandler.swift
//  TOOTutils
//
//  Created by thor on 3/3/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import Foundation
import UserNotifications

@MainActor
class TAppMainMsgHandler: ObservableObject {
    @Published private(set) var isPermission = false
    
    
    init() {
        Task{
            await getAuthStatus()
        }
    }
    
    func request() async{
          do {
              try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
               await getAuthStatus()
          } catch{
              print(error)
          }
      }
      
      func getAuthStatus() async {
          let status = await UNUserNotificationCenter.current().notificationSettings()
          switch status.authorizationStatus {
          case .authorized, .ephemeral, .provisional:
              isPermission = true
          default:
              isPermission = false
          }
      }
    
}










