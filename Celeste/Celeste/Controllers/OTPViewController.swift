//
//  OTPViewController.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/10.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {
    let otpView = OTPView()
    private let who: Who
    var presented: Bool = false {
        didSet {
            otpView.appearAnimation()
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
        view = otpView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        otpView.appearAnimation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configureActions()
        otpView.applyTexts(who: who)
        otpView.OTPField.delegate = self
    }
    
    func configureActions() {
        otpView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        otpView.submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        otpView.OTPField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func backTapped() {
        dismiss(animated: true)
    }
    
    @objc func submitTapped() {
        guard let code = otpView.OTPField.text else { return }
            if code.count < 4 {
                otpView.OTPField.becomeFirstResponder()
            } else if code == "0215" {
                otpView.handleDisappearAnimation { [weak self] done in
                    guard let strongSelf = self else { return }
                    if done {
                        strongSelf.transitionToMainScreen()
                    }
                }
            } else {
                otpView.errorLabel.isHidden = false
        }
    }
    
    func transitionToMainScreen() {
        let mainViewController = MainViewController(who: who)
        mainViewController.isHeroEnabled = true
        mainViewController.modalPresentationStyle = .fullScreen
        present(mainViewController, animated: true) {
            mainViewController.presented = true
        }
    }
}

//MARK: - UITextFieldDelegate

extension OTPViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        otpView.errorLabel.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
    }
}
