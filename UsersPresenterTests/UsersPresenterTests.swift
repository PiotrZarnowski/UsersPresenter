//
//  UsersPresenterTests.swift
//  UsersPresenterTests
//
//  Created by Piotr Żarnowski on 17/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import XCTest
@testable import UsersPresenter

class UsersPresenterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
//    struct WebServiceMock: DataTransferService {
//
//
//
//        func getResource<W>(_ resource: Resource<W>, _ completion: @escaping ((Result<W, Error>) -> ())) {
//
//            let t =
//           // completion(.success())
//        }
//
//
//    }
    
    func test_whenProperDataTransferServiceProvided_shouldReturnProperResponse() {
        //given
        let sut = DefaultUsersRepository(dataTransferService: WebService())
        let expectation = XCTestExpectation(description: "[User] should be returned")
        var usersList: [User]?
        //when
        sut.usersList { result in
            switch result {
            case .success(let users):
               usersList = users
               expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        
        //then
        wait(for: [expectation], timeout: 10)
      //  XCTAssertNil(usersList, "UsersList should not be empty")
        XCTAssertFalse(usersList?.isEmpty ?? true, "UsersList should not be empty")
        XCTAssertGreaterThan(usersList?.count ?? -1, 0)

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
