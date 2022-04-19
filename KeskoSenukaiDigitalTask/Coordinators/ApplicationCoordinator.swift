//
//  ApplicationCoordinator.swift
//  KeskoSenukaiDigitalTask

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        
        let storyboard = UIStoryboard(name: mainStoryboard, bundle: nil)
        guard let mainViewController = storyboard.instantiateViewController(identifier: mainViewControllerIdentifier) as? MainViewController else { print("MainViewController not found")
            return
        }
        rootViewController.pushViewController(mainViewController, animated: true)
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
