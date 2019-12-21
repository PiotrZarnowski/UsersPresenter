//
//  MockUserRepository.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 20/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation


class MockUsersRepsitory: UsersRepository {
    
    let users = [User(name: "Stefan", imagePath: "https://avatars0.githubusercontent.com/u/3?v=4", source: UserSource(name: "GitHub", colorId: 1)), User(name: "Mark", imagePath: "https://avatars0.githubusercontent.com/u/4?v=4", source: UserSource(name: "GitHub", colorId: 1)),User(name: "Marta", imagePath: "https://s1.dmcdn.net/d/2000001lFZ7PI/360x360", source: UserSource(name: "DailyMotion", colorId: 2)), User(name: "Marcin", imagePath: "https://s2.dmcdn.net/d/2000001lFZ7PI/360x360", source: UserSource(name: "DailyMotion", colorId: 1))]
    
    
    func usersList(completion: @escaping (Result<[User], Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { //[weak self] in
          //  guard let self = self else {return}
            completion(.success(self.users))
        }
    }
    
    
}
