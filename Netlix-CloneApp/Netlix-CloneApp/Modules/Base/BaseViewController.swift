//
//  BaseViewController.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 4.08.2022.
//

import UIKit

class BaseViewController: UIViewController {
    var isLandScapeMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isLandScapeMode = UIDevice.current.orientation.isLandscape
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        isLandScapeMode = UIDevice.current.orientation.isLandscape
    }
    
    deinit {
        Logger.log(.deinitPage, self.description)
    }
    
}
