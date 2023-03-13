//
//  SplashVC.swift
//  Movinvio
//
//  Created by Ezgi Üstünel on 4.06.2022.
//

import UIKit

class SplashVC: UIViewController {

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        HomeTabbarTC.presentAsRoot()
    }
}
