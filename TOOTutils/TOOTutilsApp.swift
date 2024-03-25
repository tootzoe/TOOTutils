//
//  TOOTutilsApp.swift
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
import FirebaseCore
import FirebaseMessaging
import GoogleMaps
//import GooglePlaces
#endif

#if os(iOS)
class TAppDelegate: NSObject, UIApplicationDelegate ,
                              MessagingDelegate, UNUserNotificationCenterDelegate
{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
         
        let gsmKey : String = try!  TReadPrivateConfKeys.value(for: "TOOT_GMS_SVR_KEY")
        
        application.registerForRemoteNotifications()
        FirebaseApp.configure()
        GMSServices.provideAPIKey(gsmKey)
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
           Messaging.messaging().apnsToken = deviceToken
       }
    
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
 
        
       // print(userInfo)  // app in active state, remote message comes here....
         
        completionHandler(.noData)
    }
    
    
       
       func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
           
         print(messaging)
           
           if let fcm = Messaging.messaging().fcmToken {
               print("TOOTutils fcm", fcm)
           }
       }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("userNotificationCenter -> willPresent.......")
        
        print( notification.request.content.userInfo)
        
        completionHandler(UNNotificationPresentationOptions(rawValue: 0))
    }
 
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("userNotificationCenter, withCompletionHandler.......")
        //print(response)
       // print(response.notification)
        //print(response.notification.request)
       // print(response.notification.request.content)
        print(response.notification.request.content.userInfo)
        completionHandler()
    }
 
    
    
}

#endif


@main
struct TOOTutilsApp: App {
    
#if os(iOS)
    @UIApplicationDelegateAdaptor(TAppDelegate.self) var delegate
#endif
    
    var body: some Scene {
        WindowGroup {
            ContentView() 
            #if os(macOS)
                .frame(width: 800, height: 600)
            #endif
           
        }
    }
}
 
