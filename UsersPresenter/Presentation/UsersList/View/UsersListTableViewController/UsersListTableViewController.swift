//
//  UsersListTableViewController.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 21/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import UIKit

class UsersListTableViewController: UIViewController {

    //private(set)
    var mainTableView: UITableView!
    var viewModel: UsersListViewModel!
    private var usersListDataSource: GenericTableViewDataSource<UsersListItemViewModel, UserTableViewCell>?
    var items: [UsersListItemViewModel]! {
        didSet { reload() }
    }
    var refreshControlView: UIRefreshControl?
    var loadingView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Users"
        mainTableView = UITableView(frame: .zero, style: UITableView.Style.plain)
        view.fillWith(view: mainTableView)
        loadingView = UIActivityIndicatorView(style: .gray)
        loadingView.hidesWhenStopped = true
        view.placeInCenter(view: loadingView)
    }
    
    private func setupTableView() {
        mainTableView.register(cellType: UserTableViewCell.self, reuseIdentifier: UserTableViewCell.description())
        usersListDataSource = GenericTableViewDataSource<UsersListItemViewModel, UserTableViewCell>()
        mainTableView.dataSource = usersListDataSource
        mainTableView.delegate = self
        mainTableView.estimatedRowHeight = 100
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.separatorStyle = .none
        refreshControlView = UIRefreshControl()
        refreshControlView?.addTarget(self, action: #selector(userRefresh), for: UIControl.Event.valueChanged)
        mainTableView.refreshControl = refreshControlView
    }

    func bind(to viewModel: UsersListViewModel) {
        viewModel.route.observe(on: self) { [weak self] in self?.handle($0) }
        viewModel.items.observe(on: self) { [weak self] in self?.items = $0 }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
        viewModel.loadingType.observe(on: self) { [weak self] _ in self?.updateLoadingState() }
    }
    
    func handle(_ route: UsersListViewModelRoute) { }
    

    private func updateLoadingState() {
        switch viewModel.loadingType.value {
        case .none:
            loadingView.isHidden = true
            mainTableView.refreshControl?.endRefreshing()
        case .fullScreen:
            loadingView.startAnimating()
            loadingView.isHidden = false
        }
    }
    
   @objc private func userRefresh() {
        viewModel.didRefresh()
    }
    
    func reload() {
        usersListDataSource?.models = items
        mainTableView.reloadData()
    }

}

extension UsersListTableViewController: Alertable {
    func showError(_ error: String) {
           guard !error.isEmpty else { return }
           showAlert(title: NSLocalizedString("Error", comment: ""), message: error)
       }
}

extension UsersListTableViewController: UITableViewDelegate {

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
