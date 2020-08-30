//
//  AddCalendarEventView.swift
//  Celeste
//
//  Created by Antonio Chan on 2020/8/30.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class AddCalendarEventView: UIView {
    private let selectedDatesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.mainMedium(size: 22)
        label.textColor = UIColor.AppColors.black
        label.text = "Selected Dates"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - Private

private extension AddCalendarEventView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(selectedDatesTitleLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            selectedDatesTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.fortyEight),
            selectedDatesTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour)
        ])
    }
}
