//
//  SceneDelegate.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 09/09/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?
    // swiftlint:disable all
    
    func isFirstLaunch() -> Bool {
           if !UserDefaults.standard.bool(forKey: "HasAtLeastLaunchedOnce") {
               UserDefaults.standard.set(true, forKey: "HasAtLeastLaunchedOnce")
               UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
               UserDefaults.standard.synchronize()
               return true
           }
           return false
       }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.isFirstLaunch()
        let rootNavigationController = TabBarViewController()
        coordinator = MainCoordinator(tabBarController: rootNavigationController)
        coordinator?.start()
        
        self.window?.rootViewController = rootNavigationController
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
