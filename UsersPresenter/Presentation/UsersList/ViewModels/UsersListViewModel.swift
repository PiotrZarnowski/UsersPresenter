//
//  UsersListViewModel.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 20/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation


enum UsersListViewModelRoute {
    case initial
    case showUserDetails(name: String, avatarPath: String, sourceName: String, sourceColorId: Int)
}

enum UsersListViewModelLoading {
    case none
    case fullScreen
}

protocol UseresListViewModelInput {
    func viewDidLoad()
    func didRefresh()
    func didSelect(item: UsersListItemViewModel)
}

protocol UsersListViewModelOutput {
    var route: Observable<UsersListViewModelRoute> { get }
    var items: Observable<[UsersListItemViewModel]> { get }
    var loadingType: Observable<UsersListViewModelLoading> { get }
    var error: Observable<String> { get }
}

protocol UsersListViewModel: UseresListViewModelInput, UsersListViewModelOutput {}

final class DefaultUsersListViewModel: UsersListViewModel {

    private let fetchUsersUseCase: FetchUsersUseCase

    
    let route: Observable<UsersListViewModelRoute> = Observable(.initial)
    let items: Observable<[UsersListItemViewModel]> = Observable([UsersListItemViewModel]())
    let loadingType: Observable<UsersListViewModelLoading> = Observable(.none)
    let error: Observable<String> = Observable("")
    
    @discardableResult
    init(fetchUsersUseCase: FetchUsersUseCase) {
        self.fetchUsersUseCase = fetchUsersUseCase
    }
    
    private func appendUsers(users: [User]) {
        self.items.value = users.map ({
            DefaultUsersListItemViewModel(name: $0.name, avatarPath: $0.imagePath, sourceName: $0.source.name, sourceColorId: $0.source.colorId)
        })
    }
    
    private func resetList() {
        items.value.removeAll()
    }
    
    private func loadUsers(withLoading: UsersListViewModelLoading) {
        loadingType.value = withLoading
        fetchUsersUseCase.execute() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.appendUsers(users: users)
            case .failure(let error):
                self.handle(error: error)
            }
            self.loadingType.value = .none
        }
    }
    
    private func handle(error: Error) {
        self.error.value = error.localizedDescription
    }
    
    private func updateUsers() {
        resetList()
        loadUsers(withLoading: .none)
    }
}


extension DefaultUsersListViewModel {

    func viewDidLoad() {
        loadUsers(withLoading: .fullScreen)
    }
    
    func didRefresh() {
        updateUsers()
    }

    func didSelect(item: UsersListItemViewModel) {
        route.value = .showUserDetails(name: item.name, avatarPath: item.avatarPath, sourceName: item.sourceName, sourceColorId: item.sourceColorId)
    }
}

