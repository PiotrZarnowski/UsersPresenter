//
//  RepositoryTaskGroup.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 18/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation


struct RepositoryTaskGroup: Cancellable {
    let tasks: [Cancellable?]
    func cancel() {
        tasks.forEach { $0?.cancel()}
    }
}
