//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 18.05.23.
//

import Foundation

protocol RMEpisodeDataRenderer {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
    
}
final class RMCharacterEpisodeCollectionViewCellViewModel {
    private let episodeDataUrl: URL?
    
    private var isFetching = false
    private var dataBlock: ((RMEpisodeDataRenderer)-> Void)?
    private var episode: RMEpisode? {
        didSet {
            guard let model = episode else {
                return
            }
            dataBlock?(model)
            
        }
    }
    //MARK: - Init
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    
    //MARK: - public
    public func registerData(_ block: @escaping (RMEpisodeDataRenderer) -> Void) {
        self.dataBlock = block
    }
    
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        guard let url = episodeDataUrl, let request = RMRequest(url: url) else { return
        }
        isFetching = true
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
