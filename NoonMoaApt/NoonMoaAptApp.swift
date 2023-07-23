//
//  MC3_NoonMoaApp.swift
//  MC3_NoonMoa
//
//  Created by kimpepe on 2023/07/20.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseMessaging


//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}

@main
struct NoonMoaAptApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var viewRouter = ViewRouter()
    
    // Initialize a sample AttendanceRecord
    let attendanceRecord = AttendanceRecord(userId: UUID().uuidString, date: Date(), weatherCondition: "Sunny", eyeDirection: [0.1, 0.2, 0.3], aptId: "sampleAptId")

    
    var body: some Scene {
        WindowGroup {
            MainView(
                attendanceCompletedViewModel: AttendanceCompletedViewModel(record: attendanceRecord),
                attendanceViewModel: AttendanceViewModel(),
                calendarFullViewModel: CalendarFullViewModel(),
                calendarSingleController: CalendarSingleController(viewModel: CalendarFullViewModel()),
                loginViewModel: LoginViewModel(),
                aptViewModel: AptViewModel(),
                weather: WeatherViewModel(),
                time: TimeViewModel(),
                eyeTrack: EyeTrackViewModel()
            )
                .environmentObject(viewRouter)
        }
    }
}

//토큰을 받았다
//["token": "dl32yOMswUzphtj80tAsSX:APA91bHlKSrGp3ytRE-w4EXPxhM5X0ylgYHFEvkJqR9K-6TlJ7liPu1o9RQdLFOKux8DLik_hw9DqKb9S2o-FvHMkoPdIqaM-IOs7jRl_oQ-c-iaOcAMTpUSfnaFRyk8a5kAp435L6_E"]


class AppDelegate: NSObject, UIApplicationDelegate{
    
    let gcmMessageIDKey = "gcm.message_id"
    var loginViewModel: LoginViewModel?
    
    // 앱이 켜졌을 때
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 파이어베이스 설정
        FirebaseApp.configure()
        
        // Setting Up Notifications...
        // 원격 알림 등록
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOption,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        
        // Setting Up Cloud Messaging...
        // 메세징 델리겟
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    // fcm 토큰이 등록 되었을 때
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

// Cloud Messaging...
extension AppDelegate: MessagingDelegate {
        
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("토큰을 받았다")
        
        let db = Firestore.firestore()
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        print(dataDict, "from_Appdelegate")
                
        // Store the FCM token in Firestore if a user is logged in
        if let user = Auth.auth().currentUser {
            db.collection("User").document(user.uid).setData(["token": fcmToken ?? ""], merge: true) { err in
                if let err = err {
                    print("Error writing token to Firestore: \(err)")
                } else {
                    print(db.collection("User").document(user.uid))
                    print("Token successfully written!")
                }
            }
        } else {
            print("No user is signed in.")
        }
    }
}


// User Notifications...[AKA InApp Notification...]

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 푸시 메세지가 앱이 켜져있을 때 나올떄
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        
        // Do Something With MSG Data...
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        
        print(userInfo)
        
        completionHandler([[.banner, .badge, .sound]])
    }
    
    // 푸시메세지를 받았을 떄
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        // Check the custom data received with the notification
        if let senderId = userInfo["senderId"] as? String {
            // Update the user's state to 'Ready' in Firestore
            let db = Firestore.firestore()
            db.collection("User").document(senderId).updateData([
                "userState": UserState.ready.rawValue,
                "lastActiveDate": FieldValue.serverTimestamp()
            ]) { err in
                if let err = err {
                    print("Error updating user state: \(err)")
                } else {
                    print("User state successfully updated")
                }
            }
        }
        
        completionHandler()
    }
}
