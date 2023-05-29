//
//  RMEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 30.04.23.
//

import UIKit

/// Controller to show and search for Episodes
final class RMEpisodeViewController: UIViewController {
    
    private let episodeListView = RMEpisodeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Episodes"
        setupView()
        addSearchButton()
    }
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        let vc = RMSearchViewController(config: .init(type: .episode))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    //MARK: - View Setup
    private func setupView() {
        episodeListView.delegate = self
        view.addSubview(episodeListView)
        
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
            
        ])
    }
    
}
//MARK: - RMEpisodeListViewDelegate
extension RMEpisodeViewController: RMEpisodeListViewDelegate {
    func rmEpisodeListView(_ episodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        
        //open detail controller for episode
        let detailVC = RMEpisodeDetailViewController(url: URL(string: episode.url))
        
        detailVC.navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

