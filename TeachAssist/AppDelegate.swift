//
//  AppDelegate.swift
//  TeachAssist
//
//  Created by York Wei on 2020-02-16.
//  Copyright © 2020 York Wei. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Siren
import Firebase
import FirebaseMessaging
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        checkUpdate()
        UNUserNotificationCenter.current().delegate = self
    
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

private extension AppDelegate {
    
    func checkUpdate() {
        let siren = Siren.shared
        siren.apiManager = APIManager(countryCode: "CA")
        siren.rulesManager = RulesManager(globalRules: .annoying,
                                          showAlertAfterCurrentVersionHasBeenReleasedForDays: 1)

        siren.wail { results in
            switch results {
            case .success(let updateResults):
                print("AlertAction ", updateResults.alertAction)
                print("Localization ", updateResults.localization)
                print("Model ", updateResults.model)
                print("UpdateType ", updateResults.updateType)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
