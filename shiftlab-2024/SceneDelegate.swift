//
//  SceneDelegate.swift
//  shiftlab-2024
//
//  Created by Тимур Осокин on 14.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        setupNavigationController()
    }
    
    func setupNavigationController() {
        if let userName = CoreDataManager.shared.obtainSavedData()  {
            let tableViewController = TableViewController()
            let navigationController = UINavigationController(rootViewController: tableViewController)
            window?.rootViewController = navigationController
        }
        else {
            let navigationController = UINavigationController()
            let appNavigator = AppNavigator(navigationController: navigationController)
            let loginViewController = LoginViewController(navigator: appNavigator)
            navigationController.viewControllers = [loginViewController]
            window?.rootViewController = navigationController
        }
        
        window?.makeKeyAndVisible()
        let orientationLock = UIInterfaceOrientationMask.portrait
        AppDelegate.orientationLock = orientationLock
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataManager.shared.saveContext()
    }
}

