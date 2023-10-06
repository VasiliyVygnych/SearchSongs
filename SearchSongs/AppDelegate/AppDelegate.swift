//
//  AppDelegate.swift
//  SearchSongs
//
//  Created by Vasiliy Vygnych on 04.10.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let musicListView = MusicListRouter.createTodoListModule()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = musicListView
        window?.makeKeyAndVisible()
        return true
    }
}
