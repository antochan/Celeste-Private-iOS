//
//  LaunchScreenView.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/14.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import SwiftyGif

class LaunchScreenView: UIView {
    let gifImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        try! imageView.setGifImage(UIImage(gifName: "CELESTE"), loopCount: 1)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = UIColor.AppColors.offWhite
        addSubview(gifImageView)
        
        NSLayoutConstraint.activate([
            gifImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gifImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            gifImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.65),
            gifImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.65)
        ])
    }
}
