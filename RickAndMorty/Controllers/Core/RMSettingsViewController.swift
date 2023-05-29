//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 30.04.23.
//


import UIKit
import SwiftUI
import SafariServices
import StoreKit

/// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {
    
    private var settingsSwiftUIController: UIHostingController<RMSettingsView>?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        addSwiftUIController()
        
    }
    
    private func addSwiftUIController() {
        let settingsSwiftUIController = UIHostingController(rootView: RMSettingsView(viewModel:
            RMSettingsViewViewModel(cellViewModels: RMSettingsOption.allCases.compactMap({ type in
            return RMSettingsCellViewModel(type: type) { [weak self] option in
                self?.handleTap(option: option)
            }
        }))))
        
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsSwiftUIController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsSwiftUIController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        
        self.settingsSwiftUIController = settingsSwiftUIController
        
    }
    private func handleTap(option: RMSettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        if let url = option.targetUrl {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
        else if option == .rateApp {
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
}
