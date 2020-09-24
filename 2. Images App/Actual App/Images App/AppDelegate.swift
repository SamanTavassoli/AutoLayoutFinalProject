//
//  AppDelegate.swift
//  Images App
//
//  Created by Saman on 28/07/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func applicationDidFinishLaunching(_: UIApplication) {
        (window!.rootViewController as! ViewController).cards =
            [ "drampa",
              "glaceon",
              "guzzlord",
              "raichu"
                ].map(Card.init)
    }
}

