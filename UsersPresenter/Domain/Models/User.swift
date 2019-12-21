//
//  User.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 17/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let imagePath: String
    let source: UserSource
}

struct UserSource {
    let name: String
    let colorId: Int
}
