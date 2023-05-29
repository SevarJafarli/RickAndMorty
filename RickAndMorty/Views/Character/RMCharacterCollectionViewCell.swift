//
//  RMCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 03.05.23.
//

import UIKit

final class RMCharacterCollectionViewCell: UICollectionViewCell {
    static let cellId = "RMCharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLabel, statusLabel)
        addConstraints()
        setupLayer()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 6),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -6),
            
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 6),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -6),
            
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            imageView.topAnchor.constraint(equalTo:contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo:contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo:contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo:nameLabel.topAnchor, constant: -3),
        
        ])
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupLayer()
    }
    
    private func setupLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -2, height: 2)
        contentView.layer.shadowOpacity = 0.3
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with model: RMCharacterListViewCellViewModel) {
        nameLabel.text = model.characterName
        statusLabel.text = model.characterStatusText
        
        model.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
