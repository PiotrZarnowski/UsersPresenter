//
//  DailyMotionUser.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 18/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation


struct DailyMotionUser {
    let name: String
    let avatarUrl: String
}

extension DailyMotionUser: Decodable {
    
    private enum CodingKeys: String, CodingKey {
          case name = "username"
          case avatarUrl = "avatar_360_url"
      }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
    }
}


struct DailyMotionUsersPage {
    let usersList: [DailyMotionUser]
}

extension DailyMotionUsersPage: Decodable {
    
    private enum CodingKeys: String, CodingKey {
          case usersList = "list"
      }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.usersList = try container.decode([DailyMotionUser].self, forKey: .usersList)
    }
}

//extension DailyMotionUsersPage: UsersProvider {
//    func getUsers() -> [User] {
//        return usersList.map({User(dailyMotionUser: $0)})
//    }
//}

