//
//  AppManager.swift
//  Cingulo
//
//  Created by Michel Lutzon 02/05/2018.
//  Copyright © 2018
//

import UIKit
//import Bugsnag

/*
 Class AppManager mamage a app flow initial ViewControllers
 */
final class AppManager {
    /*
     Singleton constant
     */
    static let shared = AppManager()
    /*
     DefaultWindow
     
     SeeAlso `UIWindow`
     */
    var window: UIWindow!
    
    /*
     Set a window rootViewController app
     */
    var rootViewController: UIViewController? {
        didSet {
            if let vc = rootViewController {
                window.rootViewController = vc
            }
        }
    }
    var globalModal: UIViewController? {
        didSet {
            if let vc = globalModal {
                rootViewController?.present(vc, animated: true, completion: nil)
            }
        }
    }
    /*
     Initializer, start observer on loginStatusChanged and call Handler to signed or not
     */
    init() {

    }
    
    /*
     Show initial ViewController to verify user authentication token
     */
    func show(in window: UIWindow?) {
        guard let mainWindow = window else {
            fatalError("Cannot layout app with a nil window.")
        }
        mainWindow.backgroundColor = .white
        self.window = mainWindow
        
        let mainViewController = setupNavigationControllers(with: ViewController())
        rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }
    
    func toggleStatusBar(isHidden: Bool) {
        UIApplication.shared.isStatusBarHidden = isHidden
    }
    
    private func setupNavigationControllers(with viewController: UIViewController) -> UINavigationController{
        let navigation = UINavigationController(rootViewController: viewController)
        return navigation
    }
}
