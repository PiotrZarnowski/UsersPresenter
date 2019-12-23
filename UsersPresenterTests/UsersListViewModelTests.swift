//
//  UsersListViewModelTests.swift
//  UsersPresenterTests
//
//  Created by Piotr Żarnowski on 23/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import XCTest

class UsersListViewModelTests: XCTestCase {
    
    class FetchUsersUseCaseMock: FetchUsersUseCase {

        var expectation: XCTestExpectation?
        var error: Error?
        var users = [User(name: "", imagePath: "", source: UserSource(name: "", colorId: 0))]
        
        
        func execute(completion: @escaping (Result<[User], Error>) -> Void) {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(users))
            }
            expectation?.fulfill()
        }
    }

    func test_whenListIsRefreshesedWithSuccess_thenViewModelItemsAreUpdatedWithData() {
        //given
        let fetchUsersUseCaseMock = FetchUsersUseCaseMock()
        fetchUsersUseCaseMock.expectation = self.expectation(description: "fetchUsersUseCaseMock should complete with result")
        let sut = DefaultUsersListViewModel(fetchUsersUseCase: fetchUsersUseCaseMock)
        
        //when
        sut.didRefresh()
        
        //then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(sut.items.value.isEmpty)
    }
}
