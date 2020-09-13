//
//  PhotoGalleryViewController.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/9/13.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class PhotoGalleryViewController: UIViewController {
    private let who: Who
    let photoGalleryView = PhotoGalleryView()
    
    var presented: Bool = false {
        didSet {
            //photoGalleryView.appearAnimation()
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
        view = photoGalleryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureActions()
    }
    
    func configureActions() {
        photoGalleryView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }

}
