//
//  FetchUsersUseCase.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 17/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation

protocol FetchUsersUseCase {
    func execute(completion: @escaping (Result<[User], Error>) -> Void)
    }


class DefaultFetchUsersUseCase: FetchUsersUseCase {

    private let usersRepository: UsersRepository
    
    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }
    
    func execute(completion: @escaping (Result<[User], Error>) -> Void) {
         usersRepository.usersList(completion: completion)
      }    
}


