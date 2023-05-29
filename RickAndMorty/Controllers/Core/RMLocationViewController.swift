//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 30.04.23.
//

import UIKit

/// Controller to show and search for Location
final class RMLocationViewController: UIViewController {
    private let locationView = RMLocationView()
    private let viewModel = RMLocationViewViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Locations"
        addSearchButton()
        view.addSubview(locationView)
        addConstraints()
      
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            locationView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            locationView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        let vc = RMSearchViewController(config: .init(type: .location))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
