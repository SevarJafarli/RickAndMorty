//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 04.06.23.
//

import UIKit

protocol RMSearchViewDelegate: AnyObject {
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
}
class RMSearchView: UIView {
    let viewModel: RMSearchViewViewModel
    
    private let noResultsView = RMNoSearchResultsView()
    private let searchInputView = RMSearchInputView()
    
    weak var delegate: RMSearchViewDelegate?
    
    //MARK: - Init
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(noResultsView, searchInputView)
        addConstraints()
        searchInputView.configure(with: .init(type: viewModel.config.type))
        searchInputView.delegate = self
        viewModel.registerOptionChangeBlock { tuple in
            //tuple: option | value
        }
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func presentKeyboard() {
        searchInputView.presentKeyboard()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            //search input
            
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leftAnchor.constraint(equalTo: leftAnchor),
            searchInputView.rightAnchor.constraint(equalTo: rightAnchor),
            searchInputView.heightAnchor.constraint(equalToConstant:viewModel.config.type == .episode ? 60: 100),
            
            // no results
            noResultsView.widthAnchor.constraint(equalToConstant: 150),
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

//MARK: - RMSearchInputViewDelegate
extension RMSearchView: RMSearchInputViewDelegate {
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        delegate?.rmSearchView(self, didSelectOption: option)
    }
}
