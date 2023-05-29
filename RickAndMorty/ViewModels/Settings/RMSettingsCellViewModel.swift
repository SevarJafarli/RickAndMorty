//
//  RMSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 26.05.23.
//

import UIKit

struct RMSettingsCellViewModel : Identifiable {

    let id = UUID()
    
    //MARK: - Public
    public var image: UIImage? {
        return type.iconImage
    }
    public var title: String {
        return type.displayTitle
    }
    public var imageContainerColor: UIColor {
        return type.iconContainerColor
    }
    
    
    //MARK: - Init
    
    public let type: RMSettingsOption
    public let onTapHandler: (RMSettingsOption) -> Void
    
    init(type:RMSettingsOption, onTapHandler: @escaping (RMSettingsOption) -> Void){
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
