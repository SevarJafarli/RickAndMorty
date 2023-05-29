//
//  RMSettingsOption.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 26.05.23.
//

import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewCode
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact us"
        case .terms:
            return "Terms of Conditions"
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "API References"
        case .viewCode:
            return "View source code"
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemBlue
        case .contactUs:
            return .systemYellow
        case .terms:
            return .systemGray
        case .privacy:
            return .systemRed
        case .apiReference:
            return .systemGreen
        case .viewCode:
            return .systemPurple
        }
    }
    
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://github.com/SevarJafarli")
        case .terms:
            return URL(string: "https://rickandmortyapi.com/about")
        case .privacy:
            return URL(string: "https://rickandmortyapi.com/about")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/documentation")
        case .viewCode:
            return URL(string: "https://github.com/SevarJafarli/RickAndMorty")
        }
    }
}
