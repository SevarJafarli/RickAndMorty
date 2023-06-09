//
//  RMSearchViewViewModel.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 04.06.23.
//

import Foundation

final class RMSearchViewViewModel {
    let config: RMSearchViewController.Config
    
    private var optionMapUpdateBlock: (((RMSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    private var optionMap: [RMSearchInputViewViewModel.DynamicOption: String] = [:]
    
    //MARK: - Init
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    //MARK: - Public
    public func set(value: String, for option: RMSearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(_ block: @escaping ((RMSearchInputViewViewModel.DynamicOption, String)) -> Void) {
        self.optionMapUpdateBlock = block
    }
}
