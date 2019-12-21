//
//  GitHubUser.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 17/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation

struct GitHubUser {
    let name: String
    let avatarUrl: String
}

extension GitHubUser: Decodable {
    
    
    private enum CodingKeys: String, CodingKey {
          case name = "login"
          case avatarUrl = "avatar_url"
      }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
    }
}

//extension Array: UsersProvider where Element == GitHubUser {
//    func getUsers() -> [User] {
//        return self.map({User(gitHubUser: $0)})
//    } 
//}

