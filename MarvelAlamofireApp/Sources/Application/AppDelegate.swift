//
//  AppDelegate.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 01.08.22.
//

import UIKit
 
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = GalleryViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = .black
        window?.overrideUserInterfaceStyle = .dark
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true  
    }
    
}

