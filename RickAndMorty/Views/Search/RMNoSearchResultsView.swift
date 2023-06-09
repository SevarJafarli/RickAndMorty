//
//  RMNoSearchResultsView.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 04.06.23.
//

import UIKit

final class RMNoSearchResultsView: UIView {
    private let viewModel = RMNoSearchResultsViewViewModel()
    
    
    private let iconView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .systemGreen
        return icon
    }()
    
    private let labelView : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
        addSubviews(iconView, labelView)
        addConstraints()
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 60),
            iconView.heightAnchor.constraint(equalToConstant: 60),
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            labelView.leftAnchor.constraint(equalTo: leftAnchor),
            labelView.rightAnchor.constraint(equalTo: rightAnchor),
            labelView.bottomAnchor.constraint(equalTo: bottomAnchor),
            labelView.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
            labelView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
    }
    
    private func configure() {
        labelView.text = viewModel.title
        iconView.image = viewModel.image
    }
}
