//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 23.05.23.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {
    
    private let viewModel: RMEpisodeDetailViewViewModel
    private let detailView =  RMEpisodeDetailView()
    
    //MARK: - Init
    
    init(url: URL?) {
        self.viewModel = .init(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        view.addSubview(detailView)
        setupConstraints()
        viewModel.delegate = self
        detailView.delegate = self
        viewModel.fetchEpisodeData()
        
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

//MARK: - RMEpisodeDetailViewViewModelDelegate
extension RMEpisodeDetailViewController: RMEpisodeDetailViewViewModelDelegate {
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
}
extension RMEpisodeDetailViewController: RMEpisodeDetailViewDelegate {
    func rmEpisodeDetailView(_ detailView: RMEpisodeDetailView, didSelect character: RMCharacter) {
        let vc = RMCharacterDetailViewController(viewModel: RMCharacterDetailViewViewModel(character: character))
        vc.title = character.name
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
