//
//  AppDelegate.swift
//  CoordinatesViewer
//
//  Created by Valery Kokanov on 24.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import UIKit
import Dip
import Dip_UI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    override init() {
        super.init()
        _ = DependencyContainer(configBlock: configureContainer)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

}

