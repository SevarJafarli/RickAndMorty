//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 30.04.23.
//

import UIKit

/// Controller to house tabs and root tab controllers
final class RmTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupTabs()
    }

    private func setupTabs() {
        let charactersVc = RMCharacterViewController()
        let locationsVc = RMLocationViewController()
        let episodesVc = RMEpisodeViewController()
        let settingsVc = RMSettingsViewController()
        
        charactersVc.navigationItem.largeTitleDisplayMode = .automatic
        locationsVc.navigationItem.largeTitleDisplayMode = .automatic
        episodesVc.navigationItem.largeTitleDisplayMode = .automatic
        settingsVc.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: charactersVc)
        let nav2 = UINavigationController(rootViewController: locationsVc)
        let nav3 = UINavigationController(rootViewController: episodesVc)
        let nav4 = UINavigationController(rootViewController: settingsVc)
        
        nav1.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        
        let navControllers: [UINavigationController] = [nav1, nav2, nav3, nav4]
        
        for nav in navControllers {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(navControllers, animated: true)
    }
}

