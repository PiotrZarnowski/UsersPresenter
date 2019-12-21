//
//  UserCovertable.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 19/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation


protocol UsersProvider {
    func getUsers()->[User]
}

//protocol UserConvertable {
//    var name: String { get }
//    var avatarUrl: String { get }
//}
