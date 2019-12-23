//
//  Resource.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 17/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation

struct Resource<T> {
    
    typealias ParseMethod = ((Data) throws -> T)
    
    let url: URL
    let parseMethod: ParseMethod
    let exceptedStatus: Int
    
    init(url: URL, parseMethod: @escaping ParseMethod, exceptedStatus: Int = 200) {
        self.url = url
        self.parseMethod = parseMethod
        self.exceptedStatus = exceptedStatus
    }
}
