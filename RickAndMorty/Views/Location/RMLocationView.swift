//
//  RMLocationView.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 29.05.23.
//

import UIKit

protocol RMLocationViewDelegate: AnyObject {
    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation)
}
final class RMLocationView: UIView {
    public weak var delegate: RMLocationViewDelegate?
    private var isLoadingMoreLocations = false
  

    private var viewModel: RMLocationViewViewModel? {
        didSet {
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
            }
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.alpha = 0
        table.isHidden = true
        table.register(RMLocationTableViewCell.self, forCellReuseIdentifier: RMLocationTableViewCell.identifier)
        return table
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.style = .large
        return spinner
    }()
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(tableView, spinner)
        spinner.startAnimating()
        addConstraints()
        configureTable()
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    public func configure(with viewModel: RMLocationViewViewModel){
        self.viewModel = viewModel
        
    }
    
    private func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension RMLocationView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cellViewModels = viewModel?.cellViewModels else {
            fatalError()
        }
        guard let locationModel = viewModel?.location(at: indexPath.row) else {
            return
        }
        delegate?.rmLocationView(self, didSelect:locationModel )
        //notify controller of selection
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension RMLocationView:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModels = viewModel?.cellViewModels else {
            fatalError()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMLocationTableViewCell.identifier, for: indexPath) as? RMLocationTableViewCell else {
            fatalError()
        }
        
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
}

extension RMLocationView: UIScrollViewDelegate {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard
                let viewModel = viewModel,
                !viewModel.cellViewModels.isEmpty,
                viewModel.shouldShowLoadMoreIndicator, !isLoadingMoreLocations,
                 
                  let nextUrlString = apiInfo?.next, let url = URL(string: nextUrlString)
            else { return }
            
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {[weak self] t in
                let offset = scrollView.contentOffset.y
                let totalContentHeight = scrollView.contentSize.height
                let totalScrollViewFixedHeight = scrollView.frame.size.height
                if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                    self?.fetchAdditionalCharacters(url: url)
                    
                }
                t.invalidate()
            }
        }
    }
