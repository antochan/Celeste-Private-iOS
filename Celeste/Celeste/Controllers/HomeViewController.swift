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
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        homeView.scrollView.isScrollEnabled = true
//        homeView.scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
//    }
    
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
    }
    
    @objc func userImageTapped() {
        dismiss(animated: true)
    }
}
