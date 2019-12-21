//
//  GitHubUsersResource.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 17/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation

struct GitHubUsersResource {
    
    private static let url = URL(string: "https://api.github.com/users")!
    
    static func getResource() -> Resource<[GitHubUser]> {
        return Resource<[GitHubUser]>(url: GitHubUsersResource.url,
        parseMethod: GitHubUsersResource.parseData )
    }
    
    static func parseData(_ data: Data) throws -> [GitHubUser] {
        return try JSONDecoder().decode([GitHubUser].self, from: data)
    }
}
