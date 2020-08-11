//
//  AuthViewController.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/10.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class WhoThisViewController: UIViewController {
    let whoThisView = WhoThisView()
    
    override func loadView() {
        super.loadView()
        view = whoThisView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        whoThisView.appearAnimation()
    }
    
    func configureActions() {
        whoThisView.laurenComponent.actions = { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.whoThisView.handleDisappearAnimation { done in
                if done {
                    print("done")
                }
            }
        }
        
        whoThisView.antonioComponent.actions = { [ weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.whoThisView.appearAnimation()
        }
    }
}
