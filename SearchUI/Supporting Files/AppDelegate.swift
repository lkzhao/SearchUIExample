//
//  AppDelegate.swift
//  SearchUI
//
//  Created by Luke Zhao on 2018-06-26.
//  Copyright © 2018 Luke Zhao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    window!.backgroundColor = .white
    window!.rootViewController = SearchHomeViewController()
    window!.makeKeyAndVisible()

    return true
  }

}

