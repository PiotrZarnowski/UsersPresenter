//
//  DailyMotionUsersPageResource.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 18/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation

struct DailyMotionUsersPageResource{
        
    private static let url = URL(string: "https://api.dailymotion.com/users?fields=avatar_360_url,username")!
    
    static func getResource() -> Resource<DailyMotionUsersPage> {
        return Resource<DailyMotionUsersPage>(url: DailyMotionUsersPageResource.url,
        parseMethod: DailyMotionUsersPageResource.parseData )
    }
    
    static func parseData(_ data: Data) throws -> DailyMotionUsersPage {
        return try JSONDecoder().decode(DailyMotionUsersPage.self, from: data)
    }
}
