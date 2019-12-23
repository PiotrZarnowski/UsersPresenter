//
//  UsersListViewController.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 22/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//


import UIKit

class UsersListViewController: UIViewController {

    var mainTableView: UITableView!
    var viewModel: UsersListViewModel!
    private var usersListDataSource: GenericTableViewDataSource<UserTableViewCell>?
    var items: [UsersListItemViewModel]! {
        didSet { reload() }
    }
    var refreshControlView: UIRefreshControl?
    var loadingView: UIActivityIndicatorView!
    private var usersListViewControllersFactory: UsersListViewControllersFactory!
    
    final class func create(with viewModel: UsersListViewModel,
                               usersListViewControllersFactory: UsersListViewControllersFactory) -> UsersListViewController {
           let view = UsersListViewController()
           view.viewModel = viewModel
           view.usersListViewControllersFactory = usersListViewControllersFactory
           return view
       }
    
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
        loadingView = UIActivityIndicatorView()
        loadingView.hidesWhenStopped = true
        view.placeInCenter(view: loadingView)
    }
    
    private func setupTableView() {
        mainTableView.register(cellType: UserTableViewCell.self, reuseIdentifier: UserTableViewCell.description())
        usersListDataSource = GenericTableViewDataSource<UserTableViewCell>()
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
    
    func handle(_ route: UsersListViewModelRoute) {
        switch route {
        case .showUserDetails(let name, let avatarPath, let sourceName, let sourceColorId):
            let vc = usersListViewControllersFactory.makeUserDetailsViewController(name: name, avatarPath: avatarPath, sourceName: sourceName, sourceColorId: sourceColorId)
            navigationController?.pushViewController(vc, animated: true)
        case .initial:
            break
        }
    }
    

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

extension UsersListViewController: Alertable {
    func showError(_ error: String) {
          // guard !error.isEmpty else { return }
           showAlert(title: NSLocalizedString("Error", comment: ""), message: error)
       }
}

extension UsersListViewController: UITableViewDelegate {

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(item: items[indexPath.row])
    }
}


protocol UsersListViewControllersFactory {
    func makeUserDetailsViewController(name: String,
                                         avatarPath: String,
                                         sourceName: String,
                                         sourceColorId: Int) -> UIViewController
}

