//
//  AppDelegate.swift
//  Auto Layout Final Project
//
//  Created by Saman on 26/10/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//

import UIKit

typealias Player = (String, String, String, UIImage)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let playerData: [Player] =
        [
            ("Kento", "Momota", "Japan", UIImage(named: "1. Kento_Momota")!),
            ("Tien Chen", "Chou", "Chinese Taipei", UIImage(named: "2. Chou_Tien_Chen")!),
            ("Yu Qi", "Shi", "China", UIImage(named: "3. Shi_Yu_Qi")!),
            ("Long", "Cheng", "China", UIImage(named: "4. Chen_Long")!),
            ("Anders", "Antonsen", "Denmark", UIImage(named: "5. Anders_Antonsen")!),
            ("Viktor", "Axelsen", "Denmark", UIImage(named: "6. Viktor_Axelsen")!),
            ("Jonatan", "Christie", "Indonesia", UIImage(named: "7. Jonatan_Christie")!),
            ("Anthony Sinisuka", "Ginting", "Indonesia", UIImage(named: "8. Anthony_Sinisuka_Ginting")!),
            ("Ka Long Angus", "NG", "Hong Kong China", UIImage(named: "9. NG_Ka_Long_Angus")!),
            ("Srikanth", "Kidambi", "India", UIImage(named: "10. Kidambi_Srikanth")!),
    ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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
