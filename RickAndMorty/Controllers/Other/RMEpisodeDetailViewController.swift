//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 23.05.23.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {
    
    private let url: URL?
    
    //MARK: - Init
    init(url:URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
}
