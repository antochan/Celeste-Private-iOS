//
//  HomeViewController.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/14.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let homeView = HomeView()
    private let who: Who
    
    var presented: Bool = false {
        didSet {
            homeView.appearAnimation()
        }
    }
    
    init(who: Who) {
        self.who = who
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureActions()
        homeView.applyHomeView(who: who)
    }
    
    func configureActions() {
        homeView.userImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userImageTapped)))
        homeView.calendarView.actions = { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.homeView.handleDisappearAnimation { (done) in
                if done {
                    print("show calendar view")
                }
            }
        }
    }
    
    @objc func userImageTapped() {
        dismiss(animated: true)
    }
}
