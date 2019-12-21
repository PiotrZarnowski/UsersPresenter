//
//  UserExtension.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 19/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation


extension User {
    
    init(gitHubUser: GitHubUser) {
        name = gitHubUser.name
        imagePath = gitHubUser.avatarUrl
        source = UserSource(name: "Git Hub", colorId: 1)
    }
    
    init(dailyMotionUser: DailyMotionUser) {
        name = dailyMotionUser.name
        imagePath = dailyMotionUser.avatarUrl
        source = UserSource(name: "Daily Motion", colorId: 2)
    }
    
    
}
