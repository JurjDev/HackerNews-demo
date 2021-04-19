//
//  SceneDelegate.swift
//  HackerNews
//
//  Created by JurjDev on 16/04/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene)
            else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = HackerNewsViewController.navigationInstance()
        window?.makeKeyAndVisible()
    }
}

