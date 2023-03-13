//
//  HomeTabbarTC.swift
//  Movinvio
//
//  Created by Ezgi Üstünel on 4.06.2022.
//

import UIKit

class HomeTabbarTC: UITabBarController {
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Presentation
    static func presentAsRoot() {
        guard let window = UIApplication.shared.windows.first else { return }
        
        DispatchQueue.main.async {
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                UIView.performWithoutAnimation({
                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    let rootController = storyboard.instantiateInitialViewController() as! HomeTabbarTC
                    window.rootViewController = rootController
                })
            }, completion: nil)
        }
    }
}
