//
//  MainViewController.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/11.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

enum DateDiffType: Int, CaseIterable {
    case years = 1
    case months
    case days
    case minutes
}

class MainViewController: UIViewController {
    let mainView = MainView()
    private let who: Who
    private var timer = Timer()
    private var dateDiffType: DateDiffType = .days {
        didSet {
            mainView.applyTime(dateString: calculateLengthDate(diffType: dateDiffType), animate: true)
        }
    }
    var presented: Bool = false {
        didSet {
            mainView.appearAnimation()
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
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.applyTime(dateString: calculateLengthDate(diffType: dateDiffType), animate: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.appearAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.applyMainView(who: who)
        configureActions()
        
    }
    
    func configureActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(timeDateTapped))
        mainView.subtitleLabel.addGestureRecognizer(tap)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)
        
        mainView.refreshButton.actions = { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.timeDateTapped()
        }
        
        mainView.lockButton.actions = { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.dismiss(animated: true)
        }
        
        mainView.nextButton.actions = { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.mainView.handleDisappearAnimation { done in
                if done {
                    strongSelf.presentHomePage(who: strongSelf.who)
                }
            }
        }
    }
    
    @objc func timeDateTapped() {
        dateDiffType = determineDiffType(index: (dateDiffType.rawValue + 1) % DateDiffType.allCases.count)
    }
    
    @objc func updateTimeLabel() {
        mainView.applyTime(dateString: calculateLengthDate(diffType: dateDiffType), animate: false)
    }
    
    func determineDiffType(index: Int) -> DateDiffType {
        if index == 1 {
            return .years
        } else if index == 2 {
            return .months
        } else if index == 3 {
            return .days
        } else {
            return .minutes
        }
    }
    
    func calculateLengthDate(diffType: DateDiffType) -> String? {
        switch diffType {
        case .years:
            let difference = Calendar.current.dateComponents([.year], from: AppConstants.relationshipStartDate, to: Date())
            let duration = difference.year
            return "\(duration ?? 0) Years"
        case .months:
            let difference = Calendar.current.dateComponents([.month], from: AppConstants.relationshipStartDate, to: Date())
            let duration = difference.month
            return "\(duration ?? 0) Months"
        case .days:
            let difference = Calendar.current.dateComponents([.day], from: AppConstants.relationshipStartDate, to: Date())
            let duration = difference.day
            return "\(duration ?? 0) Days"
        case .minutes:
            let difference = Calendar.current.dateComponents([.hour, .minute, .second], from: AppConstants.relationshipStartDate, to: Date())
            let hour = difference.hour
            let minute = difference.minute
            let seconds = difference.second
            return "\(hour ?? 0)h \(minute ?? 0)m \(seconds ?? 0)s"
        }
    }
    
    func presentHomePage(who: Who) {
        let homeViewController = HomeViewController(who: who)
        homeViewController.modalPresentationStyle = .fullScreen
        homeViewController.isHeroEnabled = true
        present(homeViewController, animated: true) {
            homeViewController.presented = true
        }
    }
}
