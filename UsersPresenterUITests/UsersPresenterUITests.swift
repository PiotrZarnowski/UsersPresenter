//
//  UsersPresenterUITests.swift
//  UsersPresenterUITests
//
//  Created by Piotr Żarnowski on 17/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import XCTest

class UsersPresenterUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testOpenUserDetails_whenMojomboCellIsTapped_thenUserDetailsNameLabelTextIsMojombo() {
        let app = XCUIApplication()
        app.launch()

        _ = app.cells["mojombo"].waitForExistence(timeout: 3)
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["mojombo"]/*[[".cells.staticTexts[\"mojombo\"]",".staticTexts[\"mojombo\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertEqual(app.staticTexts["mojombo"].label, "mojombo")
    }
}
