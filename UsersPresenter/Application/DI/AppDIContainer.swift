//
//  AppDIContainer.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 22/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import UIKit


final class AppDIContainer {

    lazy var dataTransferService: DataTransferService = WebService()

    func makeUsersRepository() -> UsersRepository {
        return DefaultUsersRepository(dataTransferService: dataTransferService)
    }
    
    func makeFetchUsersUseCase() -> FetchUsersUseCase {
        return DefaultFetchUsersUseCase(usersRepository: makeUsersRepository())
    }
    
    func makeUsersListViewModel() -> UsersListViewModel {
        return DefaultUsersListViewModel(fetchUsersUseCase: makeFetchUsersUseCase())
    }
    
    func makeUsersListViewController() -> UsersListViewController {
        return UsersListViewController.create(with: makeUsersListViewModel(), usersListViewControllersFactory: self)
    }
    
    func makeUserDetailsViewModel(name: String,
                                    avatarPath: String,
                                    userSourceName: String,
                                    userSourceColorId: Int) -> UserDetailsViewModel {
        return DefaultUserDetailsViewModel(name: name, avatarPath: avatarPath, userSourceName: userSourceName, userSourceColorId: userSourceColorId)
    }
    
    func makeUserDetailsViewController(name: String, avatarPath: String, sourceName: String, sourceColorId: Int) -> UIViewController {
        return UserDetailsViewController.create(with: makeUserDetailsViewModel(name: name, avatarPath: avatarPath, userSourceName: sourceName, userSourceColorId: sourceColorId))
    }
    
}

extension AppDIContainer: UsersListViewControllersFactory {}
