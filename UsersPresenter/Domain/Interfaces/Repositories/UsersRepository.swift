//
//  UsersRepository.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 17/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation

protocol UsersRepository {
    func usersList(completion: @escaping (Result<[User],Error>) -> Void)
}
