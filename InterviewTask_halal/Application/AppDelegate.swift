//
//  AppDelegate.swift
//  InterviewTask_halal
//
//  Created by iOS on 13/9/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Life cycle
        let launchViewcontroller = LaunchViewController.loadFromNib()
        self.window?.rootViewController = launchViewcontroller
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func setRootViewController() {
        let initialController = NavigationController()
        initialController.setRootWireframe(HomeWireframe())
        self.window?.rootViewController = initialController
        self.window?.makeKeyAndVisible()
        UIView.transition(with: DELEGATE.window!, duration: 2, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
