//
//  DefaultUsersRepository.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 18/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation

class DefaultUsersRepository: UsersRepository {
    
    
    private var dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }

    func usersList(completion: @escaping (Result<[User], Error>) -> Void) {
      
        fetchUsers { (gitHubUsers, dailyMotionUsers, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let gitHubUsers = gitHubUsers, let dailyMotionUsers = dailyMotionUsers else {
                completion(.failure(DataTransferError.Error))
                return
            }
            
            let gitHubUsersConverted: [User] = gitHubUsers.map({User(gitHubUser: $0)})
            let dailyMotionUsersConverted: [User] = dailyMotionUsers.usersList.map({User(dailyMotionUser: $0)})
            
            completion(.success(gitHubUsersConverted + dailyMotionUsersConverted))
            return
            
        }
    }

    
    private func fetchUsers(_ completion: @escaping (_ gitHubUsers: [GitHubUser]?, _ dailyMotionUsers: DailyMotionUsersPage?, _ error: Error?) -> Void) {
        
        let usersFetchGroup = DispatchGroup()
        var gitHubUsersResult: Result<[GitHubUser], Error>?
        var dailyMotionUsersResult: Result<DailyMotionUsersPage, Error>?
              
              let fetchGitHubUsersItem = DispatchWorkItem { //[weak self] in
                usersFetchGroup.enter()
//                guard let self = self else {
//                    usersFetchGroup.leave()
//                    return
//                }
                self.dataTransferService.getResource(GitHubUsersResource.getResource()) {  result in
                    gitHubUsersResult = result
                    usersFetchGroup.leave()
                  }
              }
              
              let fetchDailyMotionUsersItem = DispatchWorkItem { //[weak self] in
                usersFetchGroup.enter()
//                guard let self = self else {
//                    usersFetchGroup.leave()
//                    return }
                self.dataTransferService.getResource(DailyMotionUsersPageResource.getResource()) { result in
                      dailyMotionUsersResult = result
                      usersFetchGroup.leave()
                }
            }
        
            let workItems = [fetchGitHubUsersItem, fetchDailyMotionUsersItem]
            for item in workItems {
               
               DispatchQueue.global().async(group: usersFetchGroup, execute: item)
            }
              
              usersFetchGroup.notify(queue: DispatchQueue.global()) {
                
                guard let gitHubUsersResponse = gitHubUsersResult, let dailyMotionUsersResponse = dailyMotionUsersResult else {
                    completion(nil, nil, DataTransferError.Error)
                    return
                    }
                    
                do {
                    let gitHubUsers = try gitHubUsersResponse.get()
                    let dailyMotionUsers = try dailyMotionUsersResponse.get()
                    completion(gitHubUsers, dailyMotionUsers, nil)
                } catch {
                   completion(nil, nil, error)
                }
                
        }
    }
    
}

enum DataTransferError: Error {
    case Error
}
