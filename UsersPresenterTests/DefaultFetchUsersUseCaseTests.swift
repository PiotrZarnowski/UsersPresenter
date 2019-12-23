//
//  FetchUsersUseCaseTests.swift
//  UsersPresenterTests
//
//  Created by Piotr Żarnowski on 23/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import XCTest

class DefaultFetchUsersUseCaseTests: XCTestCase {
    
    static var users: [User]?
    enum MockError: Error {
        case Error
    }
    
    class SuccessUsersRepositoryMock: UsersRepository {
        func usersList(completion: @escaping (Result<[User], Error>) -> Void) {
            completion(.success(DefaultFetchUsersUseCaseTests.users!))
        }
    }
    
    class FailureUsersRepositoryMock: UsersRepository {
           func usersList(completion: @escaping (Result<[User], Error>) -> Void) {
            completion(.failure(MockError.Error))
           }
       }

    override func setUp() {
        DefaultFetchUsersUseCaseTests.users = [User(name: "Mark", imagePath: "", source: UserSource(name: "GitHub", colorId: 1)), User(name: "Tom", imagePath: "", source: UserSource(name: "DailyMotion", colorId: 2))]
    }

    override func tearDown() {
        DefaultFetchUsersUseCaseTests.users = nil
    }

    func test_whenUseCaseReceivesUsersList_thenPassesThemFurther() {
        //given
        let expectation = self.expectation(description: "Passed users should not be nil")
        let mockUsersRepository = SuccessUsersRepositoryMock()
        let sut = DefaultFetchUsersUseCase(usersRepository: mockUsersRepository)
        var fetchedUsers: [User]?
        
        //when
        sut.execute { result in
            switch result {
            case .success(let users):
                fetchedUsers = users
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        
        //then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertNotNil(fetchedUsers, "Fetched users shouldn't be nil")
        XCTAssertTrue(fetchedUsers! == DefaultFetchUsersUseCaseTests.users!)
    }
    
    func test_whenUseCaseReceivesError_thenPassesItFurther() {
        //given
        let expectation = self.expectation(description: "Passed error should not be nil")
        let mockUsersRepository = FailureUsersRepositoryMock()
        let sut = DefaultFetchUsersUseCase(usersRepository: mockUsersRepository)
        var fetchedError: Error?
        
        //when
        sut.execute { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
               fetchedError = error
               expectation.fulfill()
            }
        }
        
        //then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertNotNil(fetchedError, "Fetched users shouldn't be nil")
    }


}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.name == rhs.name && lhs.imagePath == rhs.imagePath && lhs.source == rhs.source
    }
}

extension UserSource: Equatable {
    static func == (lhs: UserSource, rhs: UserSource) -> Bool {
        lhs.name == rhs.name && lhs.colorId == rhs.colorId
    }
}
