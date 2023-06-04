//
//  RMLocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 04.06.23.
//

import UIKit

class RMLocationDetailViewController: UIViewController {
   
    
    private let viewModel: RMLocationDetailViewViewModel
    private let detailView = RMLocationDetailView()
    //MARK: - Init
    init(location: RMLocation) {
        let url = URL(string: location.url)
        self.viewModel = .init(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Location"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        view.addSubview(detailView)
        setupConstraints()
        viewModel.delegate = self
        detailView.delegate = self
        viewModel.fetchLocationData()
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
        ])
    }
    
    @objc private func didTapShare() {
        
    }
}

//MARK: - RMLocationDetailViewViewModelDelegate
extension RMLocationDetailViewController: RMLocationDetailViewViewModelDelegate {
    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
}
extension RMLocationDetailViewController: RMLocationDetailViewDelegate {
    func rmLocationDetailView(_ detailView: RMLocationDetailView, didSelect character: RMCharacter) {
        let vc = RMCharacterDetailViewController(viewModel: RMCharacterDetailViewViewModel(character: character))
        vc.title = character.name
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

