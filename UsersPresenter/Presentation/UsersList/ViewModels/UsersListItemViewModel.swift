//
//  UsersListItemViewModel.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 20/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation

protocol UsersListItemViewModelOutput {
    var name: String { get }
    var avatarPath: String { get }
    var sourceName: String { get }
    var sourceColorId: Int { get }
}

protocol UsersListItemViewModel: UsersListItemViewModelOutput {}

class DefaultUsersListItemViewModel: UsersListItemViewModel {
    
    var name: String
    var avatarPath: String
    var sourceName: String
    var sourceColorId: Int
    
    init(name: String, avatarPath: String, sourceName: String, sourceColorId: Int) {
        self.name = name
        self.avatarPath = avatarPath
        self.sourceName = sourceName
        self.sourceColorId = sourceColorId
    }

}
