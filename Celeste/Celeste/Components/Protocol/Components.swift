//
//  Components.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//
 
import UIKit

// MARK: - Component
public protocol Component {
    associatedtype ViewModel
    
    func apply(viewModel: ViewModel)
}

// MARK: - Reusable
public protocol Reusable {
    func prepareForReuse()
}

// MARK: - Actionable
public protocol Actionable {
    associatedtype Actions
    var actions: Actions? { get set }
}

// MARK: - HeightCalculatingViewModel
public protocol HeightCalculatingViewModel {
    func componentHeight(for width: CGFloat) -> CGFloat
}

// MARK: - HeightCalculatingComponent
public protocol HeightCalculatingComponent: Component {
    static func height(forViewModel viewModel: ViewModel, width: CGFloat) -> CGFloat
}

// MARK: - SizeCalculatingViewModel
public protocol SizeCalculatingComponent: Component {
    static func size(forViewModel viewModel: ViewModel) -> CGSize
}
