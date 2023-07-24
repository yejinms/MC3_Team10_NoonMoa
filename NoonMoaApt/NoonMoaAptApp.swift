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

@main
struct NoonMoaAptApp: App {
    @Environment(\.scenePhase) var scenePhase
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
                loginViewModel: LoginViewModel(viewRouter: ViewRouter()),
                aptViewModel: AptViewModel(),
                weather: WeatherViewModel(),
                time: TimeViewModel(),
                eyeTrack: EyeTrackViewModel()
            )
                .environmentObject(viewRouter)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                delegate.handleSceneActive()
            case .inactive:
                delegate.handleSceneInactive()
            case .background:
                delegate.handleSceneBackground()
            @unknown default:
                delegate.handleSceneUnexpectedState()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    
    let gcmMessageIDKey = "gcm.message_id"
    var loginViewModel: LoginViewModel?
    var viewRouter = ViewRouter()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
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
        
        var pushNotiController = PushNotiController()
        pushNotiController.responsePushNotification()
        
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func handleSceneActive() {
        // ... do something when active
        print("AppDelegate: ScenePhase: active")
        
        // Here you would update the user's state to .active
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("User").document(user.uid).updateData([
                "userState": UserState.active.rawValue
            ]) { err in
                if let err = err {
                    print("Error updating user state: \(err)")
                } else {
                    print("User state successfully updated to active")
                }
            }
        }
    }

    func handleSceneBackground() {
        // ... do something when in background
        print("AppDelegate: ScenePhase: background")
        
        // Here you would update the user's state to .inactive
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            db.collection("User").document(user.uid).updateData([
                "userState": UserState.inactive.rawValue
            ]) { err in
                if let err = err {
                    print("Error updating user state: \(err)")
                } else {
                    print("User state successfully updated to inactive")
                }
            }
        }
    }

    func handleSceneInactive() {
        print("AppDelegate: ScenePhase: inactive")
        // ... do something when inactive
    }

    func handleSceneUnexpectedState() {
        print("AppDelegate: ScenePhase: unexpected state")
        // ... do something when in unexpected state
    }
}

extension AppDelegate: MessagingDelegate {
        
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("토큰을 받았다")
        
        let db = Firestore.firestore()
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        print(dataDict, "from_Appdelegate")
                
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

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // PushNoti 메세지 만드는 부분
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        completionHandler([[.banner, .badge, .sound]])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let senderId = userInfo["senderId"] as? String {
            let db = Firestore.firestore()
            db.collection("User").document(senderId).updateData([
                "clicked": true,
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
