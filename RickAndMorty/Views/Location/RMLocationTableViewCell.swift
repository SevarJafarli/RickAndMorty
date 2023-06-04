//
//  RMLocationTableViewCell.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 04.06.23.
//

import UIKit

class RMLocationTableViewCell: UITableViewCell {
    static let identifier = "RMLocationTableViewCell"
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: RMLocationTableViewCellViewModel) {
        
    }
}
