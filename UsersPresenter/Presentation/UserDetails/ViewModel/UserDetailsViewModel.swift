//
//  UserDetailsViewModel.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 22/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation

protocol UseresDetailsViewModelInput {
    func viewDidLoad()
}

protocol UserDetailsViewModelOutput {
    var avatarPath: Observable<String> { get }
    var name: Observable<String> { get }
    var userSourceName: Observable<String> { get }
    var userSourceColorId: Observable<Int> { get }
}

protocol UserDetailsViewModel: UseresDetailsViewModelInput, UserDetailsViewModelOutput { }


class DefaultUserDetailsViewModel: UserDetailsViewModel {

     var avatarPath: Observable<String> = Observable("")
     var name: Observable<String> = Observable("")
     var userSourceName: Observable<String> = Observable("")
     var userSourceColorId: Observable<Int> = Observable(0)
    
    init(name: String,
         avatarPath: String,
         userSourceName: String,
         userSourceColorId: Int) {
        self.avatarPath.value = avatarPath
        self.name.value = name
        self.userSourceColorId.value = userSourceColorId
        self.userSourceName.value = userSourceName
    }
    
    func viewDidLoad() {}
}
