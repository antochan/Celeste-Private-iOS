//
//  ComponentTableViewCell.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class ComponentTableViewCell<T: Component & Reusable & UIView>: UITableViewCell {
    
    public let component = T(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        component.prepareForReuse()
    }
}

private extension ComponentTableViewCell {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(component)
    }
    
    func configureLayout() {
        component.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            component.topAnchor.constraint(equalTo: topAnchor),
            component.leadingAnchor.constraint(equalTo: leadingAnchor),
            component.trailingAnchor.constraint(equalTo: trailingAnchor),
            component.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension ComponentTableViewCell {
    
    public struct ViewModel {
        public var componentViewModel: T.ViewModel
        
        public init(componentViewModel: T.ViewModel) {
            self.componentViewModel = componentViewModel
        }
    }
    
    func apply(viewModel: ComponentTableViewCell.ViewModel) {
        component.apply(viewModel: viewModel.componentViewModel)
    }
    
}
