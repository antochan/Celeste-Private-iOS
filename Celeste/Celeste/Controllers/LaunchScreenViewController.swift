//
//  LaunchScreenViewController.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/14.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import SwiftyGif

class LaunchScreenViewController: UIViewController {
    let launchScreenView = LaunchScreenView()
    
    override func loadView() {
        super.loadView()
        view = launchScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        launchScreenView.gifImageView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        launchScreenView.gifImageView.startAnimatingGif()
    }
}

extension LaunchScreenViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        let whoThisViewController = WhoThisViewController()
        whoThisViewController.modalPresentationStyle = .fullScreen
        whoThisViewController.isHeroEnabled = true
        present(whoThisViewController, animated: true) {
            whoThisViewController.presented = true
        }
    }
}
